From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH RFC:] FIX: OMAP3EVM: Ethernet controller smsc911x reset
Date: Sat, 25 Sep 2010 17:18:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030C8FBC4D@dbde02.ent.ti.com>
References: <1285414593-28013-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab0IYLs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 07:48:28 -0400
In-Reply-To: <1285414593-28013-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "Varadarajan, Charulatha" <charu@ti.com>

Sanjeev,

With GPIO hwmod series, OMAP3EVM board is not up with DHCP + nfs root.
This issue was reported by Kevin.

The root cause of this issue is that during OMAP3EVM board init, the
Ethernet controller (smsc911x) is not reset and it relies on the uboot 
configurations for it's operations. The reset GPIO pin used for this
purpose is not even reserved.

After gpio hmwod series are merged, this patch is required to make the
EVM board working. Also omap3evm_init_smsc911x() needs to be fixed
including CS settings and other required settings for Ethernet controller.

Links to related discussions:
http://www.spinics.net/lists/linux-omap/msg37234.html
http://www.spinics.net/lists/linux-omap/msg36698.html
http://www.spinics.net/lists/linux-omap/msg36799.html

The below patch is tested on OMAP3 EVM board (ES3.1).

Thanks,
V Charulatha


> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Saturday, September 25, 2010 5:07 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; tony@atomide.com; Premi, Sanjeev;
> Varadarajan, Charulatha
> Subject: [PATCH RFC:] FIX: OMAP3EVM: Ethernet controller smsc911x reset
> 
> Do reset of Ethernet controller smsc911x using OMAP gpio7
> while initializing the Ethernet controller.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index f76d9c0..54a7e20 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -55,6 +55,7 @@
>  #define OMAP3EVM_ETHR_SIZE	1024
>  #define OMAP3EVM_ETHR_ID_REV	0x50
>  #define OMAP3EVM_ETHR_GPIO_IRQ	176
> +#define OMAP3EVM_ETHR_GPIO_RST  7
>  #define OMAP3EVM_SMSC911X_CS	5
> 
>  static u8 omap3_evm_version;
> @@ -134,6 +135,20 @@ static inline void __init
> omap3evm_init_smsc911x(void)
>  	else
>  		rate = clk_get_rate(l3ck);
> 
> +	/* Configure ethernet controller reset gpio */
> +	if (gpio_request(OMAP3EVM_ETHR_GPIO_RST, "SMSC911x gpio") < 0) {
> +		pr_err(KERN_ERR "Failed to request GPIO8 for smsc911x
> gpio\n");
> +		return;
> +	}
> +
> +	gpio_direction_output(OMAP3EVM_ETHR_GPIO_RST, 1);
> +
> +	/* reset pulse to ethernet controller*/
> +	gpio_set_value(OMAP3EVM_ETHR_GPIO_RST, 0);
> +	usleep_range(150, 220);
> +	gpio_set_value(OMAP3EVM_ETHR_GPIO_RST, 1);
> +	usleep_range(1, 2);
> +
>  	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
>  		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
>  			OMAP3EVM_ETHR_GPIO_IRQ);
> --
> 1.7.0.4

