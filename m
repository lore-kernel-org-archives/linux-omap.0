From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: PATCH] OMAP3: add mailbox initialization for 3630
Date: Thu, 25 Mar 2010 18:01:24 -0500
Message-ID: <4BABEB44.4090408@ti.com>
References: <496565EC904933469F292DDA3F1663E602CADC33F9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58179 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab0CYXBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Mar 2010 19:01:31 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CADC33F9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Acked-by: Deepak Chitriki <deepak.chitriki@ti.com>

Deepak

Guzman Lugo, Fernando wrote:
> From 1fcfb230789f904de80c46b69c50879ee3f32ed8 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Thu, 25 Mar 2010 16:55:46 -0600
> Subject: [PATCH] OMAP3: add mailbox initialization for 3630
>
> This patch adds mailbox initialization for 3630
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 18ad931..f9d177b 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -196,7 +196,8 @@ static struct platform_device mbox_device = {
>  
>  static inline void omap_init_mbox(void)
>  {
> -	if (cpu_is_omap2420() || cpu_is_omap3430() || cpu_is_omap44xx()) {
> +	if (cpu_is_omap2420() || cpu_is_omap3430() ||
> +				cpu_is_omap3630() || cpu_is_omap44xx()) {
>  		mbox_device.num_resources = ARRAY_SIZE(omap_mbox_resources);
>  		mbox_device.resource = omap_mbox_resources;
>  	} else {
>   
