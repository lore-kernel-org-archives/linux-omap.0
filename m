From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] pinctrl: single: Add hardware specific hooks for
 IRQ and GPIO wake-up events
Date: Mon, 10 Jun 2013 08:36:37 -0700
Message-ID: <20130610153637.GK8164@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205040.16513.36794.stgit@localhost>
 <CAN1soZznJ1YxWhaFZ4rhQx+uk3aCigAcVeuLpOU+3oPzmfXF6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17007 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752486Ab3FJPgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 11:36:41 -0400
Content-Disposition: inline
In-Reply-To: <CAN1soZznJ1YxWhaFZ4rhQx+uk3aCigAcVeuLpOU+3oPzmfXF6w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Walleij Linus <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

* Haojian Zhuang <haojian.zhuang@gmail.com> [130608 21:51]:
> 
> I assume that this patch is used in both v1 & v2 version. Since Manjunathappa
> changed the logic of distinguishing bits and pins in blew.
> 
> if (pcs->bits_per_mux)
>       mask = vals->mask;
> else
>      mask = pcs->fmask
> 
> Would you like to sync with his style?

Thanks for catching that, yes that's how it should be now. Updated
patch below.

Regards,

Tony 


From: Tony Lindgren <tony@atomide.com>
Date: Sat, 8 Jun 2013 08:40:35 -0700
Subject: [PATCH] pinctrl: single: Add hardware specific hooks for IRQ and GPIO wake-up events

At least on omaps, each board typically has at least one device
configured as wake-up capable from deeper idle modes. In the
deeper idle modes the normal interrupt wake-up path won't work
as the logic is powered off and separate wake-up hardware is
available either via IO ring or GPIO hardware. The wake-up
event can be device specific, or may need to be dynamically
remuxed to GPIO input for wake-up events. When the wake-up
event happens, it's IRQ need to be called so the device won't
lose interrupts.

Allow supporting IRQ and GPIO wake-up events if a hardware
spefific module is registered for the enable and disable
calls.

Done in collaboration with Roger Quadros <rogerq@ti.com>.

Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index 5a02e30..b95fa6c 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
@@ -69,6 +69,10 @@ Optional properties:
   The number of parameters is depend on #pinctrl-single,gpio-range-cells
   property.
 
+- interrrupts : the interrupt that a function may have for a wake-up event
+
+- gpios: the gpio that a function may have for a wake-up event
+
 		/* pin base, nr pins & gpio function */
 		pinctrl-single,gpio-range = <&range 0 3 0 &range 3 9 1>;
 
@@ -205,6 +209,7 @@ pmx_gpio: pinmux@d401e000 {
 			0xdc 0x118
 			0xde 0
 		>;
+		interrupts = <74>;
 	};
 };
 
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e3b1f76..72efc8e 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -19,6 +19,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -95,6 +97,8 @@ struct pcs_conf_type {
  * @nvals:	number of entries in vals array
  * @pgnames:	array of pingroup names the function uses
  * @npgnames:	number of pingroup names the function uses
+ * @irq:	optional irq associated with the function
+ * @gpio:	optional gpio associated with the function
  * @node:	list node
  */
 struct pcs_function {
@@ -105,6 +109,8 @@ struct pcs_function {
 	int npgnames;
 	struct pcs_conf_vals *conf;
 	int nconfs;
+	int irq;
+	int gpio;
 	struct list_head node;
 };
 
@@ -411,6 +417,18 @@ static int pcs_get_function(struct pinctrl_dev *pctldev, unsigned pin,
 	return 0;
 }
 
+static void pcs_reg_init(struct pcs_reg *p, struct pcs_device *pcs,
+			 struct pcs_function *func,
+			 void __iomem *reg, unsigned val)
+{
+	p->read = pcs->read;
+	p->write = pcs->write;
+	p->irq = func->irq;
+	p->gpio = func->gpio;
+	p->reg = reg;
+	p->val = val;
+}
+
 static int pcs_enable(struct pinctrl_dev *pctldev, unsigned fselector,
 	unsigned group)
 {
@@ -444,6 +462,12 @@ static int pcs_enable(struct pinctrl_dev *pctldev, unsigned fselector,
 		val &= ~mask;
 		val |= (vals->val & mask);
 		pcs->write(val, vals->reg);
+		if ((func->irq || func->gpio) && pcs->soc && pcs->soc->enable) {
+			struct pcs_reg pcsr;
+
+			pcs_reg_init(&pcsr, pcs, func, vals->reg, val);
+			pcs->soc->enable(pcs->soc, &pcsr);
+		}
 	}
 
 	return 0;
@@ -468,18 +492,6 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
 		return;
 	}
 
-	/*
-	 * Ignore disable if function-off is not specified. Some hardware
-	 * does not have clearly defined disable function. For pin specific
-	 * off modes, you can use alternate named states as described in
-	 * pinctrl-bindings.txt.
-	 */
-	if (pcs->foff == PCS_OFF_DISABLED) {
-		dev_dbg(pcs->dev, "ignoring disable for %s function%i\n",
-			func->name, fselector);
-		return;
-	}
-
 	dev_dbg(pcs->dev, "disabling function%i %s\n",
 		fselector, func->name);
 
@@ -490,8 +502,28 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
 		vals = &func->vals[i];
 		val = pcs->read(vals->reg);
 		val &= ~pcs->fmask;
-		val |= pcs->foff << pcs->fshift;
-		pcs->write(val, vals->reg);
+
+		/*
+		 * Ignore disable if function-off is not specified. Some
+		 * hardware does not have clearly defined disable function.
+		 * For pin specific off modes, you can use alternate named
+		 * states as described in pinctrl-bindings.txt.
+		 */
+		if (pcs->foff == PCS_OFF_DISABLED) {
+			dev_dbg(pcs->dev, "ignoring disable for %s function%i\n",
+				func->name, fselector);
+		} else {
+			val |= pcs->foff << pcs->fshift;
+			pcs->write(val, vals->reg);
+		}
+
+		if ((func->irq || func->gpio) &&
+		    pcs->soc && pcs->soc->disable) {
+			struct pcs_reg pcsr;
+
+			pcs_reg_init(&pcsr, pcs, func, vals->reg, val);
+			pcs->soc->disable(pcs->soc, &pcsr);
+		}
 	}
 }
 
