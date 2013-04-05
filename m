From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 16:32:51 -0500
Message-ID: <20130405213250.GA8534@kahuna>
References: <20130404190053.GA4371@kahuna>
 <515E9E79.8010300@ti.com>
 <CAGo_u6r+JdNaCmVh+dHLppJ7eaYh4W5aL1aAg8xQfAju6PyZdQ@mail.gmail.com>
 <20130405161338.GB10155@atomide.com>
 <20130405163254.GA7259@kahuna>
 <20130405170527.GC10155@atomide.com>
 <20130405171750.GA7398@kahuna>
 <20130405192829.GE10155@atomide.com>
 <20130405200201.GA7804@kahuna>
 <20130405211003.GK6182@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130405211003.GK6182@atomide.com>
Sender: cpufreq-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 14:10-20130405, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [130405 13:06]:
> > On 12:28-20130405, Tony Lindgren wrote:
[...]
> > > How about just set it up in omap2_common_pm_init instead
> > > of the board-generic?
> > umm.. We want to eventually want to get rid of mach-omap2/pm.c (all
> > those create processor devices etc should go away with proper
> > representation of devices as nodes in DT if possible.
> > But, I think you mean something like in the "else" condition of
> > https://patchwork.kernel.org/patch/2359711/ ? - I'd again have the same
> > request of not having anything to do with pm.c and keeping as little as
> > possible for all TI processors in mach-omap2.
> > 
> > Could you enlighten me about why you'd not like it in board-generic.c?
> > will creating an function ti_generic_cpufreq_init() in board-generic.c
> > and calling it from omap_generic_init help?
> 
> I'd like to keep board-generic.c down to minimum. Can't you
> set it up in omap_init_cpufreq() in your second patch of this
> series?
Thanks. That seems to be a better compromise. Will do. I can sequence patch
[2] above the current patch[1] if there is a need to fix multi-arch builds
for 3.9: in that case I will probably leave the current [2] patch as
is, and once our clock representation discussion is done, the rev 4 of
the patch [1], I can do the following:
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 8d15f9a..b250689 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -267,8 +267,14 @@ static void __init omap4_init_voltages(void)
 
 static inline void omap_init_cpufreq(void)
 {
-	struct platform_device_info devinfo = { .name = "omap-cpufreq", };
-	platform_device_register_full(&devinfo);
+	struct platform_device_info devinfo = { .name = "omap-cpufreq", }
+
+	if (!of_have_populated_dt()) {
+		platform_device_register_full(&devinfo);
+	} else if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
+		devinfo.name = "cpufreq-cpu0"
+		platform_device_register_full(&devinfo);
+	}
 }
 
 static int __init omap2_common_pm_init(void)
@@ -301,9 +307,9 @@ int __init omap2_common_pm_late_init(void)
 		/* Smartreflex device init */
 		omap_devinit_smartreflex();
 
-		/* cpufreq dummy device instantiation */
-		omap_init_cpufreq();
 	}
+	/* cpufreq dummy device instantiation */
+	omap_init_cpufreq();
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
[1] https://patchwork.kernel.org/patch/2399201/
[2] https://patchwork.kernel.org/patch/2359711/
-- 
Regards,
Nishanth Menon
