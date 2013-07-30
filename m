From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for DRA7xx
 based SoCs'
Date: Tue, 30 Jul 2013 19:48:23 +0530
Message-ID: <51F7CB2F.6070705@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-2-git-send-email-rnayak@ti.com> <20130730131009.GA28162@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43747 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab3G3OSy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 10:18:54 -0400
In-Reply-To: <20130730131009.GA28162@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, ambresh@ti.com, sourav.poddar@ti.com

On Tuesday 30 July 2013 06:40 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
>> @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
>>  # define soc_is_omap543x()		is_omap543x()
>>  #endif
>>  
>> +# if defined(CONFIG_SOC_DRA7XX)
>> +# undef soc_is_dra7xx
>> +# undef soc_is_dra75x
>> +# define soc_is_dra7xx()		is_dra7xx()
>> +# define soc_is_dra75x()		is_dra75x()
> since this platform is DT-only, couldn't we just believe DT-data to be
> correct of_machine_is_compatible() ? 2/3 of this patch would be removed.
>
> I patched this for OMAP5 (compile-tested only, no boards available) and
> came out with the patch below (still needs to be split):
>
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 08b7267..b3136e5 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "TI OMAP5 uEVM board";
> -	compatible = "ti,omap5-uevm", "ti,omap5";
> +	compatible = "ti,omap5-uevm", "ti,omap5432-es2.0", "ti,omap5";
>  
 ok, nice and simpler way.
 But would this make different revisions, to appear the same ?

Regards,
 Sricharan
>  	memory {
>  		device_type = "memory";
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 07be2cd..a7bc906 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -17,7 +17,7 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> -	compatible = "ti,omap5";
> +	compatible = "ti,omap5432-es2.0", "ti,omap5430-es2.0", "ti,omap5";
>  	interrupt-parent = <&gic>;
>  
>  	aliases {
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2dc62a2..ee94309 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -563,49 +563,6 @@ void __init omap4xxx_check_revision(void)
>  	pr_info("%s %s\n", soc_name, soc_rev);
>  }
>  
> -void __init omap5xxx_check_revision(void)
> -{
> -	u32 idcode;
> -	u16 hawkeye;
> -	u8 rev;
> -
> -	idcode = read_tap_reg(OMAP_TAP_IDCODE);
> -	hawkeye = (idcode >> 12) & 0xffff;
> -	rev = (idcode >> 28) & 0xff;
> -	switch (hawkeye) {
> -	case 0xb942:
> -		switch (rev) {
> -		case 0:
> -			omap_revision = OMAP5430_REV_ES1_0;
> -			break;
> -		case 1:
> -		default:
> -			omap_revision = OMAP5430_REV_ES2_0;
> -		}
> -		break;
> -
> -	case 0xb998:
> -		switch (rev) {
> -		case 0:
> -			omap_revision = OMAP5432_REV_ES1_0;
> -			break;
> -		case 1:
> -		default:
> -			omap_revision = OMAP5432_REV_ES2_0;
> -		}
> -		break;
> -
> -	default:
> -		/* Unknown default to latest silicon rev as default*/
> -		omap_revision = OMAP5430_REV_ES2_0;
> -	}
> -
> -	sprintf(soc_name, "OMAP%04x", omap_rev() >> 16);
> -	sprintf(soc_rev, "ES%d.0", (omap_rev() >> 12) & 0xf);
> -
> -	pr_info("%s %s\n", soc_name, soc_rev);
> -}
> -
>  /*
>   * Set up things for map_io and processor detection later on. Gets called
>   * pretty much first thing from board init. For multi-omap, this gets
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 4a3f06f..aa28940 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -633,8 +633,7 @@ void __init omap4430_init_late(void)
>  #ifdef CONFIG_SOC_OMAP5
>  void __init omap5_init_early(void)
>  {
> -	omap2_set_globals_tap(OMAP54XX_CLASS,
> -			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
> +	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
>  	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
>  				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
>  	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
> @@ -644,7 +643,6 @@ void __init omap5_init_early(void)
>  	omap_prm_base_init();
>  	omap_cm_base_init();
>  	omap44xx_prm_init();
> -	omap5xxx_check_revision();
>  	omap54xx_voltagedomains_init();
>  	omap54xx_powerdomains_init();
>  	omap54xx_clockdomains_init();
> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> index 8c616e4..b8339ad 100644
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -35,6 +35,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/bitops.h>
> +#include <linux/of.h>
>  
>  /*
>   * Test if multicore OMAP support is needed
> @@ -194,7 +195,6 @@ IS_OMAP_CLASS(24xx, 0x24)
>  IS_OMAP_CLASS(34xx, 0x34)
>  IS_OMAP_CLASS(44xx, 0x44)
>  IS_AM_CLASS(35xx, 0x35)
> -IS_OMAP_CLASS(54xx, 0x54)
>  IS_AM_CLASS(33xx, 0x33)
>  IS_AM_CLASS(43xx, 0x43)
>  
> @@ -207,7 +207,6 @@ IS_OMAP_SUBCLASS(363x, 0x363)
>  IS_OMAP_SUBCLASS(443x, 0x443)
>  IS_OMAP_SUBCLASS(446x, 0x446)
>  IS_OMAP_SUBCLASS(447x, 0x447)
> -IS_OMAP_SUBCLASS(543x, 0x543)
>  
>  IS_TI_SUBCLASS(816x, 0x816)
>  IS_TI_SUBCLASS(814x, 0x814)
> @@ -373,10 +372,10 @@ IS_OMAP_TYPE(3430, 0x3430)
>  # endif
>  
>  # if defined(CONFIG_SOC_OMAP5)
> -# undef soc_is_omap54xx
> -# undef soc_is_omap543x
> -# define soc_is_omap54xx()		is_omap54xx()
> -# define soc_is_omap543x()		is_omap543x()
> +# undef  soc_is_omap54xx
> +# undef  soc_is_omap543x
> +# define soc_is_omap54xx()		(of_machine_is_compatible("ti,omap5"))
> +# define soc_is_omap543x()		(soc_is_omap54xx())
>  #endif
>  
>  /* Various silicon revisions for omap2 */
> @@ -437,16 +436,9 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP447X_CLASS		0x44700044
>  #define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))
>  
> -#define OMAP54XX_CLASS		0x54000054
> -#define OMAP5430_REV_ES1_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x10 << 8))
> -#define OMAP5430_REV_ES2_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x20 << 8))
> -#define OMAP5432_REV_ES1_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x10 << 8))
> -#define OMAP5432_REV_ES2_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x20 << 8))
> -
>  void omap2xxx_check_revision(void);
>  void omap3xxx_check_revision(void);
>  void omap4xxx_check_revision(void);
> -void omap5xxx_check_revision(void);
>  void omap3xxx_check_features(void);
>  void ti81xx_check_features(void);
>  void am33xx_check_features(void);
>

