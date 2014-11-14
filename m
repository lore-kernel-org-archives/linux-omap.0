From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Fri, 14 Nov 2014 18:22:21 +0200
Message-ID: <54662C3D.8050103@ti.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com> <1415881371-4982-7-git-send-email-rogerq@ti.com> <5464BB38.7020402@pengutronix.de> <5464C2C4.2070907@ti.com> <5464C3B1.2030908@pengutronix.de> <5464C4E8.9060103@ti.com> <5464C609.9070800@pengutronix.de> <20141113174044.GN26481@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49709 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965050AbaKNQWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2014 11:22:38 -0500
In-Reply-To: <20141113174044.GN26481@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: wg@grandegger.com, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org

On 11/13/2014 07:40 PM, Tony Lindgren wrote:
> * Marc Kleine-Budde <mkl@pengutronix.de> [141113 06:55]:
>> On 11/13/2014 03:49 PM, Roger Quadros wrote:
>>> On 11/13/2014 04:44 PM, Marc Kleine-Budde wrote:
>>>> On 11/13/2014 03:40 PM, Roger Quadros wrote:
>>>>> On 11/13/2014 04:07 PM, Marc Kleine-Budde wrote:
>>>>>> On 11/13/2014 01:22 PM, Roger Quadros wrote:
>>>>>>> The SoC contains 2 DCAN modules. Add them.
>>>>>>>
>>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/am4372.dtsi | 22 ++++++++++++++++++++++
>>>>>>>  1 file changed, 22 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>>>>>>> index 899c57c..12fb1db 100644
>>>>>>> --- a/arch/arm/boot/dts/am4372.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/am4372.dtsi
>>>>>>> @@ -901,6 +901,28 @@
>>>>>>>  			compatible = "mmio-sram";
>>>>>>>  			reg = <0x40300000 0x40000>; /* 256k */
>>>>>>>  		};
>>>>>>> +
>>>>>>> +		dcan0: can@481cc000 {
>>>>>>> +			compatible = "ti,am3352-d_can";
>>>>>>
>>>>>> You should add "ti,am4372-d_can" as first compatible here.
>>>>>>
>>>>> We don't have a separate compatible id for am4372-d_can
>>>>> as it the IP exactly same as am3352-d_can.
>>>>
>>>> Having the "ti,am4372-d_can" compatible gives you the freedom to add
>>>> some spacial handling for the IP if there turns that you need to without
>>>> needing to modify the device tree. (We do this on imx.)
>>>
>>> Agreed. On OMAP platforms we don't add new compatible IDs unless we really need to.
>>> Can we add "ti,am4372-d_can" even if it is not mentioned in Documentation/devicetree/bindings?
>>>
>>> Tony what is your preference?
>>
>> I don't insist, do it the Omap way :)
> 
> I agree it's good to add if we need to add custom handling later on.

As of now I don't foresee any custom handling for am4372-d_can vs am3352-d_can, but I can
add am4372-d_can anyways. In that case, do I need to mention it in 
Documentation/devicetree/bindings/net/can/c_can.txt?

I guess not, cause we don't do anything specific to am4372-d_can there.

cheers,
-roger

