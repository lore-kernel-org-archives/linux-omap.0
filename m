From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 10:34:29 -0800
Message-ID: <20131219183428.GS27438@atomide.com>
References: <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
 <20131218215536.GA23674@earth.universe>
 <20131219005151.GA27928@earth.universe>
 <52B2848A.80807@ti.com>
 <20131219100840.GA923@earth.universe>
 <20131219135608.GA11654@earth.universe>
 <20131219163557.GM27438@atomide.com>
 <20131219170028.GA24230@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32276 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755116Ab3LSSej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 13:34:39 -0500
Content-Disposition: inline
In-Reply-To: <20131219170028.GA24230@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Sebastian Reichel <sre@ring0.de> [131219 09:01]:
> On Thu, Dec 19, 2013 at 08:42:31AM -0800, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [131219 05:57]:
> > > On Thu, Dec 19, 2013 at 11:08:40AM +0100, Sebastian Reichel wrote:
> > > > > Are you able to check if the bootloader muxes dat3 to SDI mode?
> > > > 
> > > > The bootloader's source code is not available as far as i know.
> > > > 
> > > > [...], but I get an external abort on non-linefetch.
> > > > So I can't check it :(
> > > 
> > > Ok. This is fixed by applying [0] (Thanks for the hint, Tomi!).
> > > This is the mux configuration from the bootloader:
> > > 
> > > [...]
> > > 
> > > [0] https://patchwork.kernel.org/patch/3283781/
> > 
> > Do we need to update Laurent's patch with this?
> 
> No, the patch is only needed to avoid the mentioned external abort
> on non-linefetch when doing "cat /sys/kernel/debug/pinctrl/.../pins".
> 
> > Or can we use it as it is and maybe you can ack it?
> 
> Sure. I will add an Ack.

OK thanks.

Here's my current legacy mux dumping tool if you want to look at
how the pins are muxed by the bootloader while booted to DT mode.

This is against omap-for-v3.14/dt branch, the list in pdata-quirks.c
may need updating depending on the board. And this does not account
for splitting up the pinctrl core for omap3..

Regards,

Tony

8< -----------------------------------
>From 2fb3765fd5739e8f5fb4318e2576081be6d535f2 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 19 Dec 2013 10:31:03 -0800
Subject: [PATCH] Not for merging: Allows dumping out mux entries in .dts
 format using legacy mux

For pinctrl-single.c we should eventually have a user space
app to configure and display pin settings. Meanwhile, allow
using the legacy mux interface to do that:

# mount -t debugfs debugfs /sys/kernel/debug
# cat /sys/kernel/debug/omap_mux/board/wkup | grep fref_clk0_out
	0x14 0x2        /* fref_clk0_out.sys_drm_msecure gpio6 OUTPUT | MODE2 */

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 48094b58..40658d9 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -35,11 +35,10 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 
-
 #include "omap_hwmod.h"
-
 #include "soc.h"
 #include "control.h"
+#include "id.h"
 #include "mux.h"
 #include "prm.h"
 #include "common.h"
