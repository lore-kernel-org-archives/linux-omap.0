From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes
Date: Thu, 14 Mar 2013 21:28:15 +0100
Message-ID: <CAAwP0s1vy6ht+vydqWJqf2yKYv5F9k6o1pfpNxxj6Kn0aFJogw@mail.gmail.com>
References: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk>
 <1363273762-17441-4-git-send-email-javier.martinez@collabora.co.uk>
 <5141F13E.8040300@ti.com> <CAAwP0s2iJscf9nV7Ac7ysebciL=d4z1KiUk29f7A1DaakVY=Ww@mail.gmail.com>
 <51421BA7.4080509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:38872 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab3CNU2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 16:28:36 -0400
Received: by mail-vc0-f172.google.com with SMTP id hr11so737827vcb.3
        for <linux-omap@vger.kernel.org>; Thu, 14 Mar 2013 13:28:35 -0700 (PDT)
In-Reply-To: <51421BA7.4080509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, Mar 14, 2013 at 7:49 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 03/14/2013 11:37 AM, Javier Martinez Canillas wrote:
>> On Thu, Mar 14, 2013 at 4:48 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>> Hi Javier,
>>>
>>> On 03/14/2013 10:09 AM, Javier Martinez Canillas wrote:
>>>> Besides being used to interface with external memory devices,
>>>> the General-Purpose Memory Controller can be used to connect
>>>> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
>>>> processors using the TI GPMC as a data bus.
>>>>
>>>> This patch allows an ethernet chip to be defined as an GPMC
>>>> child device node.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>> ---
>>>>  Documentation/devicetree/bindings/net/gpmc-eth.txt |   90 ++++++++++++++++++++
>>>>  arch/arm/mach-omap2/gpmc.c                         |    8 ++
>>>>  2 files changed, 98 insertions(+), 0 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>> new file mode 100644
>>>> index 0000000..c45363c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>> @@ -0,0 +1,90 @@
>>>> +Device tree bindings for Ethernet chip connected to TI GPMC
>>>> +
>>>> +Besides being used to interface with external memory devices, the
>>>> +General-Purpose Memory Controller can be used to connect Pseudo-SRAM devices
>>>> +such as ethernet controllers to processors using the TI GPMC as a data bus.
>>>> +
>>>> +Ethernet controllers connected to TI GPMC are represented as child nodes of
>>>> +the GPMC controller with an "ethernet" name.
>>>> +
>>>> +All timing relevant properties as well as generic GPMC child properties are
>>>> +explained in a separate documents. Please refer to
>>>> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>>> +
>>>> +Required properties:
>>>> +- bank-width:                Address width of the device in bytes. GPMC supports 8-bit
>>>> +                     and 16-bit devices and so must be either 1 or 2 bytes.
>>>
>>> I am wondering if we should use reg-io-width here. The smsc driver is
>>> using this to determine the width of the device. And so I am wondering
>>> if this could cause problems.
>>>
>>> Obviously this complicates gpmc_probe_generic_child() a little, but may
>>> be would could pass the name of the width property to
>>> gpmc_probe_generic_child() as well. What do you think?
>>>
>>
>> Hi Jon,
>>
>> Well now I'm confused. I thought that both were needed since a
>> combination of bank-width 16-bit / reg-io-width 32-bit is also
>> possible (in fact that is how I'm testing on my IGEPv2) and we have
>> talked about this before [1].
>
> Yes you are right. Sorry about that ...
>
>> By reading both the OMAP3 TRM and the smsc LAN9221 data-sheet, it
>> seems that the reg-io-width is not about the data bus address width
>> but the CPU address width. The smsc data-sheet says:
>>
>> "The simple, yet highly functional host bus interface provides a
>> glue-less connection to most common 16-bit microprocessors and
>> microcontrollers as well as 32-bit microprocessors with a 16-bit
>> external bus"
>>
>> By looking at the smsc911x driver
>> (drivers/net/ethernet/smsc/smsc911x.c) I see that if you use
>> reg-io-width = <4> (SMSC911X_USE_32BIT) then the smsc911x hardware
>> registers can be read in one operation and if you use reg-io-width =
>> <2> (SMSC911X_USE_16BIT) then you need two operations to read the
>> register:
>>
>> static inline u32 __smsc911x_reg_read(struct smsc911x_data *pdata, u32 reg)
>> {
>>       if (pdata->config.flags & SMSC911X_USE_32BIT)
>>               return readl(pdata->ioaddr + reg);
>>
>>       if (pdata->config.flags & SMSC911X_USE_16BIT)
>>               return ((readw(pdata->ioaddr + reg) & 0xFFFF) |
>>                       ((readw(pdata->ioaddr + reg + 2) & 0xFFFF) << 16));
>>
>>       BUG();
>>       return 0;
>> }
>
> Looking at the above, then I don't see any issue with this then.
>
>> Also, by reading at the OMAP3 TRM, I understand that even when the
>> GPMC has a maximum 16-bit address width, it support devices that has
>> 32-bit registers by doing some sort of access adaptation.
>
> Yes I believe that is correct.
>
>> So, as far as I understand the "bank-width" is to configure the GPMC
>> if is going to use a 8-bit or 16-bit width access and the
>> "reg-io-width" is how the smsc911x driver is going to read its
>> registers. So, I think we need both properties and there is no need to
>> change gpmc_probe_generic_child() neither pass the child name to it.
>>
>> But to be honest I can be wrong here since data-sheet and technical
>> reference manuals can be quite confusing sometimes :-)
>
> Ok, so do you think that we should add some documentation to the
> gpmc-eth.txt so say that set "reg-io-width = <4>;" for OMAP regardless
> of bank-width?

Yes, I think we can improve the documentation. I'll send a v2 with
this delta patch squashed:

diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt
b/Documentation/devicetree/bindings/net/gpmc-eth.txt
index c45363c..711d28d 100644
--- a/Documentation/devicetree/bindings/net/gpmc-eth.txt
+++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
@@ -11,6 +11,17 @@ All timing relevant properties as well as generic
GPMC child properties are
 explained in a separate documents. Please refer to
 Documentation/devicetree/bindings/bus/ti-gpmc.txt

+For the properties relevant to the ethernet controller connected to the GPMC
+refer to the binding documentation of the device. For example, the
documentation
+for the SMSC 911x is Documentation/devicetree/bindings/net/smsc911x.txt
+
+Child nodes need to specify the GPMC bus address width using the "bank-width"
+property but is possible that an ethernet controller also has a property to
+specify the I/O registers address width. Even when the GPMC has a
maximum 16-bit
+address width, it supports devices with 32-bit word registers.
+For example with an SMSC LAN911x/912x controller connected to the TI GPMC on an
+OMAP2+ board, "bank-width = <2>;" and "reg-io-width = <4>;".
+
 Required properties:
 - bank-width:          Address width of the device in bytes. GPMC
supports 8-bit
                        and 16-bit devices and so must be either 1 or 2 bytes.

>
> Cheers
> Jon

Best regards,
Javier
