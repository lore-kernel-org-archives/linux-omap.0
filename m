From: felipe.balbi@nokia.com
Subject: [RFC PATCH 21/37] cbus: tahvo: move EXPORT_SYMBOL macros closer to functions
Date: Wed,  7 Apr 2010 19:04:12 +0300
Message-ID: <1270656268-7034-22-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62334 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848Ab0DGQFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:21 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G56B4007315
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:20 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

No functional changes but it avoids having to look for which
symbols are exported.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 20b6f15..e14108f 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -83,6 +83,7 @@ int tahvo_read_reg(unsigned reg)
 	BUG_ON(!tahvo_initialized);
 	return cbus_read_reg(TAHVO_ID, reg);
 }
+EXPORT_SYMBOL(tahvo_read_reg);
=20
 /**
  * tahvo_write_reg - Write a value to a register in Tahvo
@@ -96,6 +97,7 @@ void tahvo_write_reg(unsigned reg, u16 val)
 	BUG_ON(!tahvo_initialized);
 	cbus_write_reg(TAHVO_ID, reg, val);
 }
+EXPORT_SYMBOL(tahvo_write_reg);
=20
 /**
  * tahvo_set_clear_reg_bits - set and clear register bits atomically
@@ -131,6 +133,7 @@ void tahvo_disable_irq(int id)
 	tahvo_write_reg(TAHVO_REG_IMR, mask);
 	spin_unlock_irqrestore(&tahvo_lock, flags);
 }
+EXPORT_SYMBOL(tahvo_disable_irq);
=20
 /*
  * Enable given TAHVO interrupt
@@ -146,6 +149,7 @@ void tahvo_enable_irq(int id)
 	tahvo_write_reg(TAHVO_REG_IMR, mask);
 	spin_unlock_irqrestore(&tahvo_lock, flags);
 }
+EXPORT_SYMBOL(tahvo_enable_irq);
=20
 /*
  * Acknowledge given TAHVO interrupt
@@ -154,6 +158,7 @@ void tahvo_ack_irq(int id)
 {
 	tahvo_write_reg(TAHVO_REG_IDR, 1 << id);
 }
+EXPORT_SYMBOL(tahvo_ack_irq);
=20
 static int tahvo_7bit_backlight;
=20
@@ -167,6 +172,7 @@ int tahvo_get_backlight_level(void)
 		mask =3D 0x0f;
 	return tahvo_read_reg(TAHVO_REG_LEDPWMR) & mask;
 }
+EXPORT_SYMBOL(tahvo_get_backlight_level);
=20
 int tahvo_get_max_backlight_level(void)
 {
@@ -175,6 +181,7 @@ int tahvo_get_max_backlight_level(void)
 	else
 		return 0x0f;
 }
+EXPORT_SYMBOL(tahvo_get_max_backlight_level);
=20
 void tahvo_set_backlight_level(int level)
 {
@@ -185,6 +192,7 @@ void tahvo_set_backlight_level(int level)
 		level =3D max_level;
 	tahvo_write_reg(TAHVO_REG_LEDPWMR, level);
 }
+EXPORT_SYMBOL(tahvo_set_backlight_level);
=20
 /*
  * TAHVO interrupt handler. Only schedules the tasklet.
@@ -263,6 +271,7 @@ int tahvo_request_irq(int id, void *irq_handler, un=
signed long arg, char *name)
=20
 	return 0;
 }
+EXPORT_SYMBOL(tahvo_request_irq);
=20
 /*
  * Unregister the handler for a given TAHVO interrupt source.
@@ -285,6 +294,7 @@ void tahvo_free_irq(int id)
 	tahvo_disable_irq(id);
 	hnd->func =3D NULL;
 }
+EXPORT_SYMBOL(tahvo_free_irq);
=20
 /**
  * tahvo_probe - Probe for Tahvo ASIC
@@ -434,17 +444,6 @@ static void __exit tahvo_exit(void)
 	wait_for_completion(&device_release);
 }
=20
-EXPORT_SYMBOL(tahvo_request_irq);
-EXPORT_SYMBOL(tahvo_free_irq);
-EXPORT_SYMBOL(tahvo_enable_irq);
-EXPORT_SYMBOL(tahvo_disable_irq);
-EXPORT_SYMBOL(tahvo_ack_irq);
-EXPORT_SYMBOL(tahvo_read_reg);
-EXPORT_SYMBOL(tahvo_write_reg);
-EXPORT_SYMBOL(tahvo_get_backlight_level);
-EXPORT_SYMBOL(tahvo_get_max_backlight_level);
-EXPORT_SYMBOL(tahvo_set_backlight_level);
-
 subsys_initcall(tahvo_init);
 module_exit(tahvo_exit);
=20
@@ -453,3 +452,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Juha Yrj=F6l=E4");
 MODULE_AUTHOR("David Weinehall");
 MODULE_AUTHOR("Mikko Ylinen");
+
--=20
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
