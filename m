From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes
Date: Thu, 14 Mar 2013 17:56:45 +0100
Message-ID: <CAAwP0s3LXP4018M7nySiLsKj511PeZxZWfxJ3-_VpQDAAoMBOg@mail.gmail.com>
References: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk>
 <1363273762-17441-4-git-send-email-javier.martinez@collabora.co.uk>
 <5141F13E.8040300@ti.com> <CAAwP0s2iJscf9nV7Ac7ysebciL=d4z1KiUk29f7A1DaakVY=Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38991 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab3CNQ5G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 12:57:06 -0400
Received: by mail-ia0-f174.google.com with SMTP id k38so2241353iah.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Mar 2013 09:57:05 -0700 (PDT)
In-Reply-To: <CAAwP0s2iJscf9nV7Ac7ysebciL=d4z1KiUk29f7A1DaakVY=Ww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, Mar 14, 2013 at 5:37 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> On Thu, Mar 14, 2013 at 4:48 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> Hi Javier,
>>
>> On 03/14/2013 10:09 AM, Javier Martinez Canillas wrote:
>>> Besides being used to interface with external memory devices,
>>> the General-Purpose Memory Controller can be used to connect
>>> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
>>> processors using the TI GPMC as a data bus.
>>>
>>> This patch allows an ethernet chip to be defined as an GPMC
>>> child device node.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> ---
>>>  Documentation/devicetree/bindings/net/gpmc-eth.txt |   90 ++++++++++++++++++++
>>>  arch/arm/mach-omap2/gpmc.c                         |    8 ++
>>>  2 files changed, 98 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>>> new file mode 100644
>>> index 0000000..c45363c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
>>> @@ -0,0 +1,90 @@
>>> +Device tree bindings for Ethernet chip connected to TI GPMC
>>> +
>>> +Besides being used to interface with external memory devices, the
>>> +General-Purpose Memory Controller can be used to connect Pseudo-SRAM devices
>>> +such as ethernet controllers to processors using the TI GPMC as a data bus.
>>> +
>>> +Ethernet controllers connected to TI GPMC are represented as child nodes of
>>> +the GPMC controller with an "ethernet" name.
>>> +
>>> +All timing relevant properties as well as generic GPMC child properties are
>>> +explained in a separate documents. Please refer to
>>> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>> +
>>> +Required properties:
>>> +- bank-width:                Address width of the device in bytes. GPMC supports 8-bit
>>> +                     and 16-bit devices and so must be either 1 or 2 bytes.
>>
>> I am wondering if we should use reg-io-width here. The smsc driver is
>> using this to determine the width of the device. And so I am wondering
>> if this could cause problems.
>>
>> Obviously this complicates gpmc_probe_generic_child() a little, but may
>> be would could pass the name of the width property to
>> gpmc_probe_generic_child() as well. What do you think?
>>
>
> Hi Jon,
>
> Well now I'm confused. I thought that both were needed since a
> combination of bank-width 16-bit / reg-io-width 32-bit is also
> possible (in fact that is how I'm testing on my IGEPv2) and we have
> talked about this before [1].
>
> By reading both the OMAP3 TRM and the smsc LAN9221 data-sheet, it
> seems that the reg-io-width is not about the data bus address width
> but the CPU address width. The smsc data-sheet says:
>

Hi Jon,

By the way, here is the smsc LAN9221 data-sheet if you don't have it
and want to take it a look:

http://www.smsc.com/Downloads/SMSC/Downloads_Public/Data_Sheets/9221.pdf

Thanks a lot and best regards,
Javier
