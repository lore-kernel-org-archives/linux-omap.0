From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH RESEND] MAINTAINERS: OMAP: hwmod: update hwmod code, data
 maintainership
Date: Mon, 6 Dec 2010 19:08:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012061908110.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="155748971-328520525-1291687568=:13430"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44330 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab0LGCIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 21:08:54 -0500
Content-ID: <alpine.DEB.2.00.1012061908111.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-328520525-1291687568=:13430
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1012061908112.13430@utopia.booyaka.com>


Add myself and Beno=C3=AEt as co-maintainers of the OMAP hwmod core code.
(The OMAP hwmod code manages the integration of IP blocks on the OMAP SoC
family.)

Add Beno=C3=AEt as the maintainer of OMAP4-based SoC hwmod mode.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---

With the correct address for lakml this time.

 MAINTAINERS |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3be8b3..b10a91c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4329,6 +4329,20 @@ M:=09Deepak Saxena <dsaxena@plexity.net>
 S:=09Maintained
 F:=09drivers/char/hw_random/omap-rng.c
=20
+OMAP HWMOD SUPPORT
+M:=09Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:=09Paul Walmsley <paul@pwsan.com>
+L:=09linux-omap@vger.kernel.org
+S:=09Maintained
+F:=09arch/arm/mach-omap2/omap_hwmod.c
+F:=09arch/arm/plat-omap/include/plat/omap_hwmod.h
+
+OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
+M:=09Beno=C3=AEt Cousson <b-cousson@ti.com>
+L:=09linux-omap@vger.kernel.org
+S:=09Maintained
+F:=09arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+
 OMAP USB SUPPORT
 M:=09Felipe Balbi <balbi@ti.com>
 M:=09David Brownell <dbrownell@users.sourceforge.net>
--=20
1.7.2.3
--155748971-328520525-1291687568=:13430--
