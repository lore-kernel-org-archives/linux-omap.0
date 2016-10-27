From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] pinctrl: single: Drop custom names
Date: Thu, 27 Oct 2016 07:59:52 -0700
Message-ID: <20161027145951.r6o6zkxa34j253ih@atomide.com>
References: <20161025160900.2724-1-tony@atomide.com>
 <20161025160900.2724-2-tony@atomide.com>
 <20161026141748.vka5vv725nz6ytgf@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161026141748.vka5vv725nz6ytgf@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161026 07:19]:
> * Tony Lindgren <tony@atomide.com> [161025 09:10]:
> > We no longer need to allocate custom names as those are dynamically
> > generated in pinctrl_register_one_pin() if no name is passed to
> > pinctrl_register_pins().
> ...
> 
> > @@ -354,13 +337,16 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
> >  {
> >  	struct pcs_device *pcs;
> >  	unsigned val, mux_bytes;
> > +	unsigned long offset;
> >  
> >  	pcs = pinctrl_dev_get_drvdata(pctldev);
> >  
> >  	mux_bytes = pcs->width / BITS_PER_BYTE;
> > -	val = pcs->read(pcs->base + pin * mux_bytes);
> > +	offset = pin * mux_bytes;
> > +	val = pcs->read(pcs->base + offset);
> >  
> > -	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
> > +	seq_printf(s, "%lx %08x %s ", pcs->res->start + offset, val,
> > +		   DRIVER_NAME);
> >  }
> 
> This should use %zx instead of %lx to avoid build warnings on 64-bit
> systems as reported by kbuild test robot.

Below is an updated version of this patch.

Regards,

Tony

8< ---------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 25 Oct 2016 08:33:34 -0700
Subject: [PATCHv2] pinctrl: single: Drop custom names

We no longer need to allocate custom names as those are dynamically
generated in pinctrl_register_one_pin() if no name is passed to
pinctrl_register_pins().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Use %z instead of %l for 64-bit systems

---
 drivers/pinctrl/pinctrl-single.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -36,7 +36,6 @@
 #define DRIVER_NAME			"pinctrl-single"
 #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
 #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
-#define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 3)
 #define PCS_OFF_DISABLED		~0U
 
 /**
@@ -142,20 +141,6 @@ struct pcs_data {
 };
 
 /**
- * struct pcs_name - register name for a pin
- * @name:	name of the pinctrl register
- *
- * REVISIT: We may want to make names optional in the pinctrl
- * framework as some drivers may not care about pin names to
- * avoid kernel bloat. The pin names can be deciphered by user
- * space tools using debugfs based on the register address and
- * SoC packaging information.
- */
-struct pcs_name {
-	char name[PCS_REG_NAME_LEN];
-};
-
-/**
  * struct pcs_soc_data - SoC specific settings
  * @flags:	initial SoC specific PCS_FEAT_xxx values
  * @irq:	optional interrupt for the controller
@@ -187,7 +172,6 @@ struct pcs_soc_data {
  * @foff:	value to turn mux off
  * @fmax:	max number of functions in fmask
  * @bits_per_pin:number of bits per pin
- * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
  * @pgtree:	pingroup index radix tree
  * @ftree:	function index radix tree
@@ -223,7 +207,6 @@ struct pcs_device {
 	unsigned fmax;
 	bool bits_per_mux;
 	unsigned bits_per_pin;
-	struct pcs_name *names;
 	struct pcs_data pins;
 	struct radix_tree_root pgtree;
 	struct radix_tree_root ftree;
@@ -354,13 +337,17 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 {
 	struct pcs_device *pcs;
 	unsigned val, mux_bytes;
+	unsigned long offset;
+	size_t pa;
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
 	mux_bytes = pcs->width / BITS_PER_BYTE;
-	val = pcs->read(pcs->base + pin * mux_bytes);
+	offset = pin * mux_bytes;
+	val = pcs->read(pcs->base + offset);
+	pa = pcs->res->start + offset;
 
-	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
+	seq_printf(s, "%zx %08x %s ", pa, val, DRIVER_NAME);
 }
 
 static void pcs_dt_free_map(struct pinctrl_dev *pctldev,
@@ -763,7 +750,6 @@ static int pcs_add_pin(struct pcs_device *pcs, unsigned offset,
 {
 	struct pcs_soc_data *pcs_soc = &pcs->socdata;
 	struct pinctrl_pin_desc *pin;
-	struct pcs_name *pn;
 	int i;
 
 	i = pcs->pins.cur;
@@ -786,10 +772,6 @@ static int pcs_add_pin(struct pcs_device *pcs, unsigned offset,
 	}
 
 	pin = &pcs->pins.pa[i];
-	pn = &pcs->names[i];
-	sprintf(pn->name, "%lx.%u",
-		(unsigned long)pcs->res->start + offset, pin_pos);
-	pin->name = pn->name;
 	pin->number = i;
 	pcs->pins.cur++;
 
@@ -827,12 +809,6 @@ static int pcs_allocate_pin_table(struct pcs_device *pcs)
 	if (!pcs->pins.pa)
 		return -ENOMEM;
 
-	pcs->names = devm_kzalloc(pcs->dev,
-				sizeof(struct pcs_name) * nr_pins,
-				GFP_KERNEL);
-	if (!pcs->names)
-		return -ENOMEM;
-
 	pcs->desc.pins = pcs->pins.pa;
 	pcs->desc.npins = nr_pins;
 
-- 
2.9.3
