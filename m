From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] ARM: VExpress: Switch to generic SCU routines
Date: Tue, 30 Nov 2010 23:27:23 +0000
Message-ID: <20101130232723.GA14383@n2100.arm.linux.org.uk>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru> <20101130171701.GC24034@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101130171701.GC24034@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Jamie Iles <jamie.iles@picochip.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 08:17:01PM +0300, Anton Vorontsov wrote:
> +/* If there are more than one CPU let them know where to start. */
> +static void __init smp_point_cpus(void)
> +{
> +	if (num_present_cpus() <= 1)
> +		return;
>  
> -	for (i = 0; i < ncores; i++)
> -		set_cpu_possible(i, true);
> +	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
> +	writel(BSYM(virt_to_phys(scu_secondary_startup)),
> +	       MMIO_P2V(V2M_SYS_FLAGSSET));
>  }

I don't see the point of separating this code from the code below.  It
doesn't seem to bring any benefit.  Could you explain why it's necessary
to separate this?

>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
...
