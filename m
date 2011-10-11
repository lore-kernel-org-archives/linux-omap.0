From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFT/PATCH 7/7] arm: omap: smartreflex: micro-optimization for
 sanity check
Date: Tue, 11 Oct 2011 15:22:33 +0400
Message-ID: <4E9426F9.2080601@ru.mvista.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com> <1318249579-4089-7-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52160 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752266Ab1JKLX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 07:23:26 -0400
In-Reply-To: <1318249579-4089-7-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hello.

On 10-10-2011 16:26, Felipe Balbi wrote:

> val&&  (val != 1) == val>  1

> Signed-off-by: Felipe Balbi<balbi@ti.com>
> ---
>   arch/arm/mach-omap2/smartreflex.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 7bdabfa..4b0d6a8 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -866,7 +866,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>   	}
>
>   	/* Sanity check */
> -	if (val&&  (val != 1)) {
> +	if (val>  1) {
>   		pr_warning("%s: Invalid argument %lld\n", __func__, val);

    The format specified should be "%llu"?

WBR, Sergei

