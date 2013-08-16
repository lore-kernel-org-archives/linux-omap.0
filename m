From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect latest
 ip revisions
Date: Fri, 16 Aug 2013 18:33:08 +0200
Message-ID: <520E5444.1000700@baylibre.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com> <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com> <520E341D.4080206@baylibre.com> <520E482A.1070504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47502 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab3HPQdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 12:33:12 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so977699wiw.11
        for <linux-omap@vger.kernel.org>; Fri, 16 Aug 2013 09:33:11 -0700 (PDT)
In-Reply-To: <520E482A.1070504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, mark.rutland@arm.com, a.zummo@towertech.it, davinci-linux-open-source@linux.davincidsp.com, khilman@linaro.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, sudhakar.raj@ti.com, rob@landley.net, grant.likely@linaro.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sekhar,

On 16/08/2013 17:41, Sekhar Nori wrote:
>=20
> On 8/16/2013 7:45 PM, Benoit Cousson wrote:
>> Hi Gururaja,
>>
>> On 16/08/2013 13:36, Hebbar, Gururaja wrote:
>>> The syntax of compatible property in DT is to mention the Most spec=
ific
>>> match to most generic match.
>>>
>>> Since AM335x is the platform with latest IP revision, add it 1st in
>>> the device id table.
>>
>> I don't understand why? The order should not matter at all.
>=20
> Yes, it should not. We are trying to work around a bug in the kernel
> where the compatible order is not honored (instead the order in
> of_match[] array matters). There were patches being discussed to fix =
this.
>=20
>>
>> I've tried to follow the thread you had with Mark on the v2, but AFA=
IK,
>> you've never answered to his latest question.
>>
>> Moreover, checking the differences between the Davinci and the am335=
2
>> RTC IP, I would not claim that both are compatible.
>>
>> Sure you can use the am3352 with the Davinci driver, but you will lo=
se
>> the wakeup functionality without even being notify about that.
>=20
> When the kernel is fixed for the bug pointed out above, this should n=
ot
> happen with properly defined compatible property.
>=20
>>
>> For my point of view, compatible mean that the HW will still be full=
y
>> functional with both versions of the driver, which is not the case h=
ere.
>=20
> I do not think that's the interpretation of compatible. Its goes from
> most specific to most generic per the ePAPR spec. That in itself says
> that 100% functionality is not expected if you don't find a match for
> the more specific property.

Well, to be honest I checked as well the official documentation, and th=
is is far from being clear:

page 21 of the ePAPR:

"
Property: compatible
Value type: <stringlist>

Description:
 The compatible property value consists of one or more strings that def=
ine the specific=20
 programming model for the device. This list of strings should be used =
by a client program for
 device driver selection. The property value consists of a concatenated=
 list of null terminated
 strings, from most specific to most general. They allow a device to ex=
press its compatibility
 with a family of similar devices, potentially allowing a single device=
 driver to match against
 several devices.
=20
 The recommended format is =E2=80=9Cmanufacturer,model=E2=80=9D, where =
manufacturer is a
 string describing the name of the manufacturer (such as a stock ticker=
 symbol), and model
 specifies the model number.

Example:
 compatible =3D =E2=80=9Cfsl,mpc8641-uart=E2=80=9D, =E2=80=9Cns16550";
 In this example, an operating system would first try to locate a devic=
e driver that supported
 fsl,mpc8641-uart. If a driver was not found, it would then try to loca=
te a driver that supported
 the more general ns16550 device type.
"

In this example, the generic vs specific is just about the driver. You =
could have one driver that manage 10 different UARTs or a specific one =
that manage only your HW.=20

There is no assumption about the lost of functionality by using the gen=
eric version of the driver. How the user is supposed to know the amount=
 of functionality he will lose, and if this is acceptable to him.
I'd rather have an error at boot saying that the driver is not compatib=
le with the HW and thus I will have to upgrade the kernel, than booting=
 a kernel that will not work as expected because some functionality are=
 missing for that specific HW.

Claiming that a piece of HW is compatible with an other one that is jus=
t a subset in term of functionality is wrong. You can claim that the ti=
,da830-rtc is compatible with the ti,am3352-rtc driver, but not the opp=
osite.

>> am3352 DTS must use the ti,am3352-rtc to have the expected behavior.
>=20
> Yes, that's what patch 2/2 does.
>=20
>> Using the ti,da830-rtc version will not make the board working as
>> expected. So we cannot claim the compatibility.
>=20
> Ideally, the DT file was *always* written as
>=20
> 	compatible =3D "ti,am3352-rtc", "ti,da830-rtc";
>=20
> even when there was no kernel support for AM3352 RTC.

You could do that only for the davinci DTS, because it is a subset of t=
he am3352 but you cannot do that for the am3352 as explained before.

> That way, there is no need to update the .dts[i] file. As kernel gain=
s
> functionality, more features (like rtc wake) is available to users.

Well, you cannot anticipate the HW evolution anyway and you did not kno=
w when Davinci DTS was done that an am3352 will exist in the future and=
 reuse the same IP.
Moreover DT is a ABI, so extending it according to the HW feature evolu=
tion is absolutely normal.

Every SoC that are using a RTC with the same programing model than the =
da830 can claim the compatibility. A SoC that is using a newer version =
of the IP with an extended programming model cannot claim that.

> Otherwise they get plain RTC functionality - but at least they get
> something instead of no RTC.

Because you assume that this feature is not important and thus you can =
use the plain RTC, but what if someone is buying that HW because of thi=
s new feature. Without that feature his system will just not work prope=
rly.
Saying that this is compatible whereas you lost functionality is lying =
to the customer for my point of view.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
