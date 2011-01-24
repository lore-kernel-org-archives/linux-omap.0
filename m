From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC] serial: omap-serial: Enable the UART wake-up bits always
Date: Mon, 24 Jan 2011 17:51:22 +0200
Message-ID: <1295884282-16562-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP can do also dynamic idling so wake-up enable register should be set
also while system is running. If UART_OMAP_WER is not set, then for instance
the RX activity cannot wake up the UART port that is sleeping.

This RX wake-up feature was working when the 8250 driver was used instead
of omap-serial. Reason for this is that the 8250 doesn't set the
UART_OMAP_WER and then arch/arm/mach-omap2/pm34xx.c ends up saving and
restoring the reset default which is the same than value
OMAP_UART_WER_MOD_WKUP here.

Fix this by moving the conditional UART_OMAP_WER write from serial_omap_pm
into serial_omap_startup where wake-up bits are set unconditionally.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
This problem has been here since 2.6.37 when the omap-serial was switched
into use so this patch is for 2.6.39.
---
 drivers/serial/omap-serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
index 7f2f010..d40924a 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
@@ -517,6 +517,9 @@ static int serial_omap_startup(struct uart_port *port)
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
 
+	/* Enable module level wake up */
+	serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
+
 	up->port_activity = jiffies;
 	return 0;
 }
@@ -824,9 +827,6 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
-	/* Enable module level wake up */
-	serial_out(up, UART_OMAP_WER,
-		(state != 0) ? OMAP_UART_WER_MOD_WKUP : 0);
 }
 
 static void serial_omap_release_port(struct uart_port *port)
-- 
1.7.0.4
