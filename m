From: arno@natisbad.org (Arnaud Ebalard)
Subject: [PATCH] Remove duplicate Kconfig LEDS_LP5521 entry introduced by 67a32ec7
Date: Wed, 24 Jun 2009 10:59:06 +0200
Message-ID: <871vpaj9d1.fsf@small.ssi.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:41229 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757926AbZFXJd0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jun 2009 05:33:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Hi,

While playing with kernel configuration for my N810, I noticed a
duplicate config entry for LEDS_LP5521.

AFAICT, it was added by commit 67a32ec7 (leds: introduce lp5521 led
driver) but the entry was already there from 43350bf4 (leds: lp5521:
move to drivers/leds).

Following patch is against current linux-omap tree.

Cheers,

a+

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/leds/Kconfig |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 788f48c..0493c17 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -170,16 +170,6 @@ config LEDS_LP5521
 	  This driver can be built as a module by choosing 'M'. The module
 	  will be called leds-lp5521.
 
-config LEDS_LP5521
-	tristate "LED Support for the LP5521 LEDs"
-	depends on LEDS_CLASS && I2C
-	help
-	  If you say 'Y' here you get support for the National Semiconductor
-	  LP5521 LED driver used in n8x0 boards.
-
-	  This driver can be built as a module by choosing 'M'. The module
-	  will be called leds-lp5521.
-
 config LEDS_CLEVO_MAIL
 	tristate "Mail LED on Clevo notebook"
 	depends on LEDS_CLASS && X86 && SERIO_I8042 && DMI
-- 
1.6.3.1

