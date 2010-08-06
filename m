From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
Date: Fri, 6 Aug 2010 18:05:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C64A2184@dbde02.ent.ti.com>
References: <1281097873-24094-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48814 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933721Ab0HFMfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 08:35:07 -0400
In-Reply-To: <1281097873-24094-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Varadarajan, Charulatha
> Sent: Friday, August 06, 2010 6:01 PM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit; Nayak,
> Rajendra; Varadarajan, Charulatha; Basak, Partha
> Subject: [PATCH] OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
> 
> This patch includes "cpu_is" check for omap44xx cpu inorder to do
> omap_hwmod_late_init() without which hwmods initialization does not
> happen for omap4.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
> ---
>  arch/arm/mach-omap2/io.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index b89e678..9b15f46 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -345,7 +345,7 @@ void __init omap2_init_common_hw(struct
> omap_sdrc_params *sdrc_cs0,
>  #ifndef CONFIG_PM_RUNTIME
>  	skip_setup_idle = 1;
>  #endif
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
Rather use now ....
	if (cpu_class_is_omap2())

>  		omap_hwmod_late_init(skip_setup_idle);
> 
>  	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
