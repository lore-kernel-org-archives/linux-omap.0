From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 11/15] OMAP3: powerdomain data: add wake-up latency figures
Date: Tue, 16 Aug 2011 19:55:13 +0530
Message-ID: <4E4A7DC9.1040500@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com> <1313502198-9298-12-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43368 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752550Ab1HPOZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Aug 2011 10:25:25 -0400
Received: by mail-yi0-f54.google.com with SMTP id 19so4570915yib.41
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 07:25:25 -0700 (PDT)
In-Reply-To: <1313502198-9298-12-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Figures are added to the power domains structs.
>
> Note: the figures are preliminary figures. More accurate measurements
> are needed. Also the conditions of measurements shall be investigated
> and described.
>
> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
> on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/powerdomains3xxx_data.c |   77 +++++++++++++++++++++++++++
>   1 files changed, 77 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> index 469a920..64446e7 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -31,6 +31,13 @@
>
>   /*
>    * Powerdomains
> + *
> + * The wakeup_lat values are derived from measurements on
> + * the actual target.
> + *
> + * Note: the latency figures are preliminary and only used
> + * for the constraints framework validation.
> + * Actual figures and measurements conditions shall be added.
>    */
>
>   static struct powerdomain iva2_pwrdm = {
> @@ -52,6 +59,13 @@ static struct powerdomain iva2_pwrdm = {
>   		[2] = PWRSTS_OFF_ON,
>   		[3] = PWRSTS_ON,
>   	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 1100,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 350,
> +		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
This can easily derived from the PWRST flag instead of hardcoding
it this way. Also note that INACTIVE PD isn't supported in mainline
yet because of voltage-domain dependency planned changes.

> +		[PWRDM_FUNC_PWRST_ON] = 0,

All of the PD structures are manually coded. This whole file is
auto-generated and even these field generation needs to follow
that path.
