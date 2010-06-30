From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH] board-omap3beagle: Remove duplicate DVI reset
 gpio handling
Date: Wed, 30 Jun 2010 11:41:09 +0300
Message-ID: <1277887269.2474.117.camel@tubuntu.research.nokia.com>
References: <1277843560-25630-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26426 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab0F3IoK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 04:44:10 -0400
In-Reply-To: <1277843560-25630-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergio Aguirre <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Koen Kooi <koen.kooi@gmail.com>

On Tue, 2010-06-29 at 22:32 +0200, ext Sergio Aguirre wrote:
> Following commit missed to remove this:
> 
>   commit 044d32ffbcb4a1d400088e3575508f46c0a9face
>   Author: Koen Kooi <koen.kooi@gmail.com>
>   Date:   Thu Apr 22 10:23:42 2010 +0200
> 
>       board-omap3-beagle: add DSS2 support
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Cc: Koen Kooi <koen.kooi@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 7b95cc1..867a4ad 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -169,6 +169,8 @@ static void __init beagle_display_init(void)
>  {
>  	int r;
>  
> +	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_INPUT);

It's a reset gpio (actually power up/down, if I recall right), it should
be configured as output, shouldn't it?

 Tomi


