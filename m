From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
Date: Fri, 06 Aug 2010 14:35:34 +0200
Message-ID: <4C5C0196.3040106@ti.com>
References: <1281097873-24094-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932594Ab0HFMfk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 08:35:40 -0400
In-Reply-To: <1281097873-24094-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi Charu,

On 8/6/2010 2:31 PM, Varadarajan, Charulatha wrote:
> This patch includes "cpu_is" check for omap44xx cpu inorder to do
> omap_hwmod_late_init() without which hwmods initialization does not
> happen for omap4.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Basak, Partha<p-basak2@ti.com>
> ---
>   arch/arm/mach-omap2/io.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index b89e678..9b15f46 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -345,7 +345,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>   #ifndef CONFIG_PM_RUNTIME
>   	skip_setup_idle = 1;
>   #endif
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
>   		omap_hwmod_late_init(skip_setup_idle);
>
>   	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {

This is already done in this patch:
[PATCH v3 1/7] OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2
https://patchwork.kernel.org/patch/117347/

Benoit
