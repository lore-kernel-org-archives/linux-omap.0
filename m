From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: n810 video
Date: Mon, 1 Nov 2010 18:07:15 +0200
Message-ID: <AANLkTi=VcyzFBDGyko2RNpbdNhtv0pHKax8X6HnpVNuN@mail.gmail.com>
References: <AANLkTinV0PK=77MYkVQF2RRG4g2w_U==pbiO++j7jst-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63203 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab0KAQHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Nov 2010 12:07:17 -0400
Received: by gxk23 with SMTP id 23so3283345gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Nov 2010 09:07:16 -0700 (PDT)
In-Reply-To: <AANLkTinV0PK=77MYkVQF2RRG4g2w_U==pbiO++j7jst-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Maksim A. Boyko" <maksim.a.boyko@gmail.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

hi,

On Sat, Oct 30, 2010 at 11:40 AM, Maksim A. Boyko
<maksim.a.boyko@gmail.com> wrote:
> Hi,
>
> I try to switch on "OMAP2/3 Display Subsystem Support" and "Omap fram=
e
> buffer support" on n810 =A0(commit 8b4b01).
>
> In OMAP2/3 Display Subsystem Support I used:
> CONFIG_OMAP2_VRAM_SIZE=3D4
> CONFIG_OMAP2_DSS_DEBUG_SUPPORT=3Dy
> CONFIG_OMAP2_DSS_DPI=3Dy
> CONFIG_OMAP2_DSS_VENC=3Dy
> CONFIG_PANEL_GENERIC=3Dy
>
> In Omap frame buffer support I used:
> CONFIG_FB=3Dy
> CONFIG_FB_OMAP_LCDC_EXTERNAL=3Dy
> CONFIG_FB_OMAP_LCDC_BLIZZARD=3Dy
> CONFIG_FB_OMAP_LCD_MIPID=3Dy
> CONFIG_FB_OMAP_BOOTLOADER_INIT=3Dy
> CONFIG_FB_OMAP=3Dy
> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D2
>
> I create fb device:
> #mknod /dev/fb0 c 29 0
> #chgrp video =A0/dev/fb0
> #chmod 660 =A0/dev/fb0
>
> But XServer 1.7.7-8 from debian squeeze armel don't work in both
> cases. Tail of Xorg.0.log
>
> (II) LoadModule: "omapfb"
> (II) Loading /usr/lib/xorg/modules/drivers/omapfb_drv.so
> (II) Module omapfb: vendor=3D"X.Org Foundation"
> =A0 =A0 =A0 =A0compiled for 1.7.4, module version =3D 0.1.1
> =A0 =A0 =A0 =A0ABI class: X.Org Video Driver, version 6.0
> (II) omapfb: Driver for OMAP framebuffer (omapfb) and external LCD co=
ntrollers:
> =A0 =A0 =A0 =A0omap1/2/3, S1D13745, HWA742
> (WW) Falling back to old probe method for OMAPFB
> (WW) Could not open '/dev/fb0': No such device or address(EE) No
> devices detected

The kernel driver probably failed to start, check your dmesg. I guess
you'll need to update arch/arm/mach-omap2/board-n8x0.c and add dss2
platform_data (see other board-* files for some examples).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
