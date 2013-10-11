From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from smps10_out1
Date: Fri, 11 Oct 2013 02:27:02 -0500
Message-ID: <CAGo_u6q-5v05nou+WSw_scWgUDHYXMELtaMGXu7Vk2Wx4pNqog@mail.gmail.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
	<20131010141949.GA13277@kahuna>
	<52579723.6080209@ti.com>
	<CAGo_u6odWJ9UKwgaVu2YZzZKuYbveBoGDf99L=rJoK1-9KJ0SA@mail.gmail.com>
	<5257A05B.2070906@ti.com>
	<5257A0C0.8000701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5257A0C0.8000701-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 11, 2013 at 1:54 AM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>=
 wrote:
> On Friday 11 October 2013 12:23 PM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Friday 11 October 2013 12:00 PM, Nishanth Menon wrote:
>>> On Fri, Oct 11, 2013 at 1:13 AM, Kishon Vijay Abraham I <kishon@ti.=
com> wrote:
>>>>
>>>>> regulator-boot-on indicates that PMIC enables it by default as pa=
rt of
>>>>> OTP or some internal behavior -> Looking at the measurements done=
 on
>>>>> uEVM and OTP information -> regulator-boot-on should be kept here=
=2E
>>>>
>>>> No. Actually I don=92t want PMIC to enable it by default. I want t=
he palmas-usb
>>>> driver to handle it.
>>>> Enabling it by default makes palmas-usb to detect VBUS interrupt. =
This should
>>>> ideally be detected only when you connect a host cable.
>>>> Btw I didn't exactly get why you want regulator-boot-on should be =
kept here.
>>>
>>> binding description states:
>>> - regulator-boot-on: bootloader/firmware enabled regulator
>>> Further info: include/linux/regulator/machine.h
>>> * @boot_on: Set if the regulator is enabled when the system is init=
ially
>>> *           started.  If the regulator is not enabled by the hardwa=
re or
>>> *           bootloader then it will be enabled when the constraints=
 are
>>> *           applied.
>>>
>>> What that means is that it is enabled by firmware/bootloader (in ou=
r
>>> case One Time Program {OTP} inside Palmas) when the system switches=
 on
>>> even before the kernel starts. and we know SMPS10 is autoenabled by
>>> Palmas OTP configuration even before first instruction in A15
>>> executes.
>>
>> Not sure about that. Please note SMPS10 has two outputs OUT1 and OUT=
2 and I
>> tend to think that it might be OUT2 that's getting enabled by the OT=
P.
>>>
>>> I think you misunderstand this to mean that you'd like the regulato=
r
>>> to be *switched on* automatically at kernel boot by regulator
>>> framework - there is no reasoning why we'd want such a binding sinc=
e
>>> we'd expect drivers to do their job of requesting and enabling
>>> regulators on need..
>>
>> The comment you just quoted tells it enables the regulator if its no=
t enabled
>> by hardware. "If the regulator is not enabled by the hardware or boo=
tloader
>> then it will be enabled when the constraints are applied." At-least =
that's what
>> I understood from that comment.
>>
>> Also from our experiments it doesn't look like SMPS10_OUT1 is enable=
d by the
>> OTP and it gets enabled when we have *regulator-boot-on* constraints=
=2E
>
> btw.. I think this is the code in regulator fw that's responsible for=
 enabling..
>
>         /* If the constraints say the regulator should be on at this =
point
>          * and we have control then make sure it is enabled.
>          */
>         if ((rdev->constraints->always_on || rdev->constraints->boot_=
on) &&
>             ops->enable) {
>                 ret =3D ops->enable(rdev);
>                 if (ret < 0) {
>                         rdev_err(rdev, "failed to enable\n");
>                         goto out;
>                 }
>         }

Drat, you are right, I did not really dig deep. thanks for correcting
my understanding here.

I propose the following change in binding as it seems completely
misleading to me.

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt
b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2bd8f09..d999f096 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -8,7 +8,9 @@ Optional properties:
 - regulator-min-microamp: smallest current consumers may set
 - regulator-max-microamp: largest current consumers may set
 - regulator-always-on: boolean, regulator should never be disabled
-- regulator-boot-on: bootloader/firmware enabled regulator
+- regulator-boot-on: regulator is enabled when the system is initially=
 started.
+  If the regulator is not enabled by the hardware or bootloader then i=
t will be
+  enabled when the constraints are applied.
 - regulator-allow-bypass: allow the regulator to go into bypass mode
 - <name>-supply: phandle to the parent supply/regulator node
 - regulator-ramp-delay: ramp delay for regulator(in uV/uS)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
