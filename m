From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] MAINTAINERS: Add an entry for omap related .dts files
Date: Fri, 14 Dec 2012 11:44:52 -0800
Message-ID: <20121214194452.9874.40037.stgit@muffinssi.local>
References: <20121214194325.9874.95898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63257 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932254Ab2LNTo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 14:44:56 -0500
In-Reply-To: <20121214194325.9874.95898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

All your omap .dts files are belong to us.

Beno=C3=AEt has been doing a good job picking up most of the
omap .dts files so far. Let's make sure we both get
cc:ed for the related patches.

The .dts patches need to be queued by us as separate
patches from drivers and other code changes to avoid
pointless merge conflists like we saw with v3.8
networking changes.

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc485c..4927e80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5253,6 +5253,15 @@ F:	arch/arm/*omap*/
 F:	drivers/i2c/busses/i2c-omap.c
 F:	include/linux/i2c-omap.h
=20
+OMAP DEVICE TREE SUPPORT
+M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Tony Lindgren <tony@atomide.com>
+L:	linux-omap@vger.kernel.org
+L:	devicetree-discuss@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/*omap*
+F:	arch/arm/boot/dts/*am3*
+
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
