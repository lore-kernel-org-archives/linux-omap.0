From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: omap_device: handle first time activation of
 console device
Date: Wed, 16 Nov 2011 19:18:49 +0100
Message-ID: <4EC3FE89.5050303@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com> <1321441346-19591-2-git-send-email-rnayak@ti.com> <4EC3CDC4.7000108@gmail.com> <4EC3D360.8000800@ti.com> <4EC3D9BD.2080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55621 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab1KPSTD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 13:19:03 -0500
In-Reply-To: <4EC3D9BD.2080107@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rajendra Nayak <rnayak@ti.com>, khilman@ti.com, linaro-dev@lists.linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, govindraj.raja@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/16/2011 4:41 PM, Rob Herring wrote:
> Benoit,
>
> On 11/16/2011 09:14 AM, Cousson, Benoit wrote:
>> Hi Rob,
>>
>> On 11/16/2011 3:50 PM, Rob Herring wrote:
>>> On 11/16/2011 05:02 AM, Rajendra Nayak wrote:
>>>> console device on OMAP is never reset or idled by hwmod post
>>>> initial setup, early during boot, for obvious reasons not to
>>>> break early debug prints thrown on console.
>>>> This leaves the console device enabled at boot and the first activation
>>>> of it using hwmod needs to be handled in such a way that a disable is
>>>> called followed by an enable of the hwmod, the subsequent activations
>>>> can then use the default activation technique.
>>>>
>>>> To handle this add a new binding to identify a hwmod which is used as
>>>> the console device.
>>>>
>>>> This patch is based on the what is done in serial.c for non-DT builds.
>>>>
>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/arm/omap/omap.txt          |    1 +
>>>>    arch/arm/plat-omap/omap_device.c                   |   33
>>>> +++++++++++++++++++-
>>>>    2 files changed, 33 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> index dbdab40..46ffd41 100644
>>>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> @@ -21,6 +21,7 @@ Required properties:
>>>>    Optional properties:
>>>>    - ti,no_idle_on_suspend: When present, it prevents the PM to idle
>>>> the module
>>>>      during suspend.
>>>> +- ti,console_hwmod: boolean, identifies the hwmod used as console
>>>> device
>>>>
>>>
>>> This doesn't seem right. Which console is not a h/w property. Why can't
>>> you use aliases like other platforms are doing?
>>>
>>> Also, it's not clear in the documentation where this (and
>>> ti,no_idle_on_suspend) should go in the DT. Both seem like they should
>>> be kernel cmdline params.
>>
>> That raise the question about using DT to pass linux specific parameter.
>> We already discuss that on the mailing list, but never get a clear answer.
>> It seems that DT is already used to provide some OS specific information
>> using the "linux," prefix for example.
>
> True, but "linux," properties will always face resistance and scrutiny.

OK, that's good to know. So we should avoid abusing that kind of prefix.

>> There are clearly a couple of parameters that can be provided by the
>> bootloader, but that does not reflect a HW property.
>>
>> So what is the guideline for that, should we stick to cmdline params for
>> that?
>>
>
> I would say that if the setting does not depend on something in the DT,
> then the cmdline is the right place. If you have a property that
> references a phandle, then it can't be on the cmdline. For console
> selection, there is already a defined way to select it with
> console=blah. And there is an agreed way to define indexes in the DT
> with aliases.

OK, I saw that in some DT adapted serial driver, we can retrieve the 
index from the string "serial<x>" and thus can get the console from the 
ttyS number.

> How were these properties set without DT?

 From the board file most of the time. Or using some dirty hacks here 
and there :-)

>> Quoting Grant's documentation, runtime configuration is supported:
>>
>> "Runtime configuration
>>
>> In most cases, a DT will be the sole method of communicating data from
>> firmware to the kernel, so also gets used to pass in runtime and
>> configuration data like the kernel parameters string and the location of
>> an initrd image.
>>
>> Most of this data is contained in the /chosen node, and when booting
>> Linux it will look something like this:
>>
>>      chosen {
>>          bootargs = "console=ttyS0,115200 loglevel=8";
>>          initrd-start =<0xc8000000>;
>>          initrd-end =<0xc8200000>;
>>      };
>>
>> The bootargs property contains the kernel arguments, and the initrd-*
>> properties define the address and size of an initrd blob. The chosen
>> node may also optionally contain an arbitrary number of additional
>> properties for platform-specific configuration data."
>>
>>
>> Does that mean that this is supported only if the bootloader does not
>> support cmdline?
>
> No. I think it means chosen can be extended. However, how many other
> chosen properties are defined? Not very many. Clearly, it's not a place
> for adding whatever random property you want. chosen is really the boot
> interface between the bootloader and kernel as it is ATAG type data.

OK, thanks for the clarification.

Regards,
Benoit
