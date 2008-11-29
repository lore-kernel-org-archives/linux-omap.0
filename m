From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 07/12] i2c-omap: Don't compile in OMAP15xx I2C ISR for
	non-OMAP15xx builds
Date: Fri, 28 Nov 2008 17:34:37 -0800
Message-ID: <20081129013437.13428.62885.stgit@localhost>
References: <20081129013318.13428.88465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081129013318.13428.88465.stgit@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
of text for most OMAP builds.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 61d2e5a..195c3d1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -503,6 +503,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
 	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
 }
 
+/* rev1 devices are apparently only on some 15xx */
+#ifdef CONFIG_ARCH_OMAP15XX
+
 static irqreturn_t
 omap_i2c_rev1_isr(int this_irq, void *dev_id)
 {
@@ -557,6 +560,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+#else
+#define omap_i2c_rev1_isr		0
+#endif
 
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
