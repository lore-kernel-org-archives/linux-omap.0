From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: Fix scrm compatible for dm814x
Date: Wed, 03 Jun 2015 22:08:40 +0300
Message-ID: <556F50B8.6000903@cogentembedded.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com> <1433348601-8966-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34518 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbbFCTIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 15:08:44 -0400
Received: by laew7 with SMTP id w7so15698424lae.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2015 12:08:43 -0700 (PDT)
In-Reply-To: <1433348601-8966-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>

Hello.

On 06/03/2015 07:23 PM, Tony Lindgren wrote:

> Fix scrm compatible for dm814x.

    So, scrm...

> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/control.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index af95a62..364925c 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -649,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
>   	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
>   	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
>   	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
> +	{ .compatible = "ti,dm814-scm", .data = &ctrl_data },

    ... or scm? :-)

>   	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
>   	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
>   	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },

WBR, Sergei

