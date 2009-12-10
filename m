From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH 5/5] omap1: Amstrad Delta: modify defconfig for external keyboard support
Date: Thu, 10 Dec 2009 21:08:42 +0100
Message-ID: <200912102108.45146.jkrzyszt@tis.icnet.pl>
References: <200912102058.43892.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40348 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbZLJUIc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Dec 2009 15:08:32 -0500
In-Reply-To: <200912102058.43892.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The patch adds a CONFIG directive required for supporting the Amstrad Delta
connected external keyboard by default.

Works on top of patch 4/5: input: serio: add support for Amstrad Delta serial
keyboard port

Created and tested against linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c dated 2009-12-02.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---

 arch/arm/configs/ams_delta_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff -uprN git.orig/arch/arm/configs/ams_delta_defconfig git/arch/arm/configs/ams_delta_defconfig
--- git.orig/arch/arm/configs/ams_delta_defconfig	2009-12-10 14:52:50.000000000 +0100
+++ git/arch/arm/configs/ams_delta_defconfig	2009-12-10 14:21:05.000000000 +0100
@@ -701,6 +701,7 @@ CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
+CONFIG_SERIO_AMS_DELTA=y
 # CONFIG_GAMEPORT is not set
 
 #
