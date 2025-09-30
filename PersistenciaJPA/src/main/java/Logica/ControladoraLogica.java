/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Logica;

import Persistencia.ControladoraPersistencia;

/**
 *
 * @author DELL
 */
public class ControladoraLogica {

    ControladoraPersistencia CP = new ControladoraPersistencia();

    public void crearAlumno(Alumno alu) {
        CP.crearAlumno(alu);
    }
}
