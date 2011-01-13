From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/4] arm: omap: clockdomain: fix compile error
Date: Thu, 13 Jan 2011 17:18:47 +0530
Message-ID: <dd0e64dec64280058f5571494fb60114@mail.gmail.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com> <1294918868-16263-5-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54724 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756576Ab1AMLst (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:48:49 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so1615362fxm.35
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:48:48 -0800 (PST)
In-Reply-To: <1294918868-16263-5-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Thursday, January 13, 2011 5:11 PM
> To: Tony Lindgren
> Cc: Paul Walmsley; Linux OMAP Mailing List; Felipe Balbi
> Subject: [PATCH 4/4] arm: omap: clockdomain: fix compile error
>
> If building OMAP4-only kernel, we will see
> the following compile error:
>

[...]

>
> Fix it.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Looks like you missed the series what I posted and in the
queue.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41712.html



> ---
>  arch/arm/mach-omap2/clockdomain.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-
> omap2/clockdomain.h
> index de3faa2..092256d 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -103,7 +103,8 @@ struct clockdomain {
>  		const char *name;
>  		struct powerdomain *ptr;
>  	} pwrdm;
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +	defined(CONFIG_ARCH_OMAP4)
>  	const u16 clktrctrl_mask;
>  #endif
>  	const u8 flags;
> --

Santosh
