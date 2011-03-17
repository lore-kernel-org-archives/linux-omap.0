From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 04/19] OMAP3+: voltage: remove spurious pr_notice for debugfs
Date: Thu, 17 Mar 2011 07:55:00 -0700
Message-ID: <8762rhbxvf.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52621 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753782Ab1CQOzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 10:55:04 -0400
Received: by mail-iy0-f176.google.com with SMTP id 12so3506891iyj.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 07:55:03 -0700 (PDT)
In-Reply-To: <1299338962-5602-5-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> cat of debugfs entry for vp_volt provides voltage. The additional pr_notice
> is just spam on console and provides no additional information.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, queueing for 2.6.39-rc fixes cycle.

Kevin

> ---
>  arch/arm/mach-omap2/voltage.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 1b40aa0..53c399f 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -150,7 +150,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
>  	}
>  
>  	vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
> -	pr_notice("curr_vsel = %x\n", vsel);
>  
>  	if (!vdd->pmic_info->vsel_to_uv) {
>  		pr_warning("PMIC function to convert vsel to voltage"
