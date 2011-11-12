From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: DEBUG_LL on OMAP1 (was Re: [PATCH] ARM: OMAP: Fix map_io for Amstrad
 E3)
Date: Sat, 12 Nov 2011 14:16:42 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1111121403370.6049@dell>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi> <20111109231900.GS31337@atomide.com> <20111109232525.GT31337@atomide.com> <20111109233900.GP15294@n2100.arm.linux.org.uk> <20D8B951-2E77-42DF-B735-6062994D47D5@iki.fi> <20111110000421.GU31337@atomide.com>
 <alpine.DEB.2.00.1111102349170.19713@dell> <20111110232349.GY31337@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:55963 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab1KLMQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Nov 2011 07:16:48 -0500
In-Reply-To: <20111110232349.GY31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, 10 Nov 2011, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [111110 13:31]:
>> --- a/arch/arm/mach-omap1/clock_data.c
>> +++ b/arch/arm/mach-omap1/clock_data.c
>> @@ -774,14 +774,6 @@ int __init omap1_clk_init(void)
>>  	int crystal_type = 0; /* Default 12 MHz */
>>  	u32 reg, cpu_mask;
>>
>> -#ifdef CONFIG_DEBUG_LL
>> -	/*
>> -	 * Resets some clocks that may be left on from bootloader,
>> -	 * but leaves serial clocks on.
>> -	 */
>> -	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
>> -#endif
>> -
>>  	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
>>  	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
>>  	omap_writew(reg, SOFT_REQ_REG);
>
> Hmm that should keep the serial clocks on. What other bit(s) need to
> be on in MOD_CONF_CTRL_0 for you in addition to the serial bits?

On my board those serial bits are zero during the early boot (and the
serial works). By setting those bits the clock will switch from 12 ->
48 MHz and I guess the baud rate will change and that's why the output
turns into garbage.

So I think the code should reset the other bits, and leave serial bits
untouched:

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 1297bb5..b3b69d8 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -788,7 +788,11 @@ int __init omap1_clk_init(void)
  	 * Resets some clocks that may be left on from bootloader,
  	 * but leaves serial clocks on.
  	 */
-	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
+	reg = omap_readl(MOD_CONF_CTRL_0) &
+		((1 << CONF_MOD_UART1_CLK_MODE_R) |
+		 (1 << CONF_MOD_UART2_CLK_MODE_R) |
+		 (1 << CONF_MOD_UART3_CLK_MODE_R));
+	omap_writel(reg, MOD_CONF_CTRL_0);
  #endif

  	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */

A.
