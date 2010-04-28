From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH] OMAP3EVM: Update pad configuration for wakeup enabled
 pads
Date: Wed, 28 Apr 2010 14:56:17 +0530
Message-ID: <4BD7FF39.8080607@ti.com>
References: <1272369361-25147-1-git-send-email-ranjithl@ti.com> <87fx2hq61m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44303 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab0D1J01 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 05:26:27 -0400
In-Reply-To: <87fx2hq61m.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Kevin,

On Tue, 27-Apr-10 8:46 PM +0530, Kevin Hilman wrote:
> Ranjith Lohithakshan <ranjithl@ti.com> writes:
> 
>> OMAP3530 TRM section 7.4.4.4.2 requires OFFOUTENABLE to be set (active low)
>> if wakeup capabilities are enabled on a pad. During OFF mode testing
>> on OMAP3530 EVM, it was observed that the device was not residing in
>> the OFF state. The device enters into the OFF state and immediately exits
>> from that state as if an IO wakeup event has occured. The issue was traced
>> down to the pad configuration of wkaeup enabled pad's.
> 
> Nice.
> 
>> Also, the pad configuration is included only if the respective drivers are
>> enabled in the defconfig.
> 
> Hmm, do you really want this?  If you don't have the driver enabled,
> you have to rely on the bootloader settings of these pads which may
> also be wrong and trigger an IO wakeup as well.

The thought process was that, for example, if keypad is not enabled in a
system configuration you probably don't want to see a wakeup occurring
if someone presses a key stroke. I understand the concern that you have
raised regarding bootloader mis-configurations. My impression was that
the bootloaders typically set the mux modes and pull up's/downs and dont
really program or enable the wakeup capability. But we cannot depend on
that thumb rule. What is your recommendation?

> 
>> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-omap3evm.c |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
>> index 017bb2f..ce66ef0 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -650,12 +650,16 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
>>  
>>  #ifdef CONFIG_OMAP_MUX
>>  static struct omap_board_mux board_mux[] __initdata = {
>> +#ifdef CONFIG_KEYBOARD_TWL4030
>>  	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
>> -				OMAP_PIN_OFF_INPUT_PULLUP |
>> +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
>>  				OMAP_PIN_OFF_WAKEUPENABLE),
>> +#endif
>> +#ifdef CONFIG_TOUCHSCREEN_ADS7846
>>  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
>> -				OMAP_PIN_OFF_INPUT_PULLUP |
>> +				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
>>  				OMAP_PIN_OFF_WAKEUPENABLE),
>> +#endif
>>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>>  };
>>  #else
>> -- 
>> 1.6.2.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
