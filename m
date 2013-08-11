From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 1/1] =?UTF-8?q?MAINTAINERS:=20update=20Beno=C3=AEt=20Cousson?= =?UTF-8?q?=20email=20address?=
Date: Sun, 11 Aug 2013 17:21:05 +0200
Message-ID: <1376234465-15476-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:55871 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab3HKPVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Aug 2013 11:21:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Using the email address listed on MAINTAINERS I keep
getting SMTP 550 Invalid recipient errors.

Update with what seems to be current Beno=C3=AEt's email
address to make get_maintainer.pl to stop lying.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.u=
k>
---

Patch on top of Linus's commit c095ba72 ("Linux 3.11-rc4").

Changes since v1:
 - I mostly send DT patches to Beno=C3=AEt but now I noticed that
   he also maintains other subsystems. Update the patch to
   change all his MAINTAINERS entries.

 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index defc053..3466423 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5879,7 +5879,7 @@ F:	drivers/i2c/busses/i2c-omap.c
 F:	include/linux/i2c-omap.h
=20
 OMAP DEVICE TREE SUPPORT
-M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
 M:	Tony Lindgren <tony@atomide.com>
 L:	linux-omap@vger.kernel.org
 L:	devicetree@vger.kernel.org
@@ -5959,14 +5959,14 @@ S:	Maintained
 F:	drivers/char/hw_random/omap-rng.c
=20
 OMAP HWMOD SUPPORT
-M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod.*
=20
 OMAP HWMOD DATA FOR OMAP4-BASED DEVICES
-M:	Beno=C3=AEt Cousson <b-cousson@ti.com>
+M:	Beno=C3=AEt Cousson <benoit.cousson@linaro.org>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--=20
1.7.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
