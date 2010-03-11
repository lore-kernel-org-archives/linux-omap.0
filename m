From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 10:59:05 +0200
Message-ID: <1268297945.28571.81.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25175 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab0CKI7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 03:59:39 -0500
In-Reply-To: <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Thu, 2010-03-11 at 09:55 +0100, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> With recent changes happened in OMAP2/3 DSS library for regulator interface, it
> is required to define DSI regulator supply, without this DSS (in turn Fbdev)
> fails to get regulator.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 017bb2f..a05de10 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -514,9 +514,15 @@ static struct regulator_init_data omap3_evm_vdac = {
>  };
> 
>  /* VPLL2 for digital video outputs */
> -static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
> -	.supply		= "vdvi",
> -	.dev		= &omap3_evm_lcd_device.dev,
> +static struct regulator_consumer_supply omap3_evm_vpll2_supplies[] = {
> +	{
> +		.supply		= "vdvi",
> +		.dev		= &omap3_evm_lcd_device.dev,
> +	},

Are you sure vdvi is required by the panel? At least the panel in
3430SDP doesn't require it.

 Tomi


