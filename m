From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap4: hwmod: Enable the keypad
Date: Thu, 24 Feb 2011 11:58:39 +0100
Message-ID: <4D6639DF.2040009@ti.com>
References: <1298526157-2856-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42359 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab1BXK6m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 05:58:42 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1OAwfAs016927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 04:58:41 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1OAwfh1001171
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 04:58:41 -0600 (CST)
In-Reply-To: <1298526157-2856-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/24/2011 6:42 AM, Datta, Shubhrajyoti wrote:
> From: Shubhrajyoti D<shubhrajyoti@ti.com>
>
> Enable the keypad in the hwmod database.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>

Acked-by: Benoit Cousson<b-cousson@ti.com>

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 79a8601..5af80d6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5056,7 +5056,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_iva_seq1_hwmod,
>
>   	/* kbd class */
> -/*	&omap44xx_kbd_hwmod, */
> +	&omap44xx_kbd_hwmod,
>
>   	/* mailbox class */
>   	&omap44xx_mailbox_hwmod,