@@ -505,17 +504,17 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 #define OMAP_MUX_TEST_FLAG(val, mask)				\
 	if (((val) & (mask)) == (mask)) {			\
 		i++;						\
-		flags[i] =  #mask;				\
+		flags[i] =  #mask + sizeof("OMAP_") - 1;	\
 	}
 
 /* REVISIT: Add checking for non-optimal mux settings */
 static inline void omap_mux_decode(struct seq_file *s, u16 val)
 {
 	char *flags[OMAP_MUX_MAX_NR_FLAGS];
-	char mode[sizeof("OMAP_MUX_MODE") + 1];
+	char mode[sizeof("MUX_MODE") + 1];
 	int i = -1;
 
-	sprintf(mode, "OMAP_MUX_MODE%d", val & 0x7);
+	sprintf(mode, "MUX_MODE%d", val & 0x7);
 	i++;
 	flags[i] = mode;
 
@@ -553,7 +552,7 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 		}
 	} else {
 		i++;
-		flags[i] = "OMAP_PIN_OUTPUT";
+		flags[i] = "PIN_OUTPUT";
 	}
 
 	do {
@@ -568,15 +567,26 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 {
 	struct omap_mux_partition *partition = s->private;
+	int pbase = (int)partition->base;
 	struct omap_mux_entry *e;
-	u8 omap_gen = omap_rev() >> 28;
+
+	if (!(pbase & 0xfff))
+		pbase = 0x40;
+	else
+		pbase = 0;
+
+	seq_printf(s, "\t\tpinctrl-single,pins = <\n");
 
 	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		char m0_def[OMAP_MUX_DEFNAME_LEN];
 		char *m0_name = m->muxnames[0];
 		u16 val;
-		int i, mode;
+		int padconf_offset, i, mode;
+
+		padconf_offset = m->reg_offset - pbase;
+		if (cpu_is_omap3630() && padconf_offset > 0x5ca)
+			continue;
 
 		if (!m0_name)
 			continue;
@@ -591,18 +601,18 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 		}
 		val = omap_mux_read(partition, m->reg_offset);
 		mode = val & OMAP_MUX_MODE7;
-		if (mode != 0)
-			seq_printf(s, "/* %s */\n", m->muxnames[mode]);
-
-		/*
-		 * XXX: Might be revisited to support differences across
-		 * same OMAP generation.
-		 */
-		seq_printf(s, "OMAP%d_MUX(%s, ", omap_gen, m0_def);
+		seq_printf(s, "\t\t\t0x%x (",
+			   padconf_offset);
 		omap_mux_decode(s, val);
-		seq_printf(s, "),\n");
+		seq_printf(s, ")\t/* %s.%s */",
+			   m->muxnames[0], m->muxnames[mode]);
+		seq_printf(s, " //0x%x gpio%i",
+			   val, m->gpio);
+		seq_printf(s, "\n");
 	}
 
+	seq_printf(s, "\t\t>;\n");
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d5b24d..a6d6e7e 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -22,6 +22,7 @@
 #include "common-board-devices.h"
 #include "dss-common.h"
 #include "control.h"
+#include "mux.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -277,6 +278,39 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ /* sentinel */ },
 };
 
+struct board_package {
+	const char *compatible;
+	int (*fn)(struct omap_board_mux *board_mux, int flags);
+	int flags;
+};
+
+static struct board_package packages[] __initdata = {
+	{ "nokia,n800", omap2420_mux_init, OMAP_PACKAGE_ZAC, },
+	{ "nokia,n810", omap2420_mux_init, OMAP_PACKAGE_ZAC, },
+	{ "ti,omap2430-sdp", omap2430_mux_init, OMAP_PACKAGE_ZAC, },
+	{ "nokia,omap3-n900", omap3_mux_init, OMAP_PACKAGE_CBB, },
+	{ "ti,omap3-evm-37xx", omap3_mux_init, OMAP_PACKAGE_CBB, },
+	{ "ti,omap3-ldp", omap3_mux_init, OMAP_PACKAGE_CBB, },
+	{ "ti,omap3-zoom3", omap3_mux_init, OMAP_PACKAGE_CBP, },
+	{ "ti,omap4-sdp", omap4_mux_init, OMAP_PACKAGE_CBS, },
+	{ "ti,omap4-panda", omap4_mux_init, OMAP_PACKAGE_CBS, },
+	{ /* sentinel */ },
+};
+
+static void legacy_mux_init(void)
+{
+	struct board_package *pkg = packages;
+
+	while (pkg->compatible) {
+		if (of_machine_is_compatible(pkg->compatible)) {
+			if (pkg->fn)
+				pkg->fn(NULL, pkg->flags);
+			break;
+		}
+		pkg++;
+	}
+}
+
 static void pdata_quirks_check(struct pdata_init *quirks)
 {
 	while (quirks->compatible) {
@@ -296,4 +330,5 @@ void __init pdata_quirks_init(struct of_device_id *omap_dt_match_table)
 	of_platform_populate(NULL, omap_dt_match_table,
 			     omap_auxdata_lookup, NULL);
 	pdata_quirks_check(pdata_quirks);
+	legacy_mux_init();
 }
