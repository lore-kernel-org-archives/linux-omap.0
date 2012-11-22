From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 09:13:16 +0800
Message-ID: <50AD7C2C.7000608@linaro.org>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org> <50ACFC5D.1090406@ti.com> <20121121195436.GF14290@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121195436.GF14290-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/22/12 03:54, the mail apparently from Felipe Balbi included:
> Hi,
>
> On Wed, Nov 21, 2012 at 06:07:57PM +0200, Roger Quadros wrote:
>> On 11/21/2012 05:32 PM, Alan Stern wrote:
>>> On Wed, 21 Nov 2012, Roger Quadros wrote:
>>>
>>>> On 11/21/2012 04:52 PM, Alan Stern wrote:
>>>>> On Wed, 21 Nov 2012, Felipe Balbi wrote:
>>>>>
>>>>>> On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
>>>>>>> From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>>>
>>>>>>> This patch changes the management of the two GPIO for
>>>>>>> "hub reset" (actually controls enable of ULPI PHY and hub reset=
) and
>>>>>>> "hub power" (controls power to hub + eth).
>>>>>>
>>>>>> looks like this should be done by the hub driver. Alan, what wou=
ld you
>>>>>> say ? Should the hub driver know how to power itself up ?
>>>>>
>>>>> Not knowing the context, I'm a little confused.  What is this hub
>>>>> you're talking about?  Is it a separate USB hub incorporated into=
 the
>>>>> IP (like Intel's "rate-matching" hubs in their later chipsets)?  =
Or is
>>>>> it the root hub?
>>>>>
>>>>
>>>> This is actually a USB HUB + Ethernet combo chip (LAN9514) that is=
 hard
>>>> wired on the panda board with its Power and Reset pins controlled =
by 2
>>>> GPIOs from the OMAP SoC.
>>>>
>>>> When powered, this chip can consume significant power (~0.7 W) bec=
ause
>>>> of the (integrated Ethernet even when suspended. I suppose the eth=
ernet
>>>> driver SMSC95XX) doesn't put it into a low enough power state on s=
uspend.
>>>>
>>>> It doesn't make sense to power the chip when USB is not required o=
n the
>>>> whole (e.g. ehci_hcd module is not loaded). This is what this patc=
h is
>>>> trying to fix.
>>>
>>> Ah, okay.  Then yes, assuming you want to power this chip only when
>>> either ehci-hcd or the ethernet driver is loaded, the right places
>>> to manage the power GPIO are in the init and exit routines of the t=
wo
>>> drivers.
>>>
>>
>> The Ethernet function actually connects over USB within the chip. So
>> managing the power only in the ehci-hcd driver should suffice.
>
> the thing is that this could cause code duplication all over. LAN95xx=
 is

I can see this point.  However DT will soak up these regulator=20
definitions, at that point it's "for free".  On Linaro tilt-3.4 we=20
already have this on the dts

	hubpower: fixedregulator@0 {
			compatible =3D "regulator-fixed";
			regulator-name =3D "vhub0";
			regulator-min-microvolt =3D <3300000>;
			regulator-max-microvolt =3D <3300000>;
			gpio =3D <&gpio1 1 0>;		/* gpio 1 : HUB Power */
			startup-delay-us =3D <70000>;
			enable-active-high;
	};

	hubreset: fixedregulator@1 {
			compatible =3D "regulator-fixed";
			regulator-name =3D "hsusb0";	/* tag to associate with PORT 1 */
			regulator-min-microvolt =3D <3300000>;
			regulator-max-microvolt =3D <3300000>;
			gpio =3D <&gpio2 30 0>;	/* gpio 62 : HUB & PHY Reset */
			startup-delay-us =3D <70000>;
			enable-active-high;
			vin-supply =3D "vhub0"; /* Makes regulator f/w enable power before r=
eset */
	};

which is the equivalent to my patch: I don't think we need to sweat=20
about code duplication.

> a generic USB Hub + Ethernet combo on one of ports from SMSC. *Any*
> platform could use it and could hook those power and reset pins to a
> GPIO. If we handle this at ehci-omap level, we risk having to duplica=
te
> the same piece of code for ehci-*.c

We need to consider power and reset separately.  Reset is a safe bet as=
=20
a GPIO but power to the smsc chip is not.

On panda they happen to fit a gpio-controlled linear regulator to=20
provide the smsc 3.3V supply.  On another device that can just as easil=
y=20
be a PMIC regulator channel: it boils down to controlling a power rail.=
=20
  So using struct regulator as the abstraction for the power is the=20
right way already.

> Since that's a hub driver anyway, I wonder if it would be better to p=
lay
> with those gpios somewhere else ?!?

The patch creates a regulator that binds to a magic regulator name=20
defined by the hsusb driver, "hsusb0".

That regulator is taken up and down by hsusb driver with the lifecycle=20
of the logical hsusb device.  So inserting ehci-hcd module powers the=20
regulator until the module is removed.

Originally I bound the regulator to the smsc95xx driver, which also=20
offers a struct regulator.  But there is a quirk on Panda that means=20
that is not workable.

On Panda, they share one SoC gpio to reset both an external ULPI PHY=20
chip and the smsc95xx that is downstream of it.

After you power up the smsc95xx, you must reset it in order for correct=
=20
operation.  This actually resets the ULPI PHY too.

The ULPI PHY is permanently powered, only nRESET is provided to control=
 it.

=46or that reason, as an attribute of being on a Panda board, we need t=
o=20
do the (shared) reset meddling once at hsusb init, and that is why the=20
patch is as it is.

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
