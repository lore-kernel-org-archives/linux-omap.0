From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 5/9] AM3517: Add audio codec platform data
Date: Mon, 19 Apr 2010 21:38:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03228A2700@dbde02.ent.ti.com>
References: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
 <1271672447-3639-6-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852Ab0DSQI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 12:08:26 -0400
In-Reply-To: <1271672447-3639-6-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Monday, April 19, 2010 3:51 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hiremath, Vaibhav; Govindarajan, Sriramakrishnan
> Subject: [PATCH 5/9] AM3517: Add audio codec platform data
> 
> Codec tlv320aic23 is on the second i2c bus. Add the tlv320aic23 info in
> i2c2 board_info.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> index 41f766c..f24e367 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -199,6 +199,9 @@ static struct pca953x_platform_data
> am3517evm_gpio_expander_info_0 = {
>  };
>  static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
>  	{
> +		I2C_BOARD_INFO("tlv320aic23", 0x1A),
> +	},
> +	{
>  		I2C_BOARD_INFO("tca6416", 0x21),
>  		.platform_data = &am3517evm_gpio_expander_info_0,
>  	},
[Aggarwal, Anuj] Similar patch exists at:

http://marc.info/?l=linux-omap&m=125684238323749&w=2 
