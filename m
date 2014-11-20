From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] MAINTAINERS: add maintainer for OMAP hwmod data
Date: Thu, 20 Nov 2014 18:07:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411201805530.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1165015048-1416506821=:9204"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1165015048-1416506821=:9204
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


I wind up reviewing and committing most of the OMAP hwmod data
patches, so, add myself to MAINTAINERS there so folks will cc me.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Beno=EEt Cousson <bcousson@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c444907ccd69..d904e13a4d54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6716,6 +6716,12 @@ L:=09linux-omap@vger.kernel.org
 S:=09Maintained
 F:=09arch/arm/mach-omap2/omap_hwmod.*
=20
+OMAP HWMOD DATA
+M:=09Paul Walmsley <paul@pwsan.com>
+L:=09linux-omap@vger.kernel.org
+S:=09Maintained
+F:=09arch/arm/mach-omap2/omap_hwmod*data*
+
 OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
 M:=09Beno=EEt Cousson <bcousson@baylibre.com>
 L:=09linux-omap@vger.kernel.org
--=20
2.1.3

--843723315-1165015048-1416506821=:9204--
