From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH v2] OMAP4: pm.c extensions for OMAP4 support
Date: Tue, 17 Aug 2010 05:36:53 -0500
Message-ID: <4C6A6645.1020303@gmail.com>
References: <1282019798-2443-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33879 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab0HQKhI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:37:08 -0400
Received: by ywh1 with SMTP id 1so2361646ywh.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Aug 2010 03:37:07 -0700 (PDT)
In-Reply-To: <1282019798-2443-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com

On 08/16/2010 11:36 PM, Thara Gopinath wrote:
> OMAP4 has an iva device and a dsp devcice where as OMAP2/3
> has only an iva device. In this file the iva device in the
a bit confused regarding this -> IVA on OMAP3 was a C64 DSP. OMAP3 also 
had iva accelerators, but ARM does not directly talk to the 
accellerators. C64 did (that was why we had the dspbridge to talk to the 
C64).
Could you clarify the intent of the patch?

> system is registered under the name dsp_dev and the API
> to retrieve the iva device is omap2_get_dsp_device.
> This patch renames the dsp_dev to iva_dev, renames
> omap2_get_dsp_device to omap2_get_iva_device,
> registers dsp_dev for OMAP4 and adds a new API
> omap4_get_dsp_device to retrieve the dep_dev.


>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> ---
> v2: Removed fixing of l3_main hwmod for OMAP4 as Benoit has
>      already submitted a pach fixing the same.
>
>   arch/arm/mach-omap2/pm.c                 |   19 ++++++++++++++-----
>   arch/arm/plat-omap/include/plat/common.h |    3 ++-
>   2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 68f9f2e..a98b5e8 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -21,8 +21,9 @@
>   static struct omap_device_pm_latency *pm_lats;
>
>   static struct device *mpu_dev;
> -static struct device *dsp_dev;
> +static struct device *iva_dev;
>   static struct device *l3_dev;
> +static struct device *dsp_dev;
>
>   struct device *omap2_get_mpuss_device(void)
>   {
> @@ -30,10 +31,10 @@ struct device *omap2_get_mpuss_device(void)
>   	return mpu_dev;
>   }
>
> -struct device *omap2_get_dsp_device(void)
> +struct device *omap2_get_iva_device(void)
>   {
> -	WARN_ON_ONCE(!dsp_dev);
> -	return dsp_dev;
> +	WARN_ON_ONCE(!iva_dev);
> +	return iva_dev;
>   }
>
>   struct device *omap2_get_l3_device(void)
> @@ -42,6 +43,13 @@ struct device *omap2_get_l3_device(void)
>   	return l3_dev;
>   }
>
> +struct device *omap4_get_dsp_device(void)
> +{
> +	WARN_ON_ONCE(!dsp_dev);
> +	return dsp_dev;
> +}
> +EXPORT_SYMBOL(omap4_get_dsp_device);
> +
>   /* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
>   static int _init_omap_device(char *name, struct device **new_dev)
>   {
> @@ -69,7 +77,8 @@ static int _init_omap_device(char *name, struct device **new_dev)
>   static void omap2_init_processor_devices(void)
>   {
>   	_init_omap_device("mpu",&mpu_dev);
> -	_init_omap_device("iva",&dsp_dev);
> +	_init_omap_device("iva",&iva_dev);
> +	_init_omap_device("dsp",&dsp_dev);
>   	_init_omap_device("l3_main",&l3_dev);
>   }
>
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> index 9776b41..c45dbb9 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -91,7 +91,8 @@ void omap3_map_io(void);
>   })
>
>   extern struct device *omap2_get_mpuss_device(void);
> -extern struct device *omap2_get_dsp_device(void);
> +extern struct device *omap2_get_iva_device(void);
>   extern struct device *omap2_get_l3_device(void);
> +extern struct device *omap4_get_dsp_device(void);
>
>   #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */

