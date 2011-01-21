From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
Date: Fri, 21 Jan 2011 17:08:22 +0000
Message-ID: <20110121170822.GA30823@n2100.arm.linux.org.uk>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com> <4D385155.4050301@gmail.com> <43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com> <4D38641E.2000301@gmail.com> <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55713 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1AURIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 12:08:44 -0500
Content-Disposition: inline
In-Reply-To: <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On Fri, Jan 21, 2011 at 07:13:48PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Rob Herring [mailto:robherring2@gmail.com]
> > Sent: Thursday, January 20, 2011 10:05 PM
> > To: Santosh Shilimkar
> > Cc: linux-arm-kernel@lists.infradead.org; Russell King; linux-
> > omap@vger.kernel.org; Linus Walleij
> > Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
> > to speed-up boot
> 
> [..]
> 
> > >>
> > >> There's already one way to do this with pre-calculated lpj.
> > >>
> > > How about the hot-plug path? This is not for just boot.
> >
> > The path is the same for hotplug and secondary boot, so yes for
> > both.
> > Plus you get the added benefit of speeding up the primary core boot
> > as well.
> >
> No 'preset_lpj' will not work for the hotplug path when
> cpufreq is active. It just useful only for boot in
> its current form.

Indeed, it will end up screwing up the loops_per_jiffy value.  That
would seem to be a hole on other architectures too.  I wonder if
anyone has tested hotplug on a cpufreq-scaled system.

> @@ -332,14 +345,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  	int cpu;
>  	unsigned long bogosum = 0;
> 
> -	for_each_online_cpu(cpu)
> -		bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
> +	if (!skip_secondary_calibrate) {
> +		for_each_online_cpu(cpu)
> +			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
> 
> -	printk(KERN_INFO "SMP: Total of %d processors activated "
> -	       "(%lu.%02lu BogoMIPS).\n",
> -	       num_online_cpus(),
> -	       bogosum / (500000/HZ),
> -	       (bogosum / (5000/HZ)) % 100);
> +		printk(KERN_INFO "SMP: Total of %d processors activated "
> +		       "(%lu.%02lu BogoMIPS).\n",
> +			num_online_cpus(),
> +			bogosum / (500000/HZ),
> +			(bogosum / (5000/HZ)) % 100);
> +	} else {
> +		printk(KERN_INFO "SMP: Total of %d processors
> activated.\n",
> +			num_online_cpus());
> +	}

Hmm.  How about:

	char bogosum[32];

	if (!skip_secondary_calibrate) {
		for_each_online_cpu(cpu)
			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;

		snprintf(bogosum, sizeof(bogosum), " (%lu.%02lu BogoMIPS).\n",
			bogosum / (500000/HZ), (bogosum / (5000/HZ)) % 100);
	} else
		bogosum[0] = '\0';

	pr_info("SMP: Total of %d processors activated%s.\n",
		num_online_cpus(), bogosum);

Looks neater and more compact and reduces the amount of string space
required.
