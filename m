From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: sram: skip the first 16K on OMAP3 HS
Date: Wed, 29 Aug 2012 08:29:33 -0700
Message-ID: <CAMQu2gy+4oXgekvqbXDQ9kRr7hmojAZ+RqiZRg97uG1OBo_Ndg@mail.gmail.com>
References: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi> <1346253871-5761-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:50081 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab2H2P3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 11:29:55 -0400
Received: by obbwc20 with SMTP id wc20so3528288obb.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 08:29:54 -0700 (PDT)
In-Reply-To: <1346253871-5761-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Wed, Aug 29, 2012 at 8:24 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> In some OMAP3 HS devices (at least Nokia N9 and N950), the public SRAM
> seems to conflict with secure portition of SRAM. When booting the 3.6-rc3
> kernel (and also earlier) on these devices, the kernel gets tainted with
> tons of the following warnings:
>
>         [    6.894348] In-band Error seen by MPU  at address 0
>         [...]
>         [    6.894378] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
>
> Fix this by skipping the first 16K of the public SRAM. (Note that the
> mapping could not be changed, as it resulted in secure monitor call
> failure in save_secure_sram().)
>
> This will leave 12K SRAM available that should be still sufficient. The
> patch has been boot tested with vanilla 3.6-rc3 on N900, N950 and N9.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/plat-omap/sram.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
Looks good.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
