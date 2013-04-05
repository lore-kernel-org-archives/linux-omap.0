From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Fri, 5 Apr 2013 15:17:55 -0700
Message-ID: <20130405221755.GI10155@atomide.com>
References: <20130405161338.GB10155@atomide.com>
 <20130405163254.GA7259@kahuna>
 <20130405170527.GC10155@atomide.com>
 <20130405171750.GA7398@kahuna>
 <20130405192829.GE10155@atomide.com>
 <20130405200201.GA7804@kahuna>
 <20130405211003.GK6182@atomide.com>
 <20130405213250.GA8534@kahuna>
 <20130405214051.GG10155@atomide.com>
 <20130405221041.GA8648@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130405221041.GA8648@kahuna>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [130405 15:15]:
> How does the following look?
> Option a) not have a dummy node if CPUFREQ_CPU0 is not configured:
> static inline void omap_init_cpufreq(void)
> {
> 	struct platform_device_info devinfo = { };
> 
> 	if (!of_have_populated_dt())
> 		devinfo.name = "omap-cpufreq";
> 	else if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0))
> 		devinfo.name = "cpufreq-cpu0"
> 	
> 	if (devinfo.name)
> 		platform_device_register_full(&devinfo);
> }
> 
> Option b) leave a dummy node registered
> static inline void omap_init_cpufreq(void)
> {
> 	struct platform_device_info devinfo = { };
> 
> 	if (!of_have_populated_dt())
> 		devinfo.name = "omap-cpufreq";
> 	else
> 		devinfo.name = "cpufreq-cpu0"
> 	
> 	platform_device_register_full(&devinfo);
> }
> 
> If there are no objections to (b), I dont mind it either.

To me option (b) looks better as it's if else :)

Tony
