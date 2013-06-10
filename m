From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v1 0/3] PM / AVS: SmartReflex: use omap_sr * for class interfaces
Date: Mon, 10 Jun 2013 10:45:48 -0700
Message-ID: <87vc5ldflf.fsf@linaro.org>
References: <1369652964-14484-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42131 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3FJRpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 13:45:52 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so4002581pbb.14
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 10:45:51 -0700 (PDT)
In-Reply-To: <1369652964-14484-1-git-send-email-andrii.tseglytskyi@ti.com>
	(Andrii Tseglytskyi's message of "Mon, 27 May 2013 14:09:21 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

> SmartReflex driver interface is natively divided to two parts:
>
> - external SmartReflex interface
> - interface between SmartReflex driver and SmartReflex Class
>
> Functions which belong to AVS class interface can use
> struct omap_sr* instead of struct voltatedomain*, to provide a
> direct connection between SR driver and SR class. This allows
> us to optimize and not do additional lookups where none is
> required.
>
> Patches are based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> tag: v3.10-rc2
>
> Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK
>
> Available on GitHub:
> https://github.com/andriit/linux-omap-k3.8/commits/avs_sr_driver_std_class_interfaces_v01
>
> Andrii Tseglytskyi (3):
>   PM / AVS: SmartReflex: use omap_sr * for errgen interfaces
>   PM / AVS: SmartReflex: use omap_sr * for minmax interfaces
>   PM / AVS: SmartReflex: use omap_sr * for enable/disable interface
>
>  arch/arm/mach-omap2/smartreflex-class3.c |    8 ++--
>  drivers/power/avs/smartreflex.c          |   63 +++++++++++++++---------------
>  include/linux/power/smartreflex.h        |   10 ++---
>  3 files changed, 40 insertions(+), 41 deletions(-)

Thanks, queuing this series for v3.11.

Kevin
