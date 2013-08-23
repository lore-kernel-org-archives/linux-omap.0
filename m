From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect latest
 ip revisions
Date: Fri, 23 Aug 2013 17:10:36 +0200
Message-ID: <52177B6C.2080406@baylibre.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com> <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com> <520E341D.4080206@baylibre.com> <520E482A.1070504@ti.com> <520E5444.1000700@baylibre.com> <52172264.3070000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43799 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab3HWPKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Aug 2013 11:10:41 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so640432wgg.28
        for <linux-omap@vger.kernel.org>; Fri, 23 Aug 2013 08:10:40 -0700 (PDT)
In-Reply-To: <52172264.3070000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, mark.rutland@arm.com, a.zummo@towertech.it, davinci-linux-open-source@linux.davincidsp.com, khilman@linaro.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, sudhakar.raj@ti.com, rob@landley.net, grant.likely@linaro.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sekhar,

On 23/08/2013 10:50, Sekhar Nori wrote:
> Hi Benoit,
>
> Did you get a chance to think about this, I have provided some
> replies below.
>
> On Friday 16 August 2013 10:03 PM, Benoit Cousson wrote:
>> Hi Sekhar,
>>
>> On 16/08/2013 17:41, Sekhar Nori wrote:
>>>
>>> On 8/16/2013 7:45 PM, Benoit Cousson wrote:
>>>> Hi Gururaja,
>>>>
>>>> On 16/08/2013 13:36, Hebbar, Gururaja wrote:
>>>>> The syntax of compatible property in DT is to mention the
>>>>> Most specific match to most generic match.
>>>>>
>>>>> Since AM335x is the platform with latest IP revision, add it
>>>>> 1st in the device id table.
>>>>
>>>> I don't understand why? The order should not matter at all.
>>>
>>> Yes, it should not. We are trying to work around a bug in the
>>> kernel where the compatible order is not honored (instead the
>>> order in of_match[] array matters). There were patches being
>>> discussed to fix this.
>>>
>>>>
>>>> I've tried to follow the thread you had with Mark on the v2,
>>>> but AFAIK, you've never answered to his latest question.
>>>>
>>>> Moreover, checking the differences between the Davinci and the
>>>> am3352 RTC IP, I would not claim that both are compatible.
>>>>
>>>> Sure you can use the am3352 with the Davinci driver, but you
>>>> will lose the wakeup functionality without even being notify
>>>> about that.
>>>
>>> When the kernel is fixed for the bug pointed out above, this
>>> should not happen with properly defined compatible property.
>>>
>>>>
>>>> For my point of view, compatible mean that the HW will still be
>>>> fully functional with both versions of the driver, which is not
>>>> the case here.
>>>
>>> I do not think that's the interpretation of compatible. Its goes
>>> from most specific to most generic per the ePAPR spec. That in
>>> itself says that 100% functionality is not expected if you don't
>>> find a match for the more specific property.
>>
>> Well, to be honest I checked as well the official documentation,
>> and this is far from being clear:
>>
>> page 21 of the ePAPR:
>>
>> " Property: compatible Value type: <stringlist>
>>
>> Description: The compatible property value consists of one or more
>> strings that define the specific programming model for the device.
>> This list of strings should be used by a client program for device
>> driver selection. The property value consists of a concatenated
>> list of null terminated strings, from most specific to most
>> general. They allow a device to express its compatibility with a
>> family of similar devices, potentially allowing a single device
>> driver to match against several devices.
>>
>> The recommended format is =E2=80=9Cmanufacturer,model=E2=80=9D, wher=
e manufacturer
>> is a string describing the name of the manufacturer (such as a
>> stock ticker symbol), and model specifies the model number.
>>
>> Example: compatible =3D =E2=80=9Cfsl,mpc8641-uart=E2=80=9D, =E2=80=9C=
ns16550"; In this
>> example, an operating system would first try to locate a device
>> driver that supported fsl,mpc8641-uart. If a driver was not found,
>> it would then try to locate a driver that supported the more
>> general ns16550 device type. "
>>
>> In this example, the generic vs specific is just about the driver.
>> You could have one driver that manage 10 different UARTs or a
>> specific one that manage only your HW.
>
> Right, the assumption is that a specific driver is written because
> there are parts of the hardware that cannot be serviced by generic
> driver. So ultimately its all driven by changes in hardware.

Yeah, that example remind me the omap-serial driver we had done to=20
handle the DMA mode that was not supported by the generic one.

>> There is no assumption about the lost of functionality by using the
>> generic version of the driver. How the user is supposed to know the
>> amount of functionality he will lose, and if this is acceptable to
>> him.
>
> I suppose the generic driver would return some error code like
> -ENOTSUP for the functionality it cannot provide.

Well, I guess it depends of the added functionality add how far the IP=20
version is forward compatible with the old driver. If the new IP versio=
n=20
is just improving the performance by adding a DMA mode instead of the=20
PIO, then the driver API can remain the same.
But if you add a new functionality that will require an extended API,=20
there is no way you can report such error. Except if the API itself is=20
done with a good forward compatibility support.

And if the new functionality is mandatory to make the new system=20
operational, returning an error might just make the system not working=20
at all.

>> I'd rather have an error at boot saying that the driver is not
>> compatible with the HW and thus I will have to upgrade the kernel,
>> than booting a kernel that will not work as expected because some
>> functionality are missing for that specific HW.
>
> If you have an update available, you can always upgrade to it. But
> what if there is no update available? Would you rather not have the
> user use the available functionality in the meanwhile while he waits
> for the kernel support to be developed.

It depends... In the UART example, that's just a matter of performance=20
improvement, so keeping the old version is fine.
As soon as the driver is usable, and the new feature is not mandatory t=
o=20
ensure the system will work properly, I guess it is fine.

