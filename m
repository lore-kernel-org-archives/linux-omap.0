From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/3] ARM: DTS: OMAP3: beagle/overo: mux console UART, enable wakeup
Date: Mon, 03 Jun 2013 14:26:42 -0700
Message-ID: <87zjv6khrh.fsf@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
	<1370040357-25794-2-git-send-email-khilman@linaro.org>
	<51AC639F.3040504@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:60152 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3FCV0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 17:26:46 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2138637pbb.36
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 14:26:45 -0700 (PDT)
In-Reply-To: <51AC639F.3040504@epfl.ch> (Florian Vaussard's message of "Mon,
	03 Jun 2013 11:36:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Florian Vaussard <florian.vaussard@epfl.ch> writes:

> Hello Kevin,
>
> On 06/01/2013 12:45 AM, Kevin Hilman wrote:
>> Ensure the console uart (UART3) on these boards is mux'd correctly, and
>> IO ring wakeup is enabled.
>>
>> This is needed for serial console wakeups when using DT boot.
>>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> ---
>>   arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++++++
>>   arch/arm/boot/dts/omap3-beagle.dts    | 12 ++++++++++++
>>   arch/arm/boot/dts/omap3-overo.dtsi    | 14 ++++++++++++++
>>   3 files changed, 40 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> index 3046d1f..ca067b0 100644
>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> @@ -126,3 +126,17 @@
>>   	mode = <3>;
>>   	power = <50>;
>>   };
>> +
>> +&omap3_pmx_core {
>> +	uart3_pins: pinmux_uart3_pins {
>> +		pinctrl-single,pins = <
>> +			0x16e 0x4100	/* uart3_rx_irrx.uart3_rx_irrx WAKEUP | INPUT | MODE0 */
>> +			0x170 0x0	/* uart3_tx_irtx.uart3_tx_irtx OUTPUT | MODE0 */
>
> If you go through Benoit's tree, could you use the newly introduced
> constants [1]? They are defined
> in include/dt-bindings/pinctrl/omap.h. The above will look:
>
> 			0x16e (PIN_INPUT | WAKEUP_EVENT | MUX_MODE0)
> /* uart3_rx_irrx.uart3_rx_irrx */
> 			0x170 (PIN_OUTPUT | MUX_MODE0)			/* uart3_tx_irtx.uart3_tx_irtx */

Excellent, thanks for the pointer.  I hadn't yet read through your
pre-processor series, but I really like the readability improvements.

I'll respin these on top of your changes.

Thanks,

Kevin
