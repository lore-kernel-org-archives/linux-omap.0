From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Build break on mainline tree for 3430 SDP
Date: Thu, 24 Sep 2009 19:04:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9E7DA8A@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C58F1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58161 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbZIXNeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 09:34:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8ODY6A0002038
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 08:34:07 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8ODY6FF028228
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 19:04:06 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C58F1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Gadiyar, Anand
>Sent: Thursday, September 24, 2009 6:08 AM
>To: linux-omap@vger.kernel.org
>Subject: Build break on mainline tree for 3430 SDP
>
>Build break compiling Linus' git tree for 3430 SDP.
>
>I get this with the default SDP config. Haven't looked at the
>code yet to find a fix.
>
>- Anand
>
>  CC      arch/arm/mach-omap2/board-3430sdp.o
>In file included from arch/arm/mach-omap2/board-3430sdp.c:41:
>arch/arm/plat-omap/include/mach/keypad.h:38:1: warning: "KEY" redefined
>In file included from include/linux/i2c/twl4030.h:29,
>                 from arch/arm/mach-omap2/board-3430sdp.c:22:
>include/linux/input/matrix_keypad.h:10:1: warning: this is the location of the previous definition
>In file included from arch/arm/mach-omap2/board-3430sdp.c:41:
>arch/arm/plat-omap/include/mach/keypad.h:39:1: warning: "PERSISTENT_KEY" redefined
>In file included from arch/arm/mach-omap2/board-3430sdp.c:22:
>include/linux/i2c/twl4030.h:356:1: warning: this is the location of the previous definition
>arch/arm/mach-omap2/board-3430sdp.c:94: error: unknown field 'keymap' specified in initializer
>arch/arm/mach-omap2/board-3430sdp.c:94: warning: the address of 'sdp3430_keymap' will always evaluate
>as 'true'
>arch/arm/mach-omap2/board-3430sdp.c:95: error: unknown field 'keymapsize' specified in initializer
>arch/arm/mach-omap2/board-3430sdp.c:95: warning: excess elements in struct initializer
>arch/arm/mach-omap2/board-3430sdp.c:95: warning: (near initialization for 'sdp3430_kp_data')
>make[1]: *** [arch/arm/mach-omap2/board-3430sdp.o] Error 1
>make: *** [arch/arm/mach-omap2] Error 2

Linus tree has more up-to-date commit on include/linux/i2c/twl4030.h
That changes the keymap interface. 
	const struct matrix_keymap_data *keymap_data;

See the highlighted line below.
All boards may have to adapt to the new keymap interface.

commit 9d8340687c524ce61e3c9c76758c4c81303acfc0
Author: David Brownell <dbrownell@users.sourceforge.net>
Date:   Tue Aug 25 19:24:14 2009 -0700

    Input: add twl4030_keypad driver

    Add a driver for the keypad controller on TWL4030 family chips.
    These support up to an 8x8 key matrix.  The TWL4030 multifunction
    chips are mostly used on OMAP3 (or OMAP 2430) based boards.

>>>>    [dtor@mail.ru: switch to matrix-keypad framework, fix changing
    keymap from userspace]
    Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

