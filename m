From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix 1510 compilation with DSP != m
Date: Wed, 18 Oct 2006 22:32:53 +0300
Message-ID: <20061018193251.GC4669@atomide.com>
References: <20061008190831.GC21713@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061008190831.GC21713@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Jonathan McDowell <noodles@earth.li> [061008 22:09]:
> Looks like recent changes have broken OMAP1510 compilation; I hit this
> because I'm not using the DSP at present but during testing my fix
> discovered that setting CONFIG_OMAP_DSP to Y didn't compile either; only
> M worked. Patch below makes all 3 compile.
> 
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> -----
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> index 992a17d..adae4f8 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -63,7 +63,7 @@ #endif
>  
>  #if defined(CONFIG_OMAP_DSP)
>  
> -#if defined(CONFIG_ARCH_OMAP1510)
> +#if defined(CONFIG_ARCH_OMAP15XX)
>  #  define OMAP1_MBOX_SIZE	0x23
>  #  define INT_DSP_MAILBOX1	INT_1510_DSP_MAILBOX1
>  #elif defined(CONFIG_ARCH_OMAP16XX)
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 9d9d456..12ece9d 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -193,7 +193,7 @@ static int omap_mcbsp_check(unsigned int
>  	return -1;
>  }
>  
> -#ifdef CONFIG_ARCH_OMAP1
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_DSP)
>  static void omap_mcbsp_dsp_request(void)
>  {
>  	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> @@ -266,7 +266,7 @@ int omap_mcbsp_request(unsigned int id)
>  	if (omap_mcbsp_check(id) < 0)
>  		return -EINVAL;
>  
> -#ifdef CONFIG_ARCH_OMAP1
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_DSP)
>  	/*
>  	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
>  	 * are DSP public peripherals.
> @@ -333,7 +333,7 @@ void omap_mcbsp_free(unsigned int id)
>  	if (omap_mcbsp_check(id) < 0)
>  		return;
>  
> -#ifdef CONFIG_ARCH_OMAP1
> +#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_DSP)
>  	if (cpu_class_is_omap1()) {
>  		if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
>  			omap_mcbsp_dsp_free();
> -----

I guess originally the idea was that McBSP would work even without
CONFIG_OMAP_DSP.

Note that arch/arm/plat_omap/dsp/dsp_common.c is compiled even without
CONFIG_OMAP_DSP. Maybe the compilation problem really is some other
issue?

Regards,

Tony
