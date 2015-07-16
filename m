From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2: Delete unnecessary checks before three
 function calls
Date: Thu, 16 Jul 2015 05:55:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160548040.32764@utopia.booyaka.com>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54705EC3.90708@users.sourceforge.net> <55928739.5040809@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55928739.5040809@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

Hello Markus

On Tue, 30 Jun 2015, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 30 Jun 2015 14:00:16 +0200
> 
> The functions clk_disable(), of_node_put() and omap_device_delete() test
> whether their argument is NULL and then return immediately.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for the patch.  I have to say, I am a bit leery about applying the 
omap_device.c and omap_hwmod.c changes, since the called functions -- 
omap_device_delete() and clk_disable() -- don't explicitly document that 
NULLs are allowed to be passed in.  So there's no explicit contract that 
callers can rely upon, to (at least in theory) prevent those internal NULL 
pointer checks from being removed.

So I would suggest that those two functions' kerneldoc be patched first to 
explicitly state that passing in a NULL pointer is allowed.  Then I would 
feel a bit more comfortable applying the omap_device.c and omap_hwmod.c 
changes.

The kerneldoc for of_node_put() does explicitly allow NULLs to be passed 
in.  So I'll apply that change now for v4.3, touching up the commit 
message accordingly.

regards,

- Paul

> ---
>  arch/arm/mach-omap2/omap_device.c | 3 +--
>  arch/arm/mach-omap2/omap_hwmod.c  | 5 +----
>  arch/arm/mach-omap2/timer.c       | 3 +--
>  3 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 4cb8fd9..196366e 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -193,8 +193,7 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
>  
>  	switch (event) {
>  	case BUS_NOTIFY_DEL_DEVICE:
> -		if (pdev->archdata.od)
> -			omap_device_delete(pdev->archdata.od);
> +		omap_device_delete(pdev->archdata.od);
>  		break;
>  	case BUS_NOTIFY_ADD_DEVICE:
>  		if (pdev->dev.of_node)
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index d78c12e..1091ee7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -921,10 +921,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
>  	int i = 0;
>  
>  	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
> -
> -	if (oh->_clk)
> -		clk_disable(oh->_clk);
> -
> +	clk_disable(oh->_clk);
>  	p = oh->slave_ports.next;
>  
>  	while (i < oh->slaves_cnt) {
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index cac46d8..15448221 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -208,8 +208,7 @@ static void __init omap_dmtimer_init(void)
>  	/* If we are a secure device, remove any secure timer nodes */
>  	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)) {
>  		np = omap_get_timer_dt(omap_timer_match, "ti,timer-secure");
> -		if (np)
> -			of_node_put(np);
> +		of_node_put(np);
>  	}
>  }
>  
> -- 
> 2.4.5
> 


- Paul
