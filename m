From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller in board_init
Date: Thu, 27 Jan 2011 11:58:33 -0800
Message-ID: <874o8um846.fsf@ti.com>
References: <1295968956-10166-1-git-send-email-hvaibhav@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46174 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482Ab1A0T6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 14:58:38 -0500
Received: by mail-gx0-f171.google.com with SMTP id 8so792020gxk.30
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 11:58:37 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
	(Vaibhav Hiremath's message of "Tue, 25 Jan 2011 20:58:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hiremath, Vaibhav
>> Sent: Tuesday, January 25, 2011 8:53 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Hiremath, Vaibhav; Varadarajan, Charulatha
>> Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller
>> in board_init
>> 
>> With addition of hwmod support to gpio, the ethernet controller
>> goes undetected for OMAP35xEVM. So explicitly assert the reset signal to
>> ethernet controller smsc911x -
>> 
>> 	- GPIO7 (>=RevG version of EVM's)
>> 	- GPIO64 (<=RevD version of EVM's)
>> 
>> This patch is based on intial version from Charulatha V, reference
>> to original discussion -
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35784.html
>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Since Kevin reported that this patch doesn't get applied cleanly,
>> so I am reposting it again after making sure that it gets applied cleanly.
>> 
> [Hiremath, Vaibhav] Oops, missed linux-arm-kernel list, adding here.
>
> Not sure whether I need to repost keeping linux-arm-kernel?

Yes, please repost.

Kevin

>
>>  arch/arm/mach-omap2/board-omap3evm.c |   39
>> +++++++++++++++++++++++++++++++++-
>>  1 files changed, 38 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
>> omap2/board-omap3evm.c
>> index 323c380..97e0f65 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -58,6 +58,13 @@
>>  #define OMAP3EVM_ETHR_ID_REV	0x50
>>  #define OMAP3EVM_ETHR_GPIO_IRQ	176
>>  #define OMAP3EVM_SMSC911X_CS	5
>> +/*
>> + * Eth Reset signal
>> + *	64 = Generation 1 (<=RevD)
>> + *	7 = Generation 2 (>=RevE)
>> + */
>> +#define OMAP3EVM_GEN1_ETHR_GPIO_RST	64
>> +#define OMAP3EVM_GEN2_ETHR_GPIO_RST	7
>> 
>>  static u8 omap3_evm_version;
>> 
>> @@ -124,10 +131,15 @@ static struct platform_device
>> omap3evm_smsc911x_device = {
>> 
>>  static inline void __init omap3evm_init_smsc911x(void)
>>  {
>> -	int eth_cs;
>> +	int eth_cs, eth_rst;
>>  	struct clk *l3ck;
>>  	unsigned int rate;
>> 
>> +	if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
>> +		eth_rst = OMAP3EVM_GEN1_ETHR_GPIO_RST;
>> +	else
>> +		eth_rst = OMAP3EVM_GEN2_ETHR_GPIO_RST;
>> +
>>  	eth_cs = OMAP3EVM_SMSC911X_CS;
>> 
>>  	l3ck = clk_get(NULL, "l3_ck");
>> @@ -136,6 +148,27 @@ static inline void __init
>> omap3evm_init_smsc911x(void)
>>  	else
>>  		rate = clk_get_rate(l3ck);
>> 
>> +	/* Configure ethernet controller reset gpio */
>> +	if (cpu_is_omap3430()) {
>> +		if (gpio_request(eth_rst, "SMSC911x gpio") < 0) {
>> +			pr_err(KERN_ERR "Failed to request %d for smsc911x\n",
>> +					eth_rst);
>> +			return;
>> +		}
>> +
>> +		if (gpio_direction_output(eth_rst, 1) < 0) {
>> +			pr_err(KERN_ERR "Failed to set direction of %d for" \
>> +					" smsc911x\n", eth_rst);
>> +			return;
>> +		}
>> +		/* reset pulse to ethernet controller*/
>> +		usleep_range(150, 220);
>> +		gpio_set_value(eth_rst, 0);
>> +		usleep_range(150, 220);
>> +		gpio_set_value(eth_rst, 1);
>> +		usleep_range(1, 2);
>> +	}
>> +
>>  	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
>>  		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
>>  			OMAP3EVM_ETHR_GPIO_IRQ);
>> @@ -658,6 +691,10 @@ static struct omap_board_mux board_mux[] __initdata =
>> {
>>  				OMAP_PIN_OFF_WAKEUPENABLE),
>>  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
>>  				OMAP_PIN_OFF_INPUT_PULLUP |
>> OMAP_PIN_OFF_OUTPUT_LOW),
>> +	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
>> +				OMAP_PIN_OFF_NONE),
>> +	OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
>> +				OMAP_PIN_OFF_NONE),
>>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>>  };
>>  #endif
>> --
>> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
