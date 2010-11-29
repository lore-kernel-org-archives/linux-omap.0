From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of
 OMAP3_SGX_SHIFT
Date: Mon, 29 Nov 2010 08:29:57 -0600
Message-ID: <4CF3B8E5.8040109@ti.com>
References: <AANLkTi=rVpQWnRmzw2XF3TzoQW6E9fHLKfrdZUi8-cJo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55052 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752833Ab0K2OaB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 09:30:01 -0500
Received: by mail-gy0-f170.google.com with SMTP id 2so1941255gyf.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Nov 2010 06:30:00 -0800 (PST)
In-Reply-To: <AANLkTi=rVpQWnRmzw2XF3TzoQW6E9fHLKfrdZUi8-cJo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org, "tony@atomide.com" <tony@atomide.com>

Arno Steffen had written, on 11/26/2010 05:41 AM, the following:

minor comment:
$subject could be the commit message probably.. and a smaller subject 
like OMAP3: fix typo in OMAP3_IVA_MASK could be used

otherwise, looks good to me.

> Signed-off-by: Arno Steffen <arno.steffen@googlemail.com>
> ---
>  arch/arm/mach-omap2/control.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
> index b6c6b7c..5325297 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -309,7 +309,7 @@
>  #define		FEAT_SGX_NONE		2
> 
>  #define OMAP3_IVA_SHIFT			12
> -#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
> +#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)
>  #define		FEAT_IVA		0
>  #define		FEAT_IVA_NONE		1
> 


-- 
Regards,
Nishanth Menon
