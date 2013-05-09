From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCHv2] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
Date: Thu, 9 May 2013 13:08:23 -0500
Message-ID: <518BE617.1080509@ti.com>
References: <1366229760-4808-1-git-send-email-dmurphy@ti.com> <516FBD18.3060501@ti.com> <51703BEF.6050804@ti.com> <20130508234745.GV32546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42496 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab3EISI6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 May 2013 14:08:58 -0400
In-Reply-To: <20130508234745.GV32546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <v-stehle@ti.com>, b-cousson@ti.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Tony
On 05/08/2013 06:47 PM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [130418 11:35]:
>> On 04/18/2013 04:30 AM, Vincent Stehl=C3=A9 wrote:
>>> On 04/17/2013 10:16 PM, Dan Murphy wrote:
>>>> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-pan=
da-es
>>>> are different.
>>> (..)
>>>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/=
boot/dts/omap4-panda-common.dtsi
>>>> index 03bd60d..0c48f6b 100644
>>>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>>> (..)
>>>> @@ -135,6 +136,25 @@
>>>>  			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
>>>>  		>;
>>>>  	};
>>>> +
>>>> +	led_gpio_pins: pinmux_leds_pins {
>>>> +		pinctrl-single,pins =3D <
>>>> +		>;
>>>> +	};
>>>> +};
>>> Hi,
>>>
>>> FYI, there was a recent discussion precisely on this topic, where T=
omy
>>> suggested to remove the empty section:
>>> http://marc.info/?l=3Dlinux-omap&m=3D136546635409232&w=3D2
>>>
>>> Apart from that, I just tested your patch on top of Tomy's
>>> omap-for-v3.10/dt branch and it is working fine for me on PandaBoar=
ds
>>> EA3, A4 and ES.
>>>
>>> Tested-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
>>>
>>> Best regards,
>>>
>>> V.
>>>
>> Thanks for testing Vincent
>>
>> Is there a way to append the data to an already existing node?
>> I do not see a clean way.
> If you have something in omap4-panda-common.dtsi and the same entry
> in the omap4-panda-es.dts, the entries in omap4-panda-es.dts will
> override and append the entries in omap4-panda-common.dtsi.
>
> So I think you can avoid the empty entry that way.
>
> Regards,
>
> Tony
Thanks but the issue is the led entry would not appear in the common fi=
le so there is nothing to override.
Can we cleanly append to omap4_pmx_core without overriding the whole no=
de?
I don't want to recreate the pmx_core node in the es file.

Dan

--=20
------------------
Dan Murphy

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
