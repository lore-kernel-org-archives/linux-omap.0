From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [RFC 1/3] OMAP: clocks: Use clk names instead of clk pointers
Date: Thu, 20 Jan 2011 11:03:38 +0530
Message-ID: <504b9356bcc91cc2316b1623095e4f64@mail.gmail.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com>
 <1295446466-23655-2-git-send-email-rnayak@ti.com> <20110119151924.GA3552@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:58398 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461Ab1ATFdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 00:33:42 -0500
Received: by mail-fx0-f49.google.com with SMTP id 19so222626fxm.22
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 21:33:40 -0800 (PST)
In-Reply-To: <20110119151924.GA3552@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Wednesday, January 19, 2011 8:49 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com;
khilman@deeprootsystems.com
> Subject: Re: [RFC 1/3] OMAP: clocks: Use clk names instead of clk
pointers
>
> On Wed, Jan 19, 2011 at 07:44:24PM +0530, Rajendra Nayak wrote:
> > There are various instances of clk pointers being
> > embedded within structures in the clock framework
> > to refer to clk parents, reference clocks, bypass
> > clocks etc.
> > The right way to reference these is by their name
> > and not by embedding direct pointers to these clks.
> >
> > Hence make provision to be able to provide clock
> > names to refer to parents and bypass/ref clks and
> > populate the clk pointers at runtime.
> >
> > This requires the const qualifier to be dropped for
> > struct clksel within struct clk and hence needs
> > clksel struct definitions to be changed in all
> > clock*_data.c files.
>
> $SUBJECT and this commit log is completely wrong as this patch is only
> dropping the const from the clock structures.

Did you look at this part of the patch?

------->
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index fc62fb5..9bfd193 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -308,6 +308,16 @@ void clk_enable_init_clocks(void)
 	}
 }

+static struct clk *_omap_clk_get_by_name(const char *name)
+{
+	struct clk *c;
+
+	list_for_each_entry(c, &clocks, node)
+		if (!strcmp(c->name, name))
+			return c;
+	return NULL;
+}
+
 /**
  * omap_clk_get_by_name - locate OMAP struct clk by its name
  * @name: name of the struct clk to locate
@@ -318,21 +328,45 @@ void clk_enable_init_clocks(void)
  */
 struct clk *omap_clk_get_by_name(const char *name)
 {
-	struct clk *c;
 	struct clk *ret = NULL;

 	mutex_lock(&clocks_mutex);
+	ret = _omap_clk_get_by_name(name);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+
+static inline void omap_init_dpll_data_clk_pts(struct dpll_data *dd)
+{
+	if (!dd->clk_ref && dd->clk_ref_name)
+		dd->clk_ref = _omap_clk_get_by_name(dd->clk_ref_name);
+	if (!dd->clk_bypass && dd->clk_bypass_name)
+		dd->clk_bypass =
_omap_clk_get_by_name(dd->clk_bypass_name);
+}
+
+static inline void omap_init_clksel_clk_pts(struct clksel *clks)
+{
+	if (!clks->parent && clks->parent_name)
+		clks->parent = _omap_clk_get_by_name(clks->parent_name);
+}
+
+void omap_init_clk_pts(void)
+{
+	struct clk *c;
+
+	mutex_lock(&clocks_mutex);

 	list_for_each_entry(c, &clocks, node) {
-		if (!strcmp(c->name, name)) {
-			ret = c;
-			break;
-		}
+		if (!c->parent && c->parent_name)
+			c->parent = _omap_clk_get_by_name(c->parent_name);
+		if (c->dpll_data)
+			omap_init_dpll_data_clk_pts(c->dpll_data);
+		if (c->clksel)
+			omap_init_clksel_clk_pts(c->clksel);
 	}

 	mutex_unlock(&clocks_mutex);
-
-	return ret;
 }

 /*
diff --git a/arch/arm/plat-omap/include/plat/clock.h
b/arch/arm/plat-omap/include/plat/clock.h
index 8eb0ada..dc0d9fd 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -85,6 +85,7 @@ struct clksel_rate {
 /**
  * struct clksel - available parent clocks, and a pointer to their
divisors
  * @parent: struct clk * to a possible parent clock
+ * @parent_name: Name of the possible parent clock
  * @rates: available divisors for this parent clock
  *
  * A struct clksel is always associated with one or more struct clks
@@ -92,6 +93,7 @@ struct clksel_rate {
  */
 struct clksel {
 	struct clk		 *parent;
+	const char		 *parent_name;
 	const struct clksel_rate *rates;
 };

@@ -101,7 +103,9 @@ struct clksel {
  * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
  * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
  * @clk_bypass: struct clk pointer to the clock's bypass clock input
+ * @clk_bypass_name: Name of the clock's bypass clock input
  * @clk_ref: struct clk pointer to the clock's reference clock input
+ * @clk_ref_name: Name of the clock's reference clock input
  * @control_reg: register containing the DPLL mode bitfield
  * @enable_mask: mask of the DPLL mode bitfield in @control_reg
  * @rate_tolerance: maximum variance allowed from target rate (in Hz)
@@ -143,7 +147,9 @@ struct dpll_data {
 	u32			mult_mask;
 	u32			div1_mask;
 	struct clk		*clk_bypass;
+	const char		*clk_bypass_name;
 	struct clk		*clk_ref;
+	const char		*clk_ref_name;
 	void __iomem		*control_reg;
 	u32			enable_mask;
 	unsigned int		rate_tolerance;
@@ -230,6 +236,7 @@ struct clk {
 	const struct clkops	*ops;
 	const char		*name;
 	struct clk		*parent;
+	const char		*parent_name;
 	struct list_head	children;
 	struct list_head	sibling;	/* node for children */
 	unsigned long		rate;
@@ -245,7 +252,7 @@ struct clk {
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
-	const struct clksel	*clksel;
+	struct clksel		*clksel;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
@@ -292,7 +299,7 @@ extern void clk_init_cpufreq_table(struct
cpufreq_frequency_table **table);
 extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table
**table);
 #endif
 extern struct clk *omap_clk_get_by_name(const char *name);
-
+extern void omap_init_clk_pts(void);
 extern const struct clkops clkops_null;

 extern struct clk dummy_ck;
-- 
1.7.0.4

>
> --
> balbi
