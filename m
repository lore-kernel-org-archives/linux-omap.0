From: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Add support to parse 'main_clk' info
 from DT
Date: Wed, 14 Aug 2013 07:50:43 -0500
Message-ID: <CAGo_u6rkRX=Wt-516BgG5eQ=w9tGBYN7Pb+gVF51xCr1FrEStw@mail.gmail.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
	<1374560679-14666-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:45726 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315Ab3HNMuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 08:50:44 -0400
Received: by mail-we0-f176.google.com with SMTP id q56so7698682wes.35
        for <linux-omap@vger.kernel.org>; Wed, 14 Aug 2013 05:50:43 -0700 (PDT)
In-Reply-To: <1374560679-14666-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Benoit Cousson <benoit.cousson@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Rajendra,
On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:

[...]
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5cc5123..12fa589 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2381,12 +2386,10 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
>                          oh->name);
>
>                 /* Extract the IO space from device tree blob */
> -               if (!of_have_populated_dt())
> +               if (!np)
>                         return;
>
> -               np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
> -               if (np)
> -                       va_start = of_iomap(np, 0);
> +               va_start = of_iomap(np, 0);

This hunk needs a rebase with 3.11-rc5
due to commit 130142d91467e8a07f3a863db369225a89e84d75
(ARM: OMAP2+: hwmod: rt address space index for DT)

>         } else {
>                 va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
>         }

[...]
