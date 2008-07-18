From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: [RFC] OMAP3 Display Driver (V4L2)
Date: Fri, 18 Jul 2008 17:48:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022C16C3D3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:47150 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756239AbYGRMSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 08:18:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel-bounces@lists.sourceforge.net" <linux-fbdev>
Cc: "Gole, Anant" <anantgole@ti.com>, "psp_video@list.ti.com - Video discussion list for PSP Video team (May
	contain non-TIers)" <psp_video@list.ti.com>


RFC- High level design for pushing the V4L2 driver based on TI Soc.

Hardware Background
======================
DSS (Display Sub System) IP on the OMAP3 SoC of TI provides a logic to display a
video frame from the memory frame buffer on a liquid crystal display (LCD) panel
or a TV set. It includes two video pipelines and one graphic pipeline. It also
includes two overlay managers for compositing the pictures from different
pipelines. Below is the high level block diagram of the DSS IP and its
capabilities on OMAP3

video1 pipeline  --|-----------compositor 0--|---TV encoder|-------S Video, composite outputs
video2 pipeline  --|
graphic pipeline --|-----------compositor 1--|---LCD

Note:  Output of all the pipelines can go to any of the compositors.

High level design of the OMAP3 SoC can be found at
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12643&contentId=14649

Frame buffer driver is already there on the GIT controlling the graphic
pipeline.  This is the initial proposal to push the V4L2 display driver onto
GIT for controlling the video pipelines.

This will be done in different phases.

Proposal
============================================================================
As shown in the block diagram compositor number 0 connected to TV will be
controlled by the V4L2 driver and compositor number 1 connected to LCD will be
controlled by FBDEV driver.  FBDEV driver implementation controlling the
graphics pipeline is already there on GIT tree.  V4L2 driver controlling
the video pipelines needs to be pushed. Below is the software implementation
block diagram for the above hardware block diagram.

/dev/video0--|video1 pipeline--|-----------compositor 0--|---TV encoder
/dev/video1--|video2 pipeline--|

Below implementation is already there on GIT tree.

/dev/fb0--|graphics pipeline--|-----------compositor 1--|---LCD

As there is a single compositor between both the video pipelines there will be
some coherency issues like changing the standard on one pipeline will affect the
standard on other one.  omap2_dss.c functional layer will maintain the coherency
between two pipelines for the common hardware like compositor.

Future enhancement is targeted to use both FBDEV and V4L2 drivers using both the
compositors and all the functional level code is in omap2_dss.c and
omap2_venc.c file, so we want omap2_dss.c and omap2_venc.c files to be placed in
architecture directory (arch/arm/plat-omap/). Future enhancements will also
cover all the existing functionality provided by FBDEV driver like RFBI etc.

Since both the driver frame work is different and compositors will be shared by
both (FBDEV and V4L2 drivers) in future enhancements.  There should be some way
of central entity for controlling the compositors. Comments are welcomed on this
design issue.

High Level Design.
===================
Following are the files consisting the TI V4L2 driver.

/arch/arm/plat-omap/omap2_dss.c
===============================
This is a functional layer for the DSS hardware.  It mainly has functions
like configuring the video pipelines, starting the streaming on video pipelines,
setting the color conversion etc.


/arch/arm/plat-omap/omap2_venc.c
=================================
It is a functional layer for the video encoder.  In DSS the encoder is inside
the IP.  This file mainly deals with configuration of the encoder registers
according to the TV standard selected.

For on-board encoders (off-chip) encoder specific file will be in board
directory.

/drivers/media/video/omap/omap2_display.c
==========================================
This is a core V4L2 driver file. It registers two video pipelines with
the V4L2 frame work.  It also implements the necessary ioctls supported
by the V4L2.  It also implements some of the custom ioctls not supported
by V4L2 framework but hardware supports it.


/drivers/media/video/omap/omap2_lib.c
=======================================
This is a library file for the V4L2 driver.  DSS provides some of the
functionalities like cropping, window size and window position.  This
library file helps in setting all the parameters depending upon
the crop window and display window selected. DSS also supports on
the fly scaling so it also calculates the vertical and horizontal
scaling factor depending upon the display and crop window selected.

Thanks and Regards,
Hardik Shah
