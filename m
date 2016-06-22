From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 22 Jun 2016 11:30:13 +0300
Message-ID: <576A4C95.4080202@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com> <576A4321.6020209@ti.com>
 <87fus5ljwf.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P5A5M5SGJVpwShVxfDeGrEluvVSixGbvn"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fus5ljwf.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Peter Chen <hzpeterchen@gmail.com>, yoshihiro.shimoda.uh@renesas.com
Cc: peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--P5A5M5SGJVpwShVxfDeGrEluvVSixGbvn
Content-Type: multipart/mixed; boundary="Xomf6e9EgfC35tFb74CCtCiswQoWoSl3L"
From: Roger Quadros <rogerq@ti.com>
To: Felipe Balbi <balbi@kernel.org>, Peter Chen <hzpeterchen@gmail.com>,
 yoshihiro.shimoda.uh@renesas.com
Cc: peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org,
 dan.j.williams@intel.com, mathias.nyman@linux.intel.com,
 Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com,
 jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org,
 nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <576A4C95.4080202@ti.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com> <576A4321.6020209@ti.com>
 <87fus5ljwf.fsf@linux.intel.com>
In-Reply-To: <87fus5ljwf.fsf@linux.intel.com>

--Xomf6e9EgfC35tFb74CCtCiswQoWoSl3L
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22/06/16 11:14, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Roger Quadros <rogerq@ti.com> writes:
>>>>>>>>>> For the real use case, some Carplay platforms need it.
>>>>>>>>>
>>>>>>>>> Carplay does *NOT* rely on OTG. Apple has its own proprietary a=
nd closed
>>>>>>>>> specification which is not OTG-compliant.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, it is not OTG-compliant, but it can co-work with some stand=
ard OTG FSM
>>>>>>>> states to finish role swap.
>>>>>>>
>>>>>>> What are you referring to as "finish role swap"? I don't get that=
=2E
>>>>>>
>>>>>> Change current role from host to peripheral.
>>>>>
>>>>> Okay, we have two scenarios here:
>>>>>
>>>>> 1. You need full OTG compliance
>>>>>
>>>>> 	For this, granted, you need the state machine if your HW doesn't
>>>>> 	track it. This is a given. With only one user, however, perhaps
>>>>> 	we don't need a generic layer. There are not enough different
>>>>> 	setups to design a good enough generic layer. We will end up
>>>>> 	with a pseudo-generic framework which is coupled with its only
>>>>> 	user.
>>>>>
>>>>> 2. Dual-role support, without OTG compliance
>>>>>
>>>>> 	In this case, you don't need a stack. All you need is a signal
>>>>> 	to tell you state of ID pin and another to tell you state of
>>>>> 	VBUS level. If you have those, you don't need to walk an OTG
>>>>> 	state machine at all. You don't need any of those quirky OTG
>>>>> 	timers, agreed?
>>>>>
>>>>> 	Given the above, why would you even want to use a subset of OTG
>>>>> 	state machine to implement something that's _usually_ as simple
>>>>> 	as:
>>>>>
>>>>> 8<-----------------------------------------------------------------=
-----
>>>>> 	vbus =3D read(VBUS_STATE); /* could be a gpio_get_value() */
>>>>>         id =3D read(ID_STATE); /* could be a gpio_get_value() */
>>>>>
>>>>>         set_role(id);
>>>>>         set_vbus(vbus);
>>>>> -------------------------------------------------------------------=
-----
>>>>>
>>>>
>>>> In fact, the individual driver can do it by itself. The chipidea dri=
ver
>>>> handles OTG and dual-role well currently. By considering this OTG/DR=
D
>>>> framework is worthwhile or not, we would like to see if it can
>>>> simplify DRD design for each driver, and can benefit the platforms w=
hich
>>>> has different drivers for host and peripheral to finish the role swi=
tch
>>>> well.
>>>
>>> simplify how?  By adding unnecessary workqueues and a level indirecti=
on
>>> that just goes back to the same driver?
>>
>> What do you mean by same driver?
>=20
> dwc3 registers to OTG layer. dwc3 also registers as UDC to UDC
> layer. When dwc3 OTG IRQ fires, dwc3 tells OTG layer about it and OTG
> layer jumps to a callback that goes back to dwc3 to e.g. start
> peripheral side.
>=20
> See ?!? Starts on dwc3, goes to OTG layer, goes back to DWC3.
>=20
>> Gadget driver, host driver and PHY (or MUX) driver (for ID/VBUS) can
>> be 3 totally independent drivers unlike dwc3 where you have a single
>> driver in control of both host and gadget.
>=20
> That's a totally different issue and one not being tackled by OTG
> layer, because there are no such users yet. We can't design anything
> based solely on speculation of what might happen.
>=20
> If there aren't enough users, there is no way to design a good generic
> layer.
>=20
>> Questions not clear to me are:
>>
>> 1) Which driver handles ID/VBUS events and makes a decision to do the
>> role swap?  Probably the PHY/MUX driver?
>=20
> This is implementation dependent. For TI's USB subsystem, we have PMIC
> sampling VBUS/ID that and using EXTCON to tell dwc3-omap to program UTM=
I
> mailbox. The same mailbox can be used in HW-mode (see AM437x) where SW
> has no intervention.
>=20
> For Intel's USB subsystem, we have PMIC sampling VBUS/ID with an
> internal mux (much like TI's UTMI mailbox, but slightly different) to
> switch between a separate XHCI or a separate dwc3. The same mux can be
> put in HW-mode where SW has no intervention.
>=20
> In any case, for Intel's stuff most of the magic happens in ASL. Our PH=
Y
> driver just detects role (at least for Type-C based plats) and executes=

> _DSM with correct arguments [1]. _DSM will program internal MUX, toggle=

> VBUS and, for type-C, toggle VCONN when needed.
>=20
>> 2) How does it perform the role swap? Probably a register write to the=

