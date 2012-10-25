From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC PATCH 0/6] ARM: OMAP3+: move smartreflex-class3.c to drivers/power/avs
Date: Thu, 25 Oct 2012 10:21:23 +0200
Message-ID: <CAORVsuV9tLQCf+higF4kj4dz==T5Ja6Z++s2byDmUjdNsZTC5A@mail.gmail.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53087 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284Ab2JYIVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 04:21:24 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so1591536vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 01:21:23 -0700 (PDT)
In-Reply-To: <1351028641-20832-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>

Hi Nishant,

On Tue, Oct 23, 2012 at 11:43 PM, Nishanth Menon <nm@ti.com> wrote:
> smartreflex.c now resides in drivers/power/avs directory, but class driver
> is in mach-omap2. High time we move it off to drivers/power/avs.
Great to see the SR fully moved to drivers/.

After review of the code I am OK with the changes besides remarks sent
on the patches:
Acked-by: Jean Pihet <j-pihet@ti.com>

I let Kevin comment on the VC/VP aspect though.

> This series *does not* try to fix VP/VC to be voltage regulator OR introduce
> a new OMAP voltage regulator series. instead, it purely tries to do the minimal
> changes needed to move code to drivers/power/avs as a start.
>
> Baseline: k.org v3.7-rc2
> Testing: Platform: beagle XM C1 (3730)
> while [ 1 ]
> do
> echo -n "0" >/sys/kernel/debug/smartreflex/smartreflex_core/autocomp
> date
> echo -n "1" >/sys/kernel/debug/smartreflex/smartreflex_core/autocomp
> done
> Screen capture after the series: on inductor L5 (VDD2 - core):
> https://plus.google.com/photos/112464029509057661457/albums/5715034179943520193/5802619719180530114
>
> RFC for a view if this is ok as an intermediate step.

Thanks!
Jean

>
> Nishanth Menon (6):
>   PM / AVS / OMAP: move Kconfig definition of smartreflex to avs
>     directory
>   ARM: OMAP: voltage: remove duplicate header definitions
>   ARM: OMAP: voltage: move voltdm_reset to platform_data header
>   ARM: OMAP: SmartReflex: provide SoC integration API for VP
>   ARM: OMAP: SmartReflex: use pr_warn instead of pr_warning
>   PM / AVS / OMAP: move Smartreflex-class3 driver to power/avs
>
>  arch/arm/mach-omap2/Makefile                       |    1 -
>  arch/arm/mach-omap2/sr_device.c                    |    5 ++++
>  arch/arm/mach-omap2/voltage.h                      |    4 ---
>  arch/arm/plat-omap/Kconfig                         |   31 --------------------
>  drivers/power/avs/Kconfig                          |   31 ++++++++++++++++++++
>  drivers/power/avs/Makefile                         |    1 +
>  .../power/avs}/smartreflex-class3.c                |   20 +++++++++----
>  drivers/power/avs/smartreflex.c                    |    2 ++
>  include/linux/platform_data/voltage-omap.h         |    1 +
>  include/linux/power/smartreflex.h                  |   18 ++++++++++++
>  10 files changed, 73 insertions(+), 41 deletions(-)
>  rename {arch/arm/mach-omap2 => drivers/power/avs}/smartreflex-class3.c (75%)
>
> Regards,
> Nishanth Menon
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
