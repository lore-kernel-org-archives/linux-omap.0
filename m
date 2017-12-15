From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] bus: ti-sysc: Detect i2c interconnect target module based on register layout
Date: Fri, 15 Dec 2017 10:08:57 -0800
Message-ID: <20171215180900.3243-7-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215180900.3243-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can easily detect i2c based on it's non-standard module registers that
consist of two 32-bit registers accessed in 16-bit mode.

So far we don't have other 16-bit modules, so there's currently no need
to add a custom property for 16-bit register access.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 17 +++++++++++++++++
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -213,6 +213,21 @@ static int sysc_check_children(struct sysc *ddata)
 	return 0;
 }
 
+/*
+ * So far only I2C uses 16-bit read access with clockactivity with revision
+ * in two registers with stride of 4. We can detect this based on the rev
+ * register size to configure things far enough to be able to properly read
+ * the revision register.
+ */
+static void sysc_check_quirk_16bit(struct sysc *ddata, struct resource *res)
+{
+	if (resource_size(res) == 8) {
+		dev_dbg(ddata->dev,
+			"enabling 16-bit and clockactivity quirks\n");
+		ddata->cfg.quirks |= SYSC_QUIRK_16BIT | SYSC_QUIRK_USE_CLOCKACT;
+	}
+}
+
 /**
  * sysc_parse_one - parses the interconnect target module registers
  * @ddata: device driver data
@@ -243,6 +258,8 @@ static int sysc_parse_one(struct sysc *ddata, enum sysc_registers reg)
 	}
 
 	ddata->offsets[reg] = res->start - ddata->module_pa;
+	if (reg == SYSC_REVISION)
+		sysc_check_quirk_16bit(ddata, res);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -41,6 +41,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_QUIRK_16BIT		BIT(2)
 #define SYSC_QUIRK_UNCACHED		BIT(1)
 #define SYSC_QUIRK_USE_CLOCKACT		BIT(0)
 
-- 
2.15.0
