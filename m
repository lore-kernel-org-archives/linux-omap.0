From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 04/14] MFD: twl-core: Add API to query the HFCLK rate
Date: Tue, 14 Aug 2012 17:22:32 +0300
Message-ID: <1344954162-7985-5-git-send-email-peter.ujfalusi@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1344954162-7985-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

CFG_BOOT register's HFCLK_FREQ field hold information about the used HFCLK
frequency.
Add possibility for users to get the configured rate based on this
register.
This register was configured during boot, without it the chip would not
operate correctly, so we can trust on this information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/twl-core.c  |   32 ++++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)

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
1.7.8.6