@@ -1029,6 +1061,32 @@ static void pcs_add_conf4(struct pcs_device *pcs, struct device_node *np,
 	add_setting(settings, param, ret);
 }
 
+static int pcs_parse_wakeup(struct pcs_device *pcs, struct device_node *np,
+			     struct pcs_function *function)
+{
+	struct pcs_reg pcsr;
+	int i, ret = 0;
+
+	for (i = 0; i < function->nvals; i++) {
+		struct pcs_func_vals *vals;
+		unsigned mask;
+
+		vals = &function->vals[i];
+		if (pcs->bits_per_mux)
+			mask = vals->mask;
+		else
+			mask = pcs->fmask;
+
+		pcs_reg_init(&pcsr, pcs, function, vals->reg,
+			     vals->val & mask);
+		ret = pcs->soc->reg_init(pcs->soc, &pcsr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 			     struct pcs_function *func,
 			     struct pinctrl_map **map)
@@ -1183,6 +1241,24 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	} else {
 		*num_maps = 1;
 	}
+
+	if (pcs->flags & PCS_HAS_FUNCTION_IRQ)
+		function->irq = irq_of_parse_and_map(np, 0);
+
+	if (pcs->flags & PCS_HAS_FUNCTION_GPIO) {
+		function->gpio = of_get_gpio(np, 0);
+		if (function->gpio > 0 && !function->irq) {
+			if (gpio_is_valid(function->gpio))
+				function->irq = gpio_to_irq(function->gpio);
+		}
+	}
+
+	if (function->irq > 0 && pcs->soc && pcs->soc->reg_init) {
+		res = pcs_parse_wakeup(pcs, np, function);
+		if (res)
+			goto free_pingroups;
+	}
+
 	return 0;
 
 free_pingroups:
diff --git a/drivers/pinctrl/pinctrl-single.h b/drivers/pinctrl/pinctrl-single.h
index 18f3205..c2dcc7a 100644
--- a/drivers/pinctrl/pinctrl-single.h
+++ b/drivers/pinctrl/pinctrl-single.h
@@ -1,13 +1,41 @@
+/**
+ * struct pcs_reg - pinctrl register
+ * @read:	pinctrl-single provided register read function
+ * @write:	pinctrl-single provided register write function
+ * @reg:	virtual address of a register
+ * @val:	pinctrl configured value of the register
+ * @irq:	optional irq specified for wake-up for example
+ * @gpio:	optional gpio specified for wake-up for example
+ * @node:	optional list
+ */
+struct pcs_reg {
+	unsigned (*read)(void __iomem *reg);
+	void (*write)(unsigned val, void __iomem *reg);
+	void __iomem *reg;
+	unsigned val;
+	int irq;
+	int gpio;
+	struct list_head node;
+};
+
+#define PCS_HAS_FUNCTION_GPIO   (1 << 2)
+#define PCS_HAS_FUNCTION_IRQ    (1 << 1)
 #define PCS_HAS_PINCONF         (1 << 0)
 
 /**
  * struct pcs_soc - SoC specific interface to pinctrl-single
  * @data:	SoC specific data pointer
  * @flags:	mask of PCS_HAS_xxx values
+ * @reg_init:	SoC specific register init function
+ * @enable:	SoC specific enable function
+ * @disable:	SoC specific disable function
  */
 struct pcs_soc {
 	void *data;
 	unsigned flags;
+	int (*reg_init)(const struct pcs_soc *soc, struct pcs_reg *r);
+	int (*enable)(const struct pcs_soc *soc, struct pcs_reg *r);
+	void (*disable)(const struct pcs_soc *soc, struct pcs_reg *r);
 };
 
 extern int pinctrl_single_probe(struct platform_device *pdev,
