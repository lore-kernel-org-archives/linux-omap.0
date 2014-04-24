From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
Date: Thu, 24 Apr 2014 20:53:29 +0400
Message-ID: <53594189.1090508@cogentembedded.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com> <53591669.7060502@cogentembedded.com> <5359209F.7000308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:46356 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbaDXQxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 12:53:30 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so2189197lab.21
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2014 09:53:29 -0700 (PDT)
In-Reply-To: <5359209F.7000308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hello.

On 04/24/2014 06:33 PM, Tomi Valkeinen wrote:

>>> omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.

>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> ---
>>>    arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
>>>    1 file changed, 7 insertions(+)

>>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts
>>> b/arch/arm/boot/dts/omap5-uevm.dts
>>> index 3b99ec25b748..9e7581eaeb23 100644
>>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>>> @@ -434,6 +434,13 @@
>>>        pinctrl-0 = <&i2c5_pins>;
>>>
>>>        clock-frequency = <400000>;
>>> +
>>> +    tca6424a: tca6424a@22 {

>>     The ePAPR standard [1] says: "The name of a node should be somewhat
>> generic,
>> reflecting the function of the device and not its precise programming
>> model.
>> If appropriate, the name should be one of the following choices:
>> [...]
>>     - gpio;"

> Right. I wonder what the name should be... "gpio" is out, as the name
> should be more specific.

    No, it's not out. The name should be "gpio@22", I think it would be unique.

> We already have gpio1-8, which are the gpio
> banks from the SoC.

    I don't understand why you are indexing the names while you probably have 
the address part after @ that makes them unique already.

>   Tomi

WBR, Sergei

