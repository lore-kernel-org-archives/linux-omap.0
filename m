From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 15/18] omap3+: sr: disable spamming interrupts
Date: Wed, 02 Mar 2011 16:45:13 +0300
Message-ID: <4D6E49E9.1020307@ru.mvista.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com> <1299063331-27968-16-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41183 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1CBNqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 08:46:35 -0500
Received: by bwz15 with SMTP id 15so154819bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 05:46:34 -0800 (PST)
In-Reply-To: <1299063331-27968-16-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hello.

On 02-03-2011 13:55, Nishanth Menon wrote:

> At times with bad SR configurations especially during silicon bringups,
> we could get continuous spurious interrupts which end up hanging the
> platform in the form of an ISR call for status bits that are
> automatically enabled by the h/w without any s/w clearing option.

> If we detect scenarios where isr was called without the corresponding
> notification bit being set, instead of hanging up the system,
> we will disable interrupt after noting the event in the system log
> to try and keep system sanity and allow developer to debug and fix
> the condition.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> ---
>   arch/arm/mach-omap2/smartreflex.c |   12 ++++++++++--
>   1 files changed, 10 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 49a04ea..d62da3d 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -209,8 +209,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>   		value = irqstat_to_notifier_v2(status);
>   	}
>
> -	if (sr_class->notify)
> -		sr_class->notify(sr_info->voltdm, value);
> +	/* Attempt some resemblence of recovery! */

    Resemblance?

WBR, Sergei
