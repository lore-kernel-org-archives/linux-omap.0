From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 21:49:05 +0800
Message-ID: <50AE2D51.5060001@linaro.org>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org> <50ACFC5D.1090406@ti.com> <20121121195436.GF14290@arwen.pp.htv.fi> <50AD7C2C.7000608@linaro.org> <20121122121845.GB18022@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121122121845.GB18022-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/22/12 20:21, the mail apparently from Felipe Balbi included:
> Hi,
>
> On Thu, Nov 22, 2012 at 09:13:16AM +0800, Andy Green wrote:
>> On 11/22/12 03:54, the mail apparently from Felipe Balbi included:
>>> Hi,
>>>
>>> On Wed, Nov 21, 2012 at 06:07:57PM +0200, Roger Quadros wrote:
>>>> On 11/21/2012 05:32 PM, Alan Stern wrote:
>>>>> On Wed, 21 Nov 2012, Roger Quadros wrote:
>>>>>
>>>>>> On 11/21/2012 04:52 PM, Alan Stern wrote:
>>>>>>> On Wed, 21 Nov 2012, Felipe Balbi wrote:
>>>>>>>
>>>>>>>> On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
>>>>>>>>> From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>>>>>
>>>>>>>>> This patch changes the management of the two GPIO for
>>>>>>>>> "hub reset" (actually controls enable of ULPI PHY and hub res=
et) and
>>>>>>>>> "hub power" (controls power to hub + eth).
>>>>>>>>
>>>>>>>> looks like this should be done by the hub driver. Alan, what w=
ould you
>>>>>>>> say ? Should the hub driver know how to power itself up ?
>>>>>>>
>>>>>>> Not knowing the context, I'm a little confused.  What is this h=
ub
>>>>>>> you're talking about?  Is it a separate USB hub incorporated in=
to the
>>>>>>> IP (like Intel's "rate-matching" hubs in their later chipsets)?=
  Or is
>>>>>>> it the root hub?
>>>>>>>
>>>>>>
>>>>>> This is actually a USB HUB + Ethernet combo chip (LAN9514) that =
is hard
>>>>>> wired on the panda board with its Power and Reset pins controlle=
d by 2
>>>>>> GPIOs from the OMAP SoC.
>>>>>>
>>>>>> When powered, this chip can consume significant power (~0.7 W) b=
ecause
>>>>>> of the (integrated Ethernet even when suspended. I suppose the e=
thernet
>>>>>> driver SMSC95XX) doesn't put it into a low enough power state on=
 suspend.
>>>>>>
>>>>>> It doesn't make sense to power the chip when USB is not required=
 on the
>>>>>> whole (e.g. ehci_hcd module is not loaded). This is what this pa=
tch is
>>>>>> trying to fix.
>>>>>
>>>>> Ah, okay.  Then yes, assuming you want to power this chip only wh=
en
>>>>> either ehci-hcd or the ethernet driver is loaded, the right place=
s
>>>>> to manage the power GPIO are in the init and exit routines of the=
 two
>>>>> drivers.
>>>>>
>>>>
>>>> The Ethernet function actually connects over USB within the chip. =
So
>>>> managing the power only in the ehci-hcd driver should suffice.
>>>
>>> the thing is that this could cause code duplication all over. LAN95=
xx is
>>
>> I can see this point.  However DT will soak up these regulator
>> definitions, at that point it's "for free".  On Linaro tilt-3.4 we
>> already have this on the dts
>>
>> 	hubpower: fixedregulator@0 {
>> 			compatible =3D "regulator-fixed";
>> 			regulator-name =3D "vhub0";
>> 			regulator-min-microvolt =3D <3300000>;
>> 			regulator-max-microvolt =3D <3300000>;
>> 			gpio =3D <&gpio1 1 0>;		/* gpio 1 : HUB Power */
>> 			startup-delay-us =3D <70000>;
>> 			enable-active-high;
>> 	};
>>
>> 	hubreset: fixedregulator@1 {
>> 			compatible =3D "regulator-fixed";
>> 			regulator-name =3D "hsusb0";	/* tag to associate with PORT 1 */
>> 			regulator-min-microvolt =3D <3300000>;
>> 			regulator-max-microvolt =3D <3300000>;
>> 			gpio =3D <&gpio2 30 0>;	/* gpio 62 : HUB & PHY Reset */
>> 			startup-delay-us =3D <70000>;
>> 			enable-active-high;
>> 			vin-supply =3D "vhub0"; /* Makes regulator f/w enable power befor=
e reset */
>> 	};
>>
>> which is the equivalent to my patch: I don't think we need to sweat
>> about code duplication.
>
> why not ? Just because you have some ready DT files outside of the
> mailine kernel ? Sorry, not a good argument.

That's not my argument: it's the whole basis for bothering with DT, but=
=20
never mind.

>>> a generic USB Hub + Ethernet combo on one of ports from SMSC. *Any*
>>> platform could use it and could hook those power and reset pins to =
a
>>> GPIO. If we handle this at ehci-omap level, we risk having to dupli=
cate
>>> the same piece of code for ehci-*.c
>>
>> We need to consider power and reset separately.  Reset is a safe bet
>> as a GPIO but power to the smsc chip is not.
>
> so ? I'm saying that it *can* be attached to other architectures and
> they *can* decide to put both on GPIOs. I'm not considering the
> likelyhood of the situation.

There's some confusion here --->

>> On panda they happen to fit a gpio-controlled linear regulator to
>> provide the smsc 3.3V supply.  On another device that can just as
>
> good to know, then we need a regulator driver (as you added on your D=
T
> file the bindings for it) instead of poking into the GPIO directly.

Assuming you mean "regulator device", if you look at the patch, that is=
=20
what it does.

The original board file code just sets the GPIO as a one-off and forget=
s=20
about it, so the whole show is permanently powered, which is=20
objectionable since ~50% of Panda idle power is burned on that.

My patch uses regulator definitions in the board file - I only touch th=
e=20
board file - to allow the omap ehci driver to control the power.

> Again it sounds like something that should be done at the hub driver
> level. I mean using the GPIO (for reset) and Power Regulator.
>
> not implementing the regulator part itself, but using it.

If you mean change the regulator managing code from living in omap-hsus=
b=20
to ehci-hcd, it sounds like a good idea.

>> easily be a PMIC regulator channel: it boils down to controlling a
>> power rail.  So using struct regulator as the abstraction for the
>> power is the right way already.
>
> I agree with you here. Nevertheless, I'm arguing that this all should=
 be
> handled by the hub driver, not ehci-omap.

If "hub driver" means ehci-hcd then I agree, why not let all the ehci=20
platforms have the same regulator management option instead of just OMA=
P.

>>> Since that's a hub driver anyway, I wonder if it would be better to=
 play
>>> with those gpios somewhere else ?!?
>>
>> The patch creates a regulator that binds to a magic regulator name
>> defined by the hsusb driver, "hsusb0".
>>
>> That regulator is taken up and down by hsusb driver with the
>> lifecycle of the logical hsusb device.  So inserting ehci-hcd module
>> powers the regulator until the module is removed.
>
> but this is wrong. What if we use a different HUB part, what if the s=
ame
> HUB part is used in e.g. Tegra-based platform ?
>
> This is why I say it's *wrong* to handle that at the OMAP USB Host pa=
rt.
> This is why I'm arguing that this whole thing should be handled by th=
e
> hub driver itself.

Yes if we mean ehci-hcd manages the regulator, it will be better.  AFAI=
K=20
it doesn't right now and the omap bit does, so my patch used what exist=
s=20
and works.

>> Originally I bound the regulator to the smsc95xx driver, which also
>
> that's wrong too. You can't assume that the network part of the devic=
e
> knows when the USB part needs to be powered up. That's just plain wro=
ng.

 From the POV of the original goal of the patch, it was just to give us=
=20
a way to control static power consumption by modprobe.  It would work=20
fine to do that by modprobe [-r] smsc95xx same as ehci-hcd actually,=20
although I agree it's backward from usual discover -> udev -> modprobe=20
POV.  Anyway that is not what we ended up with so no need to worry abou=
t it.

>> offers a struct regulator.  But there is a quirk on Panda that means
>> that is not workable.
>>
>> On Panda, they share one SoC gpio to reset both an external ULPI PHY
>> chip and the smsc95xx that is downstream of it.
>
> of course. the Network part is attached to one of the Hub ports, that=
's
> why the hub exposes only two ports.

I am not sure how that makes it an "of course".  It's not like there's =
a=20
shortage of SoC gpio to separate them and allow cleaner software.  But=20
never mind that either.

>> After you power up the smsc95xx, you must reset it in order for
>> correct operation.  This actually resets the ULPI PHY too.
>>
>> The ULPI PHY is permanently powered, only nRESET is provided to
>> control it.
>>
>> For that reason, as an attribute of being on a Panda board, we need
>> to do the (shared) reset meddling once at hsusb init, and that is wh=
y
>> the patch is as it is.
>
> yeah, yeah, but it's not correct to push all that code is the OMAP US=
B
> Part when the hub driver is the only one who knows when the hub is go=
ing
> to be reset and the like.
>
> You're poking into a HUB, not into the EHCI controller.

My patch is just using what's there at the moment.  It only touches the=
=20
board file and does not "push all that code is the OMAP USB part".

I agree with you what's in the OMAP USB part is better in the generic=20
part, but I didn't put it there.

If you want that moved and nobody else wants to do it, I can probably d=
o=20
that in a new, additional patch.  If so you might want to confirm you'r=
e=20
OK with the magic naming convention for regulators or (as Roger=20
suggested earlier) pass it in by platform_data.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
