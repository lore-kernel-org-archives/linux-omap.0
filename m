From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] i2c: omap: fix NACK and Arbitration Lost irq handling
Date: Tue, 18 Nov 2014 21:00:58 +0400
Message-ID: <1416330058-21473-1-git-send-email-al.kochet@gmail.com>
References: <1416242517-29885-1-git-send-email-al.kochet@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1416242517-29885-1-git-send-email-al.kochet@gmail.com>
Sender: stable-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Alexander Kochetkov <al.kochet@gmail.com>
List-Id: linux-omap@vger.kernel.org

commit 1d7afc95946487945cc7f5019b41255b72224b70 (i2c: omap: ack IRQ in parts)
changed the interrupt handler to complete transfers without clearing
XRDY (AL case) and ARDY (NACK case) flags. XRDY or ARDY interrupts will be
fired again. As a result, ISR keep processing transfer after it was already
complete (from the driver code point of view).

A didn't see real impacts of the 1d7afc9, but it is really bad idea to
have ISR running on user data after transfer was complete.

It looks, what 1d7afc9 violate TI specs in what how AL and NACK should be
handled (see Note 1, sprugn4r, Figure 17-31 and Figure 17-32).

According to specs (if I understood correctly), in case of NACK and AL driver
must reset NACK, AL, ARDY, RDR, and RRDY (Master Receive Mode), and
NACK, AL, ARDY, and XDR (Master Transmitter Mode).

All that is done down the code under the if condition:
if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) ...

The patch restore pre 1d7afc9 logic of handling NACK and AL interrupts, so
no interrupts is fired after ISR informs the rest of driver what transfer
complete.

Note: instead of removing break under NACK case, we could just replace 'break'
with 'continue' and allow NACK transfer to finish using ARDY event. I found
that NACK and ARDY bits usually set together. That case confirm TI wiki:
http://processors.wiki.ti.com/index.php/I2C_Tips#Detecting_and_handling_NACK

In order if someone interested in the event traces for NACK and AL cases,
I sent them to mailing list.

Tested on Beagleboard XM C.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Fixes: 1d7afc9 i2c: omap: ack IRQ in parts
Cc: <stable@vger.kernel.org> # v3.7+

---
 drivers/i2c/busses/i2c-omap.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 90dcc2e..9af7095 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -926,14 +926,12 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
-			break;
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
-			break;
 		}
 
 		/*
-- 
1.7.9.5
