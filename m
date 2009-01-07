From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: [RFC] OMAP3EVM Multi-Media Daughter Card Support
Date: Wed, 7 Jan 2009 11:36:48 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECEDD5E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758169AbZAGGHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 01:07:14 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

Hi,

This RFC provides high level design/changes for supporting Multi-Media/Mass-Market/Mistral/Customer Daughter card based on OMAP3 EVM.

Background
==========
OMAP3 EVM doesn't support camera interface, TI and Mistral has developed 
Daughter card on top of OMAP3 EVM which will add support for 

    - TVP5146 decoder, providing BT656 capture support through S-Video/Component/Composite input.
    - Camera/sensor interface (Micron)
    - HSUSB Transceiver USB-83320

Soon the block-diagram, schematics and other details will be available publicly.

Hardware Block Diagram
======================
Below is top level block diagram for the OMAP3 EVM Multi-Media Daughter Card -

  
 
 OMAP 3 Processor                      Multi-Media Daughter Card
    Board
 - - - - - - -               - - - - - - -- - - - - - - - - - - - - - 
| OMAP3530    |             |            - - - - - - <------O S-Vid  |
|             |             |           |           |                |
|         I2C |------------------------>|           |      |O|       |
|             |             |           |           |<-----|O|Compo  |
|             |             |   /|      |  Video    |      |O|site   |
|             |             |  | |      |  Decoder  |                |
|             |             |  | |<-----|  TVP5146  |      |O|       |
|      Camera |             |  | |       - - - - - - <-----|O|Compo  |
|    interface|<---------------| |                         |O|nent   |
|             |             |  | |       - - - - - -                 |
|             |             |  | |<-----|           |                |
|             |             |  | |      |  Micron   |                |
|             |             |  | |      |  Image    |                |
|             |             |   \|      |  Sensor   |                |
|         I2C |------------------------>|           |                |
|             |             |            - - - - - -                 |
|             |             |                                        |
|        HSUSB|             |            - - - - - -                 |
|         HOST|<----------------------->|           |                |
 - - - - - - -              |           |   HSUSB   |                |
                            |           |Transceiver|                |
                            |           |  USB83320 |                |
                            |           |           |                |
                            |            - - - - - -                 |
                            |                                        |
                            |                                        |
                             - - - - - - -- - - - - - - - - - - - - -
                                       
High Level-Software Design
=========================

Following are the files which will add support for Daughter Card -

    - arch/arm/mach-omap2/board-omap3evm-dc.c
        Source file which will handle initialization of the GPMC and similar stuff, registers to the I2C framework for I2C bus 3(TVP5146 interface).
      
    - arch/arm/mach-omap2/board-omap3evm-dc.h
        Corresponding Header file.
        
        
Current implementation/support available
========================================

The basic Daughter card support has been added to the latest git kernel; soon I will be posting the patches for review.

Following things have been tested - 
    - TVP5146: (On top of Sergio's ISP-Camera patch-sets)
        - S-Video
        - Composite
        
    - HSUSB:
        Basic functionality is working.

NOTE: Please note that all the above testing is done on top of ES2.0 silicon version.

TODO - 
    - Component support (Should be very easy)
    - Rigorous testing of TVP5146 and HSUSB.
    - Camera/sensor support

Thanks,
Vaibhav Hiremath

