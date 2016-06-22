From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 22 Jun 2016 11:14:56 +0300
Message-ID: <87fus5ljwf.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2> <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2> <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2> <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2> <87por9lnjd.fsf@linux.intel.com> <576A4321.6020209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <576A4321.6020209@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Peter Chen <hzpeterchen@gmail.com>, yoshihiro.shimoda.uh@renesas.com
Cc: peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>>>>>>> For the real use case, some Carplay platforms need it.
>>>>>>>>
>>>>>>>> Carplay does *NOT* rely on OTG. Apple has its own proprietary and =
closed
>>>>>>>> specification which is not OTG-compliant.
>>>>>>>>
>>>>>>>
>>>>>>> Yes, it is not OTG-compliant, but it can co-work with some standard=
 OTG FSM
>>>>>>> states to finish role swap.
>>>>>>
>>>>>> What are you referring to as "finish role swap"? I don't get that.
>>>>>
>>>>> Change current role from host to peripheral.
>>>>
>>>> Okay, we have two scenarios here:
>>>>
>>>> 1. You need full OTG compliance
>>>>
>>>> 	For this, granted, you need the state machine if your HW doesn't
>>>> 	track it. This is a given. With only one user, however, perhaps
>>>> 	we don't need a generic layer. There are not enough different
>>>> 	setups to design a good enough generic layer. We will end up
>>>> 	with a pseudo-generic framework which is coupled with its only
>>>> 	user.
>>>>
>>>> 2. Dual-role support, without OTG compliance
>>>>
>>>> 	In this case, you don't need a stack. All you need is a signal
>>>> 	to tell you state of ID pin and another to tell you state of
>>>> 	VBUS level. If you have those, you don't need to walk an OTG
>>>> 	state machine at all. You don't need any of those quirky OTG
>>>> 	timers, agreed?
>>>>
>>>> 	Given the above, why would you even want to use a subset of OTG
>>>> 	state machine to implement something that's _usually_ as simple
>>>> 	as:
>>>>
>>>> 8<--------------------------------------------------------------------=
--
>>>> 	vbus =3D read(VBUS_STATE); /* could be a gpio_get_value() */
>>>>         id =3D read(ID_STATE); /* could be a gpio_get_value() */
>>>>
>>>>         set_role(id);
>>>>         set_vbus(vbus);
>>>> ----------------------------------------------------------------------=
--
>>>>
>>>
>>> In fact, the individual driver can do it by itself. The chipidea driver
>>> handles OTG and dual-role well currently. By considering this OTG/DRD
>>> framework is worthwhile or not, we would like to see if it can
>>> simplify DRD design for each driver, and can benefit the platforms which
>>> has different drivers for host and peripheral to finish the role switch
>>> well.
>>=20
>> simplify how?  By adding unnecessary workqueues and a level indirection
>> that just goes back to the same driver?
>
> What do you mean by same driver?

dwc3 registers to OTG layer. dwc3 also registers as UDC to UDC
layer. When dwc3 OTG IRQ fires, dwc3 tells OTG layer about it and OTG
layer jumps to a callback that goes back to dwc3 to e.g. start
peripheral side.

See ?!? Starts on dwc3, goes to OTG layer, goes back to DWC3.

> Gadget driver, host driver and PHY (or MUX) driver (for ID/VBUS) can
> be 3 totally independent drivers unlike dwc3 where you have a single
> driver in control of both host and gadget.

That's a totally different issue and one not being tackled by OTG
layer, because there are no such users yet. We can't design anything
based solely on speculation of what might happen.

If there aren't enough users, there is no way to design a good generic
layer.

> Questions not clear to me are:
>
> 1) Which driver handles ID/VBUS events and makes a decision to do the
> role swap?  Probably the PHY/MUX driver?

This is implementation dependent. For TI's USB subsystem, we have PMIC
sampling VBUS/ID that and using EXTCON to tell dwc3-omap to program UTMI
mailbox. The same mailbox can be used in HW-mode (see AM437x) where SW
has no intervention.

For Intel's USB subsystem, we have PMIC sampling VBUS/ID with an
internal mux (much like TI's UTMI mailbox, but slightly different) to
switch between a separate XHCI or a separate dwc3. The same mux can be
put in HW-mode where SW has no intervention.

In any case, for Intel's stuff most of the magic happens in ASL. Our PHY
driver just detects role (at least for Type-C based plats) and executes
_DSM with correct arguments [1]. _DSM will program internal MUX, toggle
VBUS and, for type-C, toggle VCONN when needed.

> 2) How does it perform the role swap? Probably a register write to the
> PHY/MUX without needing to stop/start controllers? Easy case is both
> controllers can run in co-existence without interference. Is there any
> platform other than dwc3 where this is not the case?

Again speculation. But to answer your question, only dwc3 is in such a
case today. But even for dwc3 we can have DRD with a much, much simpler
setup as I have already explained.

> 3) Even if host and gadget controllers can operate in coexistence,
> there is no need for both to be running for embedded applications
> which are usually power conservative.  How can we achieve that?

Now you're also speculating that you're running on embedded applications
and that we _can_ power off parts of the IP. I happen to know that we
can't power off XHCI part of dwc3 in TI's SoC because that's fed by same
Clocks and power rails as the peripheral side.

[1] https://lkml.org/lkml/2016/6/21/658

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXakkBAAoJEIaOsuA1yqREdYIP/jHsSFwyjr52jPI3tttLDR/U
k27cdbsy8FUPfWbzM7mlfSW5n3qG0wUKvJc+1dVK+QsmAR5f78w91pbVlpUmf+wK
iHy0B4TWX1NGW2FW/2G347TUT/JyIzDF+cH1pWyuN6E2a0I5f+moy3lNH1iBkB2v
vs4CaxiygYI5VAzNiRTLvr4FwvlGUNvkzvKQJQ/0qoxPXL2J3G4ZEoO5jzOF/jrU
7nPB1gzoqnratBB1zJOXV36Fljyh/yqVT9JrtWlkvh3OBL5FzAoxN5shzOGSchme
EBWe0p8XFjK5iMr3IK0X+FDa0YPwrpW8w5IjmTPh91KqDSUjQKSXFQv6FZGeclk1
Z6Z39YSJujySlyr5P9CPe5j5Jsee06GPZ5SCjgSR5TsbOPKbiza+q3szFqDTCU2y
iC4sZMzwLZgbMG827m+kcIEs1vE7/pVdmjjSf8Fu6+Rm28bU+f0/XoLhc/9umUfY
hQmuYgdOd81IZISd5HwAaTT6eOfShEd2rYHHWVMHoRGJ7mR+0gJQN19Er5EHAif2
aK2SDtaD3mRr4L3akjyfr6znItqbsMHIHtasVQmwyg12kLq3S2RqAoBP5YCTCzIS
IWxrsYgA7RWsX5EK1mZB5wRebhC7Dikib1YIxHLUTvqTfkdWjuqSkTvEjI9WWd/a
KyTwFKQ0FJO+gHHjFOp3
=aON4
-----END PGP SIGNATURE-----
--=-=-=--
