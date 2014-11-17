From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 9/9] net: can: c_can: Add support for TI am4372 DCAN
Date: Mon, 17 Nov 2014 16:19:01 +0200
Message-ID: <546A03D5.5080103@ti.com>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de> <5469E55F.1050502@ti.com> <5469E61D.4050507@pengutronix.de> <5469EABB.10506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40375 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbaKQOTP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2014 09:19:15 -0500
In-Reply-To: <5469EABB.10506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, kernel@pengutronix.de

On 11/17/2014 02:31 PM, Roger Quadros wrote:
> On 11/17/2014 02:12 PM, Marc Kleine-Budde wrote:
>> On 11/17/2014 01:09 PM, Roger Quadros wrote:
>>> AM4372 SoC has 2 DCAN modules. Add compatible id and
>>> raminit driver data for it. The driver data is same as AM3352
>>> but this gives us flexibility to add AM4372 specific quirks
>>> if required later.
>>
>> Strictly speaking we don't need the hunk in
>> "drivers/net/can/c_can/c_can_platform.c" yet, iff the AM4372 dts(i) has
>> this compatible:
>>
>> "ti,am4372-d_can", "ti,am3352-d_can"
> 
> I tried with that, but checkpatch still gives this warning
> WARNING: DT compatible string "ti,am4372-d_can" appears un-documented -- check ./Documentation/devicetree/bindings/
> 
> I guess we can just live with it. Please ignore this patch in that case.

Did you meant that we still need to add it in the binding documentation?
It is not usable by itself so won't it be a problem to exist in documentation?

cheers,
-roger

> 
>>
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/can/c_can.txt | 3 ++-
>>>  drivers/net/can/c_can/c_can_platform.c              | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
>>> index 6731730..5a1d8b0 100644
>>> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
>>> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
>>> @@ -4,7 +4,8 @@ Bosch C_CAN/D_CAN controller Device Tree Bindings
>>>  Required properties:
>>>  - compatible		: Should be "bosch,c_can" for C_CAN controllers and
>>>  			  "bosch,d_can" for D_CAN controllers.
>>> -			  Can be "ti,dra7-d_can" or "ti,am3352-d_can".
>>> +			  Can be "ti,dra7-d_can", "ti,am3352-d_can" or
>>> +			  "ti,am4372-d_can".
>>>  - reg			: physical base address and size of the C_CAN/D_CAN
>>>  			  registers map
>>>  - interrupts		: property with a value describing the interrupt
>>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>>> index f4488e5..a4535d2 100644
>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>> @@ -235,6 +235,7 @@ static const struct of_device_id c_can_of_table[] = {
>>>  	{ .compatible = "bosch,d_can", .data = &d_can_drvdata },
>>>  	{ .compatible = "ti,dra7-d_can", .data = &dra7_dcan_drvdata },
>>>  	{ .compatible = "ti,am3352-d_can", .data = &am3352_dcan_drvdata },
>>> +	{ .compatible = "ti,am4372-d_can", .data = &am3352_dcan_drvdata },
>>>  	{ /* sentinel */ },
>>>  };
>>>  MODULE_DEVICE_TABLE(of, c_can_of_table);
>>>
>>
>> Marc
>>
> 

