From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: n810 video
Date: Tue, 02 Nov 2010 11:09:50 +0200
Message-ID: <1288688990.5614.54.camel@tubuntu>
References: <AANLkTinV0PK=77MYkVQF2RRG4g2w_U==pbiO++j7jst-@mail.gmail.com>
	 <AANLkTi=VcyzFBDGyko2RNpbdNhtv0pHKax8X6HnpVNuN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:17226 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317Ab0KBJJS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Nov 2010 05:09:18 -0400
In-Reply-To: <AANLkTi=VcyzFBDGyko2RNpbdNhtv0pHKax8X6HnpVNuN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>, "Maksim A. Boyko" <maksim.a.boyko@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2010-11-01 at 17:07 +0100, ext Grazvydas Ignotas wrote:
> hi,
> 
> On Sat, Oct 30, 2010 at 11:40 AM, Maksim A. Boyko
> <maksim.a.boyko@gmail.com> wrote:
> > Hi,
> >
> > I try to switch on "OMAP2/3 Display Subsystem Support" and "Omap frame
> > buffer support" on n810  (commit 8b4b01).
> >
> > In OMAP2/3 Display Subsystem Support I used:
> > CONFIG_OMAP2_VRAM_SIZE=4
> > CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
> > CONFIG_OMAP2_DSS_DPI=y
> > CONFIG_OMAP2_DSS_VENC=y
> > CONFIG_PANEL_GENERIC=y
> >
> > In Omap frame buffer support I used:
> > CONFIG_FB=y
> > CONFIG_FB_OMAP_LCDC_EXTERNAL=y
> > CONFIG_FB_OMAP_LCDC_BLIZZARD=y
> > CONFIG_FB_OMAP_LCD_MIPID=y
> > CONFIG_FB_OMAP_BOOTLOADER_INIT=y
> > CONFIG_FB_OMAP=y
> > CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
> >
> > I create fb device:
> > #mknod /dev/fb0 c 29 0
> > #chgrp video  /dev/fb0
> > #chmod 660  /dev/fb0
> >
> > But XServer 1.7.7-8 from debian squeeze armel don't work in both
> > cases. Tail of Xorg.0.log
> >
> > (II) LoadModule: "omapfb"
> > (II) Loading /usr/lib/xorg/modules/drivers/omapfb_drv.so
> > (II) Module omapfb: vendor="X.Org Foundation"
> >        compiled for 1.7.4, module version = 0.1.1
> >        ABI class: X.Org Video Driver, version 6.0
> > (II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD controllers:
> >        omap1/2/3, S1D13745, HWA742
> > (WW) Falling back to old probe method for OMAPFB
> > (WW) Could not open '/dev/fb0': No such device or address(EE) No
> > devices detected
> 
> The kernel driver probably failed to start, check your dmesg. I guess
> you'll need to update arch/arm/mach-omap2/board-n8x0.c and add dss2
> platform_data (see other board-* files for some examples).

Unfortunately there's no support in DSS2 for N800's Blizzard chip, so
you'll have to use the older omapfb driver. Or alternatively port the
Blizzard driver to DSS2, and probably make some fixes for DSS2's RFBI
support.

 Tomi


