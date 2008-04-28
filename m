From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] USB: Generalize usb initialization for omap hw
Date: Mon, 28 Apr 2008 14:02:16 +0300
Message-ID: <20080428110216.GB23224@gandalf.research.nokia.com>
References: <200804241129.28213.david-b@pacbell.net> <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com> <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com> <FCCFB4CDC6E5564B9182F639FC3560872F72C997@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23472 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781AbYD1LDq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 07:03:46 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560872F72C997@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Apr 28, 2008 at 04:29:19PM +0530, ext Pandita, Vikram wrote:
> Hi Filipe
> 
> >-----Original Message-----
> >Create a generic board-file for initializing usb
> >on omap2430 and omap3 boards.
> >
> >Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> >---
> > arch/arm/mach-omap2/Makefile            |    6 +-
> > arch/arm/mach-omap2/board-2430sdp-usb.c |   96 ------------
> > arch/arm/mach-omap2/board-2430sdp.c     |    5 +-
> > arch/arm/mach-omap2/board-3430sdp-usb.c |  241 -------------------------------
> > arch/arm/mach-omap2/board-3430sdp.c     |    5 +-
> > arch/arm/mach-omap2/usb-ehci.c          |  162 +++++++++++++++++++++
> > arch/arm/mach-omap2/usb-musb.c          |  116 +++++++++++++++
> > include/asm-arm/arch-omap/usb-ehci.h    |   35 +++++
> > include/asm-arm/arch-omap/usb-musb.h    |   35 +++++
> > 9 files changed, 360 insertions(+), 341 deletions(-)
> > delete mode 100644 arch/arm/mach-omap2/board-2430sdp-usb.c
> 
> Comment:
> > delete mode 100644 arch/arm/mach-omap2/board-3430sdp-usb.c
> 
> You forgot to carry forward the following copyright notice in new files as you code is a copy from the previously deleted file.
> 
>  * Copyright (C) 2007 Texas Instruments
>  * Author: Vikram Pandita

Sorry for that, could you please send the patch adding such lines?

-- 
	- Balbi
