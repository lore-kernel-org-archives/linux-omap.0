From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 2/2] [Resend] OMAP: ams_delta_defconfig: enable LCD class device support
Date: Fri, 11 Dec 2009 14:21:51 +0100
Message-ID: <200912111421.52555.jkrzyszt@tis.icnet.pl>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl> <200912111255.48176.jkrzyszt@tis.icnet.pl> <1260533259.10417.3.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:50023 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391AbZLKNVm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:21:42 -0500
In-Reply-To: <1260533259.10417.3.camel@tubuntu.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The patch enables LCD class device support in ams_delta_defconfig in or=
der to
get optional contrast control functional.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
=46riday 11 December 2009 13:07:39 Tomi Valkeinen napisa=C5=82(a):
> On Fri, 2009-12-11 at 12:55 +0100, ext Janusz Krzysztofik wrote:
> >
> > Am I supposed to do anything about this series[1]? Resend to you?
>
> Yes, please resend to me. I don't seem to have the patches in my mail=
box
> anymore.

--- a/arch/arm/configs/ams_delta_defconfig	2009-11-14 23:48:40.00000000=
0 +0100
+++ b/arch/arm/configs/ams_delta_defconfig	2009-11-16 01:06:12.00000000=
0 +0100
@@ -836,7 +836,8 @@
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
+CONFIG_LCD_CLASS_DEVICE=3Dy
=20
 #
 # Display device support



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
