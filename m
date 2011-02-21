From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Mon, 21 Feb 2011 23:53:00 +0100
Message-ID: <4D62ECCC.3040208@ti.com>
References: <20110217171747.GC14574@legolas.emea.dhcp.ti.com> <4D5D59E5.6020307@ti.com> <20110217173711.GF14574@legolas.emea.dhcp.ti.com> <4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com> <4D5E7DFF.7020609@ti.com> <20110218154135.GF11151@legolas.emea.dhcp.ti.com> <4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com> <4D62DAF0.9050301@ti.com> <20110221220815.GG15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44456 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab1BUWxJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 17:53:09 -0500
In-Reply-To: <20110221220815.GG15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

On 2/21/2011 11:08 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110221 13:35]:
>> On 2/21/2011 7:22 PM, Tony Lindgren wrote:
>>> * Cousson, Benoit<b-cousson@ti.com>   [110218 08:49]:
>>>> ---
>>>>  From b2190f0d339c9d843eb5e370d0db8b7090fbcfab Mon Sep 17 00:00:00 2001
>>>> From: Benoit Cousson<b-cousson@ti.com>
>>>> Date: Fri, 18 Feb 2011 14:01:06 +0100
>>>> Subject: [PATCH] OMAP4: hwmod data: Add rev and dev_attr fields in McSPI
>>>>
>>>> - Add a rev attribute to identify various McSPI IP version.
>>>> - Add a dev_attr structure to provide the number of chipselect
>>>>    supported by the instance.
>>>
>>> Looks like one seems to be wrapped and does not apply even after unwapping..
>>
>> #$*%&!@ Thunderbird...
>
> :) The earlier one had double spaces in the beginning of each line in
> addition to the line wrapping..

...The Thunderbird wrapping option is more powerful than expected...

>> Here is the same one without the "enable word wrap" and attached as well just in case.
>>
>> It should apply on your omap-for-linus branch at commit df7ffd3.
>
> Thanks, I'll apply it to omap-for-linus. The omap4 hang seems to be
> caused by the timer patch, the following fixes it. How do you want
> to deal with fixing this issue?

I guess it is due to the early_init change?

I have some concern bypassing hwmod to handle system timer. The idea, 
before the introduction of the early_init, was to use hwmod for early 
initialization as well including timers. It will become a little bit 
harder now :-(

I still didn't fully understand the rational behind that early_init for 
timer BTW.

Meanwhile, the following will just prevent the fmwk to reset and idle 
the timer during hwmod_init.

Regards,
Benoit


--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if 
*omap44xx_timer1_slaves[] = {
  static struct omap_hwmod omap44xx_timer1_hwmod = {
  	.name		= "timer1",
  	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
  	.mpu_irqs	= omap44xx_timer1_irqs,
  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
  	.main_clk	= "timer1_fck",

