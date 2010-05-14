From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 03/15] omap: mailbox: 2420 should be detected at run-time
Date: Fri, 14 May 2010 14:17:10 +0400
Message-ID: <4BED2326.4090302@ru.mvista.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com> <1273772856-10881-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48183 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759075Ab0ENKR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 06:17:58 -0400
Received: by wyb32 with SMTP id 32so1568394wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 03:17:56 -0700 (PDT)
In-Reply-To: <1273772856-10881-4-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hello.

Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 252e53b..6d17da8 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -431,7 +431,8 @@ err_dsp:
>  static int __devexit omap2_mbox_remove(struct platform_device *pdev)
>  {
>  #if defined(CONFIG_ARCH_OMAP2420)
> -	omap_mbox_unregister(&mbox_iva_info);
> +	if (cpu_is_omap2420())
> +		omap_mbox_unregister(&mbox_iva_info);
>  #endif

    Shouldn't #ifdef be remove then?

WBR, Sergei