>> Claiming that a piece of HW is compatible with an other one that is
>> just a subset in term of functionality is wrong. You can claim that
>> the ti,da830-rtc is compatible with the ti,am3352-rtc driver, but
>> not the opposite.
>
> If this is wrong, then what is the use of compatible property?

That's a good question :-) And that's why I was always confused with=20
that property.

> Why
> would someone write a driver supporting =E2=80=9Cfsl,mpc8641-uart=E2=80=
=9D if 100% of
> its hardware features are also supported by =E2=80=9Cns16550" driver?

That's still doable, if you want to reduce the size of a big generic=20
driver into a smaller specific driver. The point is that the compatible=
=20
value does not have any assumption about the driver that will handle it=
=2E

The other issue is that we are supposed to always use the latest SoC=20
version even if the IP is 100% the same. Like

omap5-timer {
	compatible =3D "omap5-timer", "omap4-timer";
}

So how are you suppose to differentiate the same IP, and a compatible I=
P???

That's what I don't like in that compatible string definition. You do=20
not necessarily know the amount of compatibility you are talking about.

>>>> am3352 DTS must use the ti,am3352-rtc to have the expected
>>>> behavior.
>>>
>>> Yes, that's what patch 2/2 does.
>>>
>>>> Using the ti,da830-rtc version will not make the board working
>>>> as expected. So we cannot claim the compatibility.
>>>
>>> Ideally, the DT file was *always* written as
>>>
>>> compatible =3D "ti,am3352-rtc", "ti,da830-rtc";
>>>
>>> even when there was no kernel support for AM3352 RTC.
>>
>> You could do that only for the davinci DTS, because it is a subset
>> of the am3352 but you cannot do that for the am3352 as explained
>> before.
>
> DaVinci DTS will use compatible =3D "ti,da830-rtc"; Thats not changin=
g
> with this patchset.
>
>>
>>> That way, there is no need to update the .dts[i] file. As kernel
>>> gains functionality, more features (like rtc wake) is available
>>> to users.
>>
>> Well, you cannot anticipate the HW evolution anyway and you did not
>> know when Davinci DTS was done that an am3352 will exist in the
>> future and reuse the same IP.
>
> Yeah, I am not claiming DaVinci DTS should be updated. But when
> am335x.dtsi was written, there was knowledge that a (potentially)
> new version of RTC IP is available and therefore the .dtsi should
> have been written as
>
> compatible =3D "ti,am3352-rtc", "ti,da830-rtc";
>
> instead of
>
> compatible =3D "ti,da830-rtc";
>
> that it is today. Thing is, you can never know if the IP needs any
> additional handling even after reading the spec. We keep discovering
> new features/quirks. So, when writing <new-soc>.dtsi its safer to
> always use
>
> compatible =3D "ti,<new-soc>-rtc", "ti,<compatible-soc>-rtc";
>
> even though _today_ you may not have code that specifically handles
> "ti,<new-soc>-rtc".

Well, we can do that, but honestly, I do not see the need. You can=20
always update the dts later. Why would we add hundreds more compatible=20
strings just in case few devices will need special handling. That's=20
overkill.
If was maybe easy and harmless in the good old PPC time when the DTS=20
files were relatively small, but the ARM DTS files are much bigger.

In the name of the Keep It Simple Principle, I would just avoid adding=20
something just because it might be useful in 5 % of the cases.

>> Moreover DT is a ABI, so extending it according to the HW feature
>> evolution is absolutely normal.
>
> You mean the DT bindings and not specifically the .dts[i], right?

Yes, you're right, sorry for the confusing sentence.

> Then I agree. Ideally the .dts[i] is written once per hardware. I
> know its almost impossible to get that right.
>
>>
>> Every SoC that are using a RTC with the same programing model than
>> the da830 can claim the compatibility. A SoC that is using a newer
>> version of the IP with an extended programming model cannot claim
>> that.
>
> We differ here. As long as programming model is _extended_, new IP
> is still compatible with old. If the programming model is _changed_
> then its not.

Yes, I was assuming compatible as a 100% match which is not really=20
compatible but identical in that case. But the current syntax, does not=
=20
allow you anyway to differentiate a new SoC with the exact same IP=20
version to a different for compatible IP.

>>> Otherwise they get plain RTC functionality - but at least they
>>> get something instead of no RTC.
>>
>> Because you assume that this feature is not important and thus you
>> can use the plain RTC, but what if someone is buying that HW
>> because of this new feature. Without that feature his system will
>> just not work properly.
>
> Right, but thats not a problem DT can solve. He/she needs to hassle
> TI for updated drivers. But there could be 10 other customers who are
> just okay with plain RTC. So till the time driver is updated to use
> ti,am3352-rtc", are you saying no one should be able to use the RTC
> on the SoC at all even though 90% features are available?

Again, if it will not prevent the system to work properly, then it is=20
fine. But let's assume that without the wakeup RTC functionality, you=20
just cannot wakeup from suspend an am3352 board. Then you end up with a=
=20
non functional system for the PM point of view.

Someone who is not aware that the compatible RTC is not supporting that=
=20
feature might spend some time figuring out why he cannot wakeup from=20
suspend on a RTC alarm.

In general, I'd rather have nothing than something that is working at 5=
0%.
But maybe that's just me :-)

>> Saying that this is compatible whereas you lost functionality is
>> lying to the customer for my point of view.
>
> If 100% functionality is required for compatibility then I am afraid
> there is nothing like "compatibility". There are just different
> isolated versions.

I guess you are right.

Bottom-line, I'm really disappointed but that lack of accuracy in the=20
compatible string, but I guess, it was done for what you guys are doing=
=2E
And maybe, it is something that should just be well documented in the=20
bindings to avoid confusing the users.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
