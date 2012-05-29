From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 03/11] arm: omap: device: create a device for system
 control module
Date: Tue, 29 May 2012 17:39:54 +0400
Message-ID: <4FC4D1AA.5040807@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-4-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:56774 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752102Ab2E2NkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 May 2012 09:40:24 -0400
In-Reply-To: <1337934361-1606-4-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

  Hi.

On 05/25/2012 12:25 PM, Eduardo Valentin wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> Extracts the device data from hwmod database and create a platform device
> using omap device build.
>
> The device build is done during postcore_initcall.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 152c266..9332673 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -40,6 +40,32 @@
>  #define L3_MODULES_MAX_LEN 12
>  #define L3_MODULES 3
>  
> +static int omap_init_control(void)
> +{
> +	struct omap_hwmod		*oh;
> +	struct platform_device		*pdev;
> +	const char			*oh_name, *name;
> +
> +	oh_name = "ctrl_module_core";
> +	name = "omap-control-core";
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not lookup hwmod for %s\n", oh_name);
> +		return PTR_ERR(oh);
> +	}
> +
> +	pdev = omap_device_build(name, -1, oh, NULL, 0, NULL, 0, true);
I noticed that control module omap device is created and configured according to following idle flags:
static struct omap_hwmod_class_sysconfig omap44xx_ctrl_module_sysc = {
    .rev_offs    = 0x0000,
    .sysc_offs    = 0x0010,
    .sysc_flags    = SYSC_HAS_SIDLEMODE,
    .idlemodes    = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
               SIDLE_SMART_WKUP),
    .sysc_fields    = &omap_hwmod_sysc_type2,
};

IIUC, ".idlemodes    = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART | SIDLE_SMART_WKUP)" means that CONTROL_GEN_CORE idlemode will be set to
"0x2,0x3: Clock is automatically gated when there is no access to the Control Module through L4-interconnect". See CONTROL_GEN_CORE_SYSCONFIG register.
So IIUC theoretically CONTROL_GEN_CORE module clock can be automatically gated. Recalling that CONTROL_GEN_CORE module has an THERMAL_ALERT interrupt that is used by the bandgap driver, I'm wondering if the THERMAL_ALERT interrupt will be fired when CONTROL_GEN_CORE module clock is gated?
Probably bandgap driver should set CONTROL_GEN_CORE idle mode to SIDLE_NO, to prevent loosing THERMAL_ALERT interrupt?

  BR,
    Konstantin Baydarov.

> +	if (IS_ERR(pdev)) {
> +		pr_err("Could not build omap_device for %s %s\n",
> +		       name, oh_name);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(omap_init_control);
> +
>  static int __init omap3_l3_init(void)
>  {
>  	struct omap_hwmod *oh;

