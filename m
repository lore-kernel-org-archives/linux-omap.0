From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] bus: omap_l3_noc: Fix offset for DRA7 CLK1_HOST_CLK1_2
 instance
Date: Mon, 4 May 2015 09:27:32 -0700
Message-ID: <20150504162731.GO24469@atomide.com>
References: <1429224150-28712-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49013 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbEDQ1e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:27:34 -0400
Content-Disposition: inline
In-Reply-To: <1429224150-28712-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Illia Smyrnov <illia.smyrnov@globallogic.com>

* Nishanth Menon <nm@ti.com> [150416 15:43]:
> From: Illia Smyrnov <illia.smyrnov@globallogic.com>
> 
> The base address for DRA7 CLK1_HOST_CLK1_2 host instance is
> 0x44800000, so correct offset is 0x800000. DRA7 TRM rev X(fewb 2015)
> has updates for this information.
> 
> With wrong offset these errors are not correctly cleared by the L3
> IRQ handler and cause an continuous interrupt scenario and system lockup.
> 
> Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/bus/omap_l3_noc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
> index 95254585db86..a314d800f394 100644
> --- a/drivers/bus/omap_l3_noc.h
> +++ b/drivers/bus/omap_l3_noc.h
> @@ -274,7 +274,7 @@ static struct l3_flagmux_data dra_l3_flagmux_clk1 = {
>  
>  static struct l3_target_data dra_l3_target_data_clk2[] = {
>  	{0x0,	"HOST CLK1",},
> -	{0x0,	"HOST CLK2",},
> +	{0x800000, "HOST CLK2",},
>  	{0xdead, L3_TARGET_NOT_SUPPORTED,},
>  	{0x3400, "SHA2_2",},
>  	{0x0900, "BB2D",},

Applying into omap-for-v4.1/fixes thanks.

Tony
