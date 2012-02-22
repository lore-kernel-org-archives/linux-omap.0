From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 22 Feb 2012 11:23:16 -0600
Message-ID: <4F452484.5080503@gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48027 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab2BVRXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 12:23:20 -0500
Received: by yhoo21 with SMTP id o21so172409yho.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 09:23:19 -0800 (PST)
In-Reply-To: <4F44FC37.2000701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org

On 02/22/2012 08:31 AM, Cousson, Benoit wrote:
> On 2/22/2012 3:23 PM, Rob Herring wrote:
>> On 02/15/2012 10:04 AM, Benoit Cousson wrote:
>>> Adapt the GPIO driver to retrieve information from a DT file.
>>>
>>> Allocate the irq_base dynamically and rename bank->virtual_irq_start
>>> to bank->irq_base.
>>> Change irq_base type to int instead of u16 to match irq_alloc_descs
>>> output.
>>>
>>> Add documentation for GPIO properties specific to OMAP.
>>>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>>
>> One comment below, but otherwise:
>>
>> Acked-by: Rob Herring<rob.herring@calxeda.com>
>>
>>> ---
>>>   .../devicetree/bindings/gpio/gpio-omap.txt         |   30 +++++
>>>   drivers/gpio/gpio-omap.c                           |  121
>>> ++++++++++++++++++--
>>>   2 files changed, 142 insertions(+), 9 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> new file mode 100644
>>> index 0000000..c1b3100
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>> @@ -0,0 +1,30 @@
>>> +OMAP GPIO controller bindings
>>> +
>>> +Required properties:
>>> +- compatible:
>>> +  - "ti,omap2-gpio" for OMAP2 controllers
>>> +  - "ti,omap3-gpio" for OMAP3 controllers
>>> +  - "ti,omap4-gpio" for OMAP4 controllers
>>> +- #gpio-cells : Should be two.
>>> +  - first cell is the pin number
>>> +  - second cell is used to specify optional parameters (unused)
>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>> +- #interrupt-cells : Should be one
>>
>> There's no level/edge settings for gpios?
> 
> That's a good question, because I was wondering as well :-)
> 
> I did no see how it was done in other GPIO implementation.

There's not really a good example that I've found. Many gpio nodes don't
even have "interrupt-controller" set.

So if you have an irq_set_type function for gpio's, then you should have
2 cells.

Rob

