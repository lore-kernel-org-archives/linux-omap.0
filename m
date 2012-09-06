From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 04/14] MFD: twl-core: Add API to query the
	HFCLK rate
Date: Thu,  6 Sep 2012 15:12:11 +0300
Message-ID: <1346933541-21547-5-git-send-email-peter.ujfalusi@ti.com>
References: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

CFG_BOOT register's HFCLK_FREQ field hold information about the used HFCLK
frequency.
Add possibility for users to get the configured rate based on this
register.
This register was configured during boot, without it the chip would not
operate correctly, so we can trust on this information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 1c32afe..f162b68 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -552,6 +552,38 @@ int twl_get_version(void)
 }
 EXPORT_SYMBOL_GPL(twl_get_version);
 
+/**
+ * twl_get_hfclk_rate - API to get TWL external HFCLK clock rate.
+ *
+ * Api to get the TWL HFCLK rate based on BOOT_CFG register.
+ */
+int twl_get_hfclk_rate(void)
+{
+	u8 ctrl;
+	int rate;
+
+	twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &ctrl, R_CFG_BOOT);
+
+	switch (ctrl & 0x3) {
+	case HFCLK_FREQ_19p2_MHZ:
+		rate = 19200000;
+		break;
+	case HFCLK_FREQ_26_MHZ:
+		rate = 26000000;
+		break;
+	case HFCLK_FREQ_38p4_MHZ:
+		rate = 38400000;
+		break;
+	default:
+		pr_err("TWL4030: HFCLK is not configured\n");
+		rate = -EINVAL;
+		break;
+	}
+
+	return rate;
+}
+EXPORT_SYMBOL_GPL(twl_get_hfclk_rate);
+
 static struct device *
 add_numbered_child(unsigned chip, const char *name, int num,
 		void *pdata, unsigned pdata_len,
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 7ea898c..ac6488c 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -188,6 +188,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
 int twl_get_type(void);
 int twl_get_version(void);
+int twl_get_hfclk_rate(void);
 
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
-- 
1.7.12
