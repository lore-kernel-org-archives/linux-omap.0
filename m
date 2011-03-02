From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 10/18] omap3+: sr: call handler with interrupt disabled
Date: Wed, 02 Mar 2011 16:38:46 +0300
Message-ID: <4D6E4866.6070107@ru.mvista.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com> <1299063331-27968-11-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54088 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1CBNkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 08:40:08 -0500
Received: by bwz15 with SMTP id 15so149318bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 05:40:07 -0800 (PST)
In-Reply-To: <1299063331-27968-11-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de

Hello.

On 02-03-2011 13:55, Nishanth Menon wrote:

> Request the handler irq such that there is no nesting for calls.
> the notifiers are not expected to be nested, further the interrupt
> events for status change should be handled prior to the next event
> else there is a risk of loosing events.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> ---
>   arch/arm/mach-omap2/smartreflex.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 99e4c4f..a4e9f2d 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>   			goto error;
>   		}
>   		ret = request_irq(sr_info->irq, sr_interrupt,
> -				0, name, (void *)sr_info);
> +				IRQF_DISABLED, name, (void *)sr_info);

    Isn't this flag a nop now?

WBR, Sergei
