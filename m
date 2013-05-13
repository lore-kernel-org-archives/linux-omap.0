From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature
Date: Mon, 13 May 2013 14:53:27 -0700
Message-ID: <87bo8e1r8o.fsf@linaro.org>
References: <1367996313-6676-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:36526 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab3EMVxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 May 2013 17:53:30 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so1312686daj.17
        for <linux-omap@vger.kernel.org>; Mon, 13 May 2013 14:53:30 -0700 (PDT)
In-Reply-To: <1367996313-6676-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 8 May 2013 12:28:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Layout of DEV_FEATURE register (offset = 0x604) is different
> between TI81xx and AM33xx device, so create separate function
> which will check for features available on specific AM33xx SoC
> and set the flags accordingly.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Minor nit below, otherwise...

Reviewed-by: Kevin Hilman <khilman@linaro.org>

> ---
>  arch/arm/mach-omap2/control.h |    5 +++++
>  arch/arm/mach-omap2/id.c      |   13 +++++++++++++
>  arch/arm/mach-omap2/io.c      |    2 +-
>  arch/arm/mach-omap2/soc.h     |    1 +
>  4 files changed, 20 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index e6c3281..4acdfc5 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -358,6 +358,11 @@
>  #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
>  #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
>  
> +/* DEV Feature register to identify AM33XX features */
> +#define AM33XX_DEV_FEATURE		0x604
> +#define AM33XX_SGX_SHIFT		29

You don't need the shift value anywhere in the code, so...

> +#define AM33XX_SGX_MASK			(1 << AM33XX_SGX_SHIFT)

#define AM33XX_SGX_MASK		BIT(29)

instead?

Otherwise, rest of patch looks fine.

Kevin
