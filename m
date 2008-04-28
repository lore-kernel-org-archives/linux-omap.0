From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] USB: Generalize usb initialization for omap hw
Date: Mon, 28 Apr 2008 16:29:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560872F72C997@dbde02.ent.ti.com>
References: <200804241129.28213.david-b@pacbell.net>
 <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com>
 <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:45813 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793AbYD1LB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 07:01:27 -0400
In-Reply-To: <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Filipe

>-----Original Message-----
>Create a generic board-file for initializing usb
>on omap2430 and omap3 boards.
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>---
> arch/arm/mach-omap2/Makefile            |    6 +-
> arch/arm/mach-omap2/board-2430sdp-usb.c |   96 ------------
> arch/arm/mach-omap2/board-2430sdp.c     |    5 +-
> arch/arm/mach-omap2/board-3430sdp-usb.c |  241 -------------------------------
> arch/arm/mach-omap2/board-3430sdp.c     |    5 +-
> arch/arm/mach-omap2/usb-ehci.c          |  162 +++++++++++++++++++++
> arch/arm/mach-omap2/usb-musb.c          |  116 +++++++++++++++
> include/asm-arm/arch-omap/usb-ehci.h    |   35 +++++
> include/asm-arm/arch-omap/usb-musb.h    |   35 +++++
> 9 files changed, 360 insertions(+), 341 deletions(-)
> delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c

Comment:
> delete mode 100644 arch/arm/mach-omap2/board-3430sdp-usb.c

You forgot to carry forward the following copyright notice in new files as you code is a copy from the previously deleted file.

 * Copyright (C) 2007 Texas Instruments
 * Author: Vikram Pandita


> create mode 100644 arch/arm/mach-omap2/usb-ehci.c
> create mode 100644 arch/arm/mach-omap2/usb-musb.c
> create mode 100644 include/asm-arm/arch-omap/usb-ehci.h
> create mode 100644 include/asm-arm/arch-omap/usb-musb.h
>
