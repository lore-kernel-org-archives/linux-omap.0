From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Thu,  6 Nov 2014 20:07:30 +0100
Message-ID: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44561 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaKFTHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 14:07:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>

This is mostly an equivalent for the 8250-omap driver based on a patch
of Dave Gerlach for the omap-serial driver (which is not yet merged).

>From his changelog:
|By optionally putting the pins into sleep state in the suspend callback
|we can accomplish two things.
|- minimize current leakage from pins and thus save power,
|- prevent the IP from driving pins output in an uncontrolled manner,
|  which may happen if the power domain drops the domain regulator.

The pinctlr change is put before enable_wakeup logic as per Nishanth
Menon (slightly reworded):
|When wakeup is enabled, I/O daisy chain based wakeup is used by
|reconfiguring the padconfig register. However, this gets overriden by
|sleep/wakeup configuration. Therefore we need first to allow pinctrl to
|play with the wakeup bits as needed beyond the sleep configuration.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 57a8b1241b85..1681875f2996 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1156,6 +1156,7 @@ static int omap8250_suspend(struct device *dev)
 	serial8250_suspend_port(priv->line);
 	flush_work(&priv->qos_work);
 
+	pinctrl_pm_select_sleep_state(dev);
 	if (device_may_wakeup(dev))
 		omap8250_enable_wakeup(priv, true);
 	else
@@ -1167,6 +1168,7 @@ static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 
+	pinctrl_pm_select_default_state(dev);
 	if (device_may_wakeup(dev))
 		omap8250_enable_wakeup(priv, false);
 
-- 
2.1.1

