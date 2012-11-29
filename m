From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 29 Nov 2012 06:53:55 -0800
Message-ID: <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
	<CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
	<50ADE6A5.3030001@ti.com>
	<CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
	<50AF37EA.3080400@ti.com>
	<CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
	<50B4A4D7.2070203@ti.com>
	<CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com>
	<50B74592.3020308@ti.com>
	<CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
	<50B771D3.8050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37899 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab2K2Ox4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 09:53:56 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so13086888obb.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 06:53:56 -0800 (PST)
In-Reply-To: <50B771D3.8050907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Thu, Nov 29, 2012 at 6:31 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

>> It is stock Linux 3.6 (i.e. commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9)
>
> Still can't reproduce. So does the null pointer deref happen at boot
> time? What display related kernel boot options do you have? This looks
> funny, considering lcd43 is a bit smaller lcd:

Yes, it happens at boot time.

The boot options:

[    0.000000] Kernel command line: console=ttyO2,115200n8 mpurate=500
vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapdss.def_disp=lcd43
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

My DSS config options:

#
# Frame buffer hardware drivers
#
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_TMIO is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_OMAP2_VRAM=y
CONFIG_OMAP2_VRFB=y
CONFIG_OMAP2_DSS=y
CONFIG_OMAP2_VRAM_SIZE=12
CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
CONFIG_OMAP2_DSS_DPI=y
# CONFIG_OMAP2_DSS_RFBI is not set
CONFIG_OMAP2_DSS_VENC=y
# CONFIG_OMAP2_DSS_SDI is not set
CONFIG_OMAP2_DSS_DSI=y
CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y
CONFIG_FB_OMAP2=y
CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
CONFIG_FB_OMAP2_NUM_FBS=3

#
# OMAP2/3 Display Device Drivers
#
CONFIG_PANEL_GENERIC_DPI=y
CONFIG_PANEL_TFP410=y
CONFIG_PANEL_LGPHILIPS_LB035Q02=y
CONFIG_PANEL_SHARP_LS037V7DW01=y
# CONFIG_PANEL_NEC_NL8048HL11_01B is not set
# CONFIG_PANEL_PICODLP is not set
# CONFIG_PANEL_TAAL is not set
# CONFIG_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_EXYNOS_VIDEO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_PANDORA is not set


Steve
