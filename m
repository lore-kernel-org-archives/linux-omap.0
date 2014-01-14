From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCHv2 9/9] arm: dts: am43x-gp-evm: Add matrix gpio keys.
Date: Tue, 14 Jan 2014 15:21:41 +0100
Message-ID: <52D547F5.2080307@baylibre.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com> <1387456421-21379-10-git-send-email-sourav.poddar@ti.com> <52D417A1.9060007@ti.com> <20140114131444.GD10818@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34632 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaANOVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 09:21:45 -0500
Received: by mail-wi0-f182.google.com with SMTP id ex4so771980wid.9
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 06:21:44 -0800 (PST)
In-Reply-To: <20140114131444.GD10818@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, sourav <sourav.poddar@ti.com>
Cc: devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, lokeshvutla@ti.com

Hi Felipe,

On 14/01/2014 14:14, Felipe Balbi wrote:
> On Mon, Jan 13, 2014 at 10:13:13PM +0530, sourav wrote:
>> Benoit,
>>
>> On Thursday 19 December 2013 06:03 PM, Sourav Poddar wrote:
>>> Add gpio keys node for am43x gp evm.
>>>
>>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>>> ---
>>>   arch/arm/boot/dts/am437x-gp-evm.dts |   21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
>>> index 0dc248d..4eb72b8 100644
>>> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
>>> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
>>> @@ -13,6 +13,7 @@
>>>   #include "am4372.dtsi"
>>>   #include<dt-bindings/pinctrl/am43xx.h>
>>>   #include<dt-bindings/pwm/pwm.h>
>>> +#include<dt-bindings/gpio/gpio.h>
>>>
>>>   / {
>>>   	model = "TI AM437x GP EVM";
>>> @@ -24,6 +25,26 @@
>>>   		brightness-levels =<0 51 53 56 62 75 101 152 255>;
>>>   		default-brightness-level =<8>;
>>>   	};
>>> +
>>> +	matrix_keypad: matrix_keypad@0 {
>>> +		compatible = "gpio-matrix-keypad";
>>> +		debounce-delay-ms =<5>;
>>> +		col-scan-delay-us =<2>;
>>> +
>>> +		row-gpios =<&gpio3 21 GPIO_ACTIVE_HIGH /* Bank3, pin21 */
>>> +				&gpio4 3 GPIO_ACTIVE_HIGH /* Bank4, pin3 */
>>> +				&gpio4 2 GPIO_ACTIVE_HIGH>; /* Bank4, pin2 */
>>> +
>>> +		col-gpios =<&gpio3 19 GPIO_ACTIVE_HIGH /* Bank3, pin19 */
>>> +				&gpio3 20 GPIO_ACTIVE_HIGH>; /* Bank3, pin20 */
>>> +
>>> +		linux,keymap =<0x00000201      /* P1 */
>>> +				0x00010202      /* P2 */
>>> +				0x01000067      /* UP */
>>> +				0x0101006a      /* RIGHT */
>>> +				0x02000069      /* LEFT */
>>> +				0x0201006c>;      /* DOWN */
>>> +		};
>>>   };
>>>
>>>   &am43xx_pinmux {
>>
>> ping on this series, this series is lying for a while.
>> This series is based on your for_3.14 branch.
>
> Benoit, do you need us to do anything else to get this merged ? Sourav
> already rebased the patches as you requested back in December 19th.

Nope, I've just needed more BW. I'll apply it ASAP.

Thanks,
Benoit

