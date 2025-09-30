/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.persistenciajpa;

import Logica.Alumno;
import Logica.ControladoraLogica;
import Persistencia.ControladoraPersistencia;
import java.util.Date;

/**
 *
 * @author DELL
 */
public class PersistenciaJPA {

    public static void main(String[] args) {
       ControladoraLogica control = new ControladoraLogica();
       Alumno alumno1 = new Alumno(15, "Carlos", "Lopez", new Date());
       control.crearAlumno(alumno1);
    
    }
}
