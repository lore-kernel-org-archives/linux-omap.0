From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 3/3] OMAP4: PM: VC: make omap_vc_i2c_init static
Date: Thu, 02 Jun 2011 16:47:21 -0700
Message-ID: <87k4d3n6d2.fsf@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
	<1306711180-8631-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49653 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578Ab1FBXrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 19:47:24 -0400
Received: by mail-pz0-f49.google.com with SMTP id 28so862552pzk.36
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 16:47:23 -0700 (PDT)
In-Reply-To: <1306711180-8631-4-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sun, 29 May 2011 16:19:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> The only user of omap_vc_i2c_init is vc.c itself, makes
> no reason for us to expose it out.
>
> This also fixes the sparse warning:
> arch/arm/mach-omap2/vc.c:207:13: warning: symbol 'omap_vc_i2c_init' was not declared. Should it be static?
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, will fold into 'OMAP3+: VC: make I2C config programmable with
PMIC-specific settings'

Kevin

> ---
>  arch/arm/mach-omap2/vc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 42c77a8..d0b52cc 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -204,7 +204,7 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
>   * channel registers.  All other VC channels will use the
>   * same configuration.
>   */
> -void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
> +static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
>  {
>  	struct omap_vc_channel *vc = voltdm->vc;
>  	static bool initialized;
