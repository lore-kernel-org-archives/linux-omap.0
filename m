From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v4 3/4] OMAP2+: use control module mfd driver in omap_type
Date: Wed, 25 Jul 2012 16:39:49 +0400
Message-ID: <500FE915.6090707@mvista.com>
References: <500FD2EF.4010304@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57189 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934Ab2GYMko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 08:40:44 -0400
Received: by lbbgm6 with SMTP id gm6so604627lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 05:40:43 -0700 (PDT)
In-Reply-To: <500FD2EF.4010304@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, amit.kucheria@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, amit.kachhap@linaro.org

Hello.

On 25-07-2012 15:05, Konstantin Baydarov wrote:

> OMAP system control module can be probed early, then
> omap_type is safe to use its APIs.

> TODO: add support for other omap versions

> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> ---
>   arch/arm/mach-omap2/id.c |   11 ++++++-----
>   1 files changed, 6 insertions(+), 5 deletions(-)

> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 40373db..8018cad 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
[...]
> @@ -43,15 +44,15 @@ int omap_type(void)
>   	u32 val = 0;
>
>   	if (cpu_is_omap24xx()) {
> -		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> +		val = omap_control_status_read();
>   	} else if (soc_is_am33xx()) {
> -		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
> +		val = omap_control_status_read();
>   	} else if (cpu_is_omap34xx()) {
> -		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
> +		val = omap_control_status_read();
>   	} else if (cpu_is_omap44xx()) {
> -		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
> +		val = omap_control_status_read();

    Isn't it better to merge now identical code into one *if*?

WBR, Sergei

