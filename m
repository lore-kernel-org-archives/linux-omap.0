From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/7] OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
Date: Wed, 31 Aug 2011 15:24:46 -0700
Message-ID: <87mxep8bip.fsf@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52705 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756714Ab1HaWYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 18:24:49 -0400
Received: by mail-pz0-f41.google.com with SMTP id 4so2096545pzk.0
        for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 15:24:48 -0700 (PDT)
In-Reply-To: <1314026347-21623-4-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 17:19:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Nishanth Menon <nm@ti.com>

Benoit Cousson <b-cousson@ti.com> writes:

> Replace the multiple omap2_get_XXX_device APIs with the new
> omap_hwmod_name_get_dev that uses the hwmod name to get the proper
> device.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 3ae16b4..dab16e0 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -493,8 +493,8 @@ static void __init beagle_opp_init(void)
>  	if (cpu_is_omap3630()) {
>  		struct device *mpu_dev, *iva_dev;
>  
> -		mpu_dev = omap2_get_mpuss_device();
> -		iva_dev = omap2_get_iva_device();
> +		mpu_dev = omap_hwmod_name_get_dev("mpu");
> +		iva_dev = omap_hwmod_name_get_dev("iva");
>  
>  		if (!mpu_dev || !iva_dev) {
>  			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",

Looks fine.

Kevin
