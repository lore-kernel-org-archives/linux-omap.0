From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: omapfb: no driver for display error with linux-2.6.37-rc7
Date: Mon, 27 Dec 2010 19:48:35 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB03230E2184@dbde02.ent.ti.com>
References: <6488240A-F0F8-469C-BCD3-B2B27AF51B6C@mac.com>
 <AANLkTik0e2CG4V09PkufJBx-To66UAhoN66wBQmCbUWO@mail.gmail.com>
 <4D33F07F-5093-45BE-A190-26554EE073FD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab0L0OSn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Dec 2010 09:18:43 -0500
In-Reply-To: <4D33F07F-5093-45BE-A190-26554EE073FD@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, Felipe Contreras <felipe.contreras@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe, Elvis,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: Monday, December 27, 2010 11:30 AM
> To: Felipe Contreras
> Cc: Linux OMAP Mailing List
> Subject: Re: omapfb: no driver for display error with linux-2.6.37-rc7
> 
> 
> On Dec 27, 2010, at 4:39 AM, Felipe Contreras wrote:
> 
> 
> >> [    2.175872] omapfb omapfb: no driver for display
[Mayuresh]: This clearly shows that there is something went wrong in registering displays. So OMAPFB has not found any registered displays.

Try passing omapdss.debug=1, omapfb.debug=1 in your bootargs and the log would be self explanatory.

> >> [    2.180999] omapfb omapfb: failed to setup omapfb
> >>
> >> My bootargs are as follows:
> >>
> >> mmcargs=setenv bootargs console=ttyO2,115200n8 vram=12M
> omapfb.vram=0:2M omapfb.mode=480x272MR-16@60 root=/dev/mmcblk0p2 rw
> rootfstype=ext3 rootwait
> >
> > Do you have a proper CONFIG_OMAP2_VRAM_SIZE in your config?
> 
> 
> I've set the VRAM to 12, but the number of framebuffers to 1. Should it be
> > 1 ?
> 
[Mayuresh]: No that should not matter. 12MB of vram for 1 FB is fine.
And your bootargs state that you need 480*272*2 Bytes of memory. So 12 MB of total VRAM size is more than enough.
But your bootargs state that you are providing only 2MB to FB0.
Please try using omapfb.vram=0:5M.
But if the problem is with the memory then OMAPFB would throw an error:
Failed to allocate memory. (Yet your kernel execution has not reached there).

> CONFIG_OMAP2_VRAM_SIZE=12
> CONFIG_FB_OMAP2=y
> CONFIG_FB_OMAP2_NUM_FBS=1
> 
> 
> I've pasted a section of my .config file below. This is with
> omap2plus_defconfig, for  a custom beagleboard.
> 
> 
> #
> # Graphics support
> #
> # CONFIG_DRM is not set
> # CONFIG_VGASTATE is not set
> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> # CONFIG_FB_DDC is not set
> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> # CONFIG_FB_SYS_FILLRECT is not set
> # CONFIG_FB_SYS_COPYAREA is not set
> # CONFIG_FB_SYS_IMAGEBLIT is not set
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> # CONFIG_FB_SYS_FOPS is not set
> # CONFIG_FB_SVGALIB is not set
> # CONFIG_FB_MACMODES is not set
> # CONFIG_FB_BACKLIGHT is not set
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_ARMCLCD is not set
> # CONFIG_FB_UVESA is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_TMIO is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> CONFIG_OMAP2_VRAM=y
> CONFIG_OMAP2_VRFB=y
> CONFIG_OMAP2_DSS=y
> CONFIG_OMAP2_VRAM_SIZE=12
> CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
> # CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
> CONFIG_OMAP2_DSS_DPI=y
> # CONFIG_OMAP2_DSS_RFBI is not set
> CONFIG_OMAP2_DSS_VENC=y
> # CONFIG_OMAP2_DSS_SDI is not set
> # CONFIG_OMAP2_DSS_DSI is not set
> # CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
> CONFIG_FB_OMAP2=y
> # CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
> CONFIG_FB_OMAP2_NUM_FBS=1
> 
> #
> # OMAP2/3 Display Device Drivers
> #
> # CONFIG_PANEL_GENERIC is not set
> # CONFIG_PANEL_SHARP_LS037V7DW01 is not set
> # CONFIG_PANEL_SHARP_LQ043T1DG01 is not set
> # CONFIG_PANEL_TOPPOLY_TDO35S is not set
> # CONFIG_PANEL_TPO_TD043MTEA1 is not set

[Mayuresh]: I guess, you need to enable atleast one panel driver over here.
Try enabling PANEL_GENERIC or SHARP_LS037V7DW01.

> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=y
> # CONFIG_LCD_S6E63M0 is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> # CONFIG_BACKLIGHT_ADP8860 is not set
> 
> #
> # Display device support
> #
> CONFIG_DISPLAY_SUPPORT=y
> 
> #
> # Display hardware drivers
> #
> 
> #
> # Console display driver support
> #
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> # CONFIG_FONT_MINI_4x6 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_10x18 is not set
> # CONFIG_LOGO is not set
> 
> 
> Elvis Dowson
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
