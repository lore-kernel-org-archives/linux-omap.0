From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 6/7] omap4: Workaround for CMD line reset.
Date: Tue, 14 Sep 2010 21:17:23 +0530
Message-ID: <AANLkTimd5pAFPfGfODXA1FrC4TEoAy9fGgdVibHpB-vH@mail.gmail.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
	<1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
	<1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
	<1284031395-25988-5-git-send-email-santosh.shilimkar@ti.com>
	<1284031395-25988-6-git-send-email-santosh.shilimkar@ti.com>
	<1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45392 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab0INPrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 11:47:24 -0400
Received: by vws3 with SMTP id 3so98792vws.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 08:47:23 -0700 (PDT)
In-Reply-To: <1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

Hi Madhu,

On Thu, Sep 9, 2010 at 4:53 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> From: Madhusudhan Chikkature <madhu.cr@ti.com>
>
> Add a delay after CMD line reset to accomdate the reset to complete.
> The SYSCTL seems to reflect SRC immediately which might not really
> be indicating the complete of reset. This is observed only with ES2.0
> silicon
>
> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A08 ++++++++
> =A01 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 4a8776f..1c359f0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -986,6 +986,14 @@ static inline void omap_hsmmc_reset_controller_f=
sm(struct omap_hsmmc_host *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i++ < limit))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* On OMAP4 ES2 the SRC is zero in the first loop its=
elf strangely
> + =A0 =A0 =A0 =A0* vs on ES1 it takes some time.
> + =A0 =A0 =A0 =A0* Could be a an issue on ES2 to indicate reset compl=
ete even before
> + =A0 =A0 =A0 =A0* it is complete.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 udelay(500);

Since the above work around is applicable only for OMAP4 ES2 ,
shouldn't this udelay be avoided for other OMAP versions

Regards,
Kishore
> +
> =A0 =A0 =A0 =A0if (OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(mmc_dev(host->mmc),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Timeout waiting on co=
ntroller reset in %s\n",
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
