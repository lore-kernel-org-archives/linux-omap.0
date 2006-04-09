From: tony@atomide.com
Subject: Re: patches for fsample/850
Date: Sun, 9 Apr 2006 11:36:17 -0700
Message-ID: <20060409183557.GF5032@atomide.com>
References: <20060407220658.GA19801@localhost.localdomain>
	<20060408110036.34284.qmail@web32904.mail.mud.yahoo.com>
	<20060408154425.GA24843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060408154425.GA24843@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Few comments below.

* Brian Swetland <swetland@google.com> [060408 08:45]:
> --- linux-omap-2.6/arch/arm/mach-omap1/clock.h	2006-04-05 10:33:20.000000000 -0700
> +++ linux-omap-fsample/arch/arm/mach-omap1/clock.h	2006-04-06 13:15:34.000000000 -0700
> @@ -101,44 +101,50 @@
>  /*-------------------------------------------------------------------------
>   * Omap1 MPU rate table
>   *-------------------------------------------------------------------------*/
> +#if defined(CONFIG_ARCH_OMAP730)
> +	#define CKCTL_RESERVED_1_MASK (0x2000)
> +#else
> +	#define CKCTL_RESERVED_1_MASK (0x0000)
> +#endif

This addds yet another extra hurdle compiling 730 in with 15xx and 16xx.
Although we cannot do it because of the interrupt handler, maybe we'll
fix that someday. So let's try not to add more hurdles if we can avoid
it.

How about doing the masking when the CKCTL value is written based on the
cpu_is_omap730()?

> --- linux-omap-2.6/arch/arm/mach-omap1/pm.c	2006-04-05 10:33:20.000000000 -0700
> +++ linux-omap-fsample/arch/arm/mach-omap1/pm.c	2006-04-06 13:15:34.000000000 -0700
> @@ -326,8 +326,10 @@
>  	/* stop DSP */
>  	omap_writew(omap_readw(ARM_RSTCT1) & ~(1 << DSP_EN), ARM_RSTCT1);
>  
> +#if !defined(CONFIG_ARCH_OMAP730)
>  	/* shut down dsp_ck */
>  	omap_writew(omap_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);
> +#endif

This too would be better with if (!cpu_is_omap730()).
 
> @@ -189,8 +197,6 @@
>  	omap_writel(value, OMAP730_IO_CONF_4);
>  
>  	omap_uwire_configure_mode(0,16);
> -
> -	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISOFF, 9, 0,NULL,1);
>  	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_SLPIN, 9, 0,NULL,1);
>  	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISNOR, 9, 0,NULL,1);
>  	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_GSSET, 9, 0,NULL,1);

Is the removal of one of the omap_uwire_data_transfer() calls intended?

Then does it compile and boot for p2 and fsample both selected?

Also, could you please do one patch for the core support, and then
another patch for files that don't touch the omap core files?

That way we can send you patch directly upstream when we merge next
time. Otherwise I have to redo the patch to strip out the drivers when
we merge as not many omap drivers are yet merged with the mainline tree.

Core files being arch/arm/*omap* and include/asm-arm/arch-omap:

arch/arm/mach-omap1/Kconfig
arch/arm/mach-omap1/Makefile
arch/arm/mach-omap1/board-fsample.c
arch/arm/mach-omap1/clock.c
arch/arm/mach-omap1/clock.h
arch/arm/mach-omap1/pm.c
arch/arm/mach-omap1/time.c
arch/arm/plat-omap/devices.c
include/asm-arm/arch-omap/board-fsample.h
include/asm-arm/arch-omap/hardware.h

Regards,

Tony