>> PHY/MUX without needing to stop/start controllers? Easy case is both
>> controllers can run in co-existence without interference. Is there any=

>> platform other than dwc3 where this is not the case?
>=20
> Again speculation. But to answer your question, only dwc3 is in such a
> case today. But even for dwc3 we can have DRD with a much, much simpler=

> setup as I have already explained.
>=20
>> 3) Even if host and gadget controllers can operate in coexistence,
>> there is no need for both to be running for embedded applications
>> which are usually power conservative.  How can we achieve that?
>=20
> Now you're also speculating that you're running on embedded application=
s
> and that we _can_ power off parts of the IP. I happen to know that we
> can't power off XHCI part of dwc3 in TI's SoC because that's fed by sam=
e
> Clocks and power rails as the peripheral side.
>=20
> [1] https://lkml.org/lkml/2016/6/21/658
>=20
For TI's case it is dwc3 and you are implementing the role swap in the dw=
c3
driver where you do intend to remove the XHCI platform device. So I'm not=

much concerned about that.

I was concerned about other platforms. I guess I'll let the other platfor=
m
people speak up as to what they need.

--
cheers,
-roger


--Xomf6e9EgfC35tFb74CCtCiswQoWoSl3L--

--P5A5M5SGJVpwShVxfDeGrEluvVSixGbvn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXakyVAAoJENJaa9O+djCTXg0QALjVHqG26KbqsNM3dIk2UL1E
rG03OzaK48RMt4sTmshE0q9VKm3AhbgWX4yOD+qvTEUbib1LZosnWzPZwNVJ21hF
ySOnEgzlx5GrzbDqyE5+paH5zDeWJksq18Zlu7wwFu0o/QFfwdC738v0SNFBtrr1
l4SJZ0fqfaEggmZzDMOVKfrTkA8g0XxXbX8Wg5+82Aaq6kx6XKYBidWLd7lJ/0oF
Lw6iwndgszHXFHB0aMKIkrohAI6jhzt0Ve0PBpFu65k81WhxFTmSkn46WzhmF9i3
DpYTa6Jn7fy79dk7Pawyv/irTr93bJlhtPJ1y27iA0/RBOtzVocNM2RXBx/CTCYO
JKP8WTIlF9rEdIzGRau+LCQh2fwUtl9Xkebk9YNmND52POaLpGtjXBvwTvAqMITB
v975HvwpFz5LXzAKJSwDNdbykC4NKzR96YHGhz4/fuWmzZh8EvrIwgLuo6Fozn8B
PTsUQJCnvvfO2i+vMTzHc1hP5z9xVbJQiCI0tZKo1LDiEyTKxy2p08gyEinTUbV/
qbRiEJMZVTS4WoB5bW9FMH93d+4/UeRS+RStrtRgMQOAjEejghTE8vbAGJDzAfdw
ON4PiLcUckj/l1HOiyypElklOG7d4t/oib+t+QALPk/do+dMbAjpE9RjMK3SFrjS
JEqCRm5GATQIWgUZlAA0
=W1m1
-----END PGP SIGNATURE-----

--P5A5M5SGJVpwShVxfDeGrEluvVSixGbvn--
