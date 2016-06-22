From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 22 Jun 2016 10:49:53 +0300
Message-ID: <576A4321.6020209@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TXKH5b3ruFgemAaOuFuV5Guhbv1B1TqOD"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87por9lnjd.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Peter Chen <hzpeterchen@gmail.com>, yoshihiro.shimoda.uh@renesas.com
Cc: peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--TXKH5b3ruFgemAaOuFuV5Guhbv1B1TqOD
Content-Type: multipart/mixed; boundary="tcC5dlFFRxisDsArQ7F00DXcAJaWaVmM5"
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
Message-ID: <576A4321.6020209@ti.com>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com>
 <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
 <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
 <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
 <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
 <87por9lnjd.fsf@linux.intel.com>
In-Reply-To: <87por9lnjd.fsf@linux.intel.com>

--tcC5dlFFRxisDsArQ7F00DXcAJaWaVmM5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

On 22/06/16 09:56, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Peter Chen <hzpeterchen@gmail.com> writes:
>>> Peter Chen <hzpeterchen@gmail.com> writes:
>>>>>>> So far, I haven't seen anybody talking about real USB OTG (the sp=
ec)
>>>>>>> when they say OTG. Usually they just mean "a method for swapping =
between
>>>>>>> host and peripheral roles, but we really don't want all the extra=
 cost
>>>>>>> of the OTG specification".
>>>>>>>
>>>>>>
>>>>>> That's what I thought before, but the request from the Marketing g=
uy is
>>>>>> "To prove the SoC is OTG compliance, support HNP and SRP", don't y=
ou
>>>>>> see the SoC reference manual say "it supports HNP and SRP"?
>>>>>>
>>>>>> If there is no request, who else wants to implement so complicated=
 FSM
>>>>>> but seldom use cases, and go to pass OTG compliance test (tested b=
y PET).
>>>>>
>>>>> I stand corrected :-)
>>>>>
>>>>> So there is one user for this layer. And this user has its own role=

>>>>> control registers. I'm not convinced we need this large generic lay=
er
>>>>> for one user.
>>>>>
>>>>
>>>> You mean chipidea or dwc3? I have more comments below.
>>>
>>> chipidea. From the point of OTG (or DRD) dwc3 is very
>>> self-sufficient. HW itself tracks state machine, much like MUSB does.=

>>
>> You mean HW can do state machine switch? If we are A device,
>> - Does the hardware knows if B device is HNP enabled or not?
>=20
> that's enabled through control message, keep a flag.
>=20
>> - And if B device is HNP enabled, does it can switch itself from host
>> to peripheral when the B device is disconnected (a_suspend->a_peripher=
al)
>=20
> It cannot. It must rely on hnp polling which is, again, a control messa=
ge.
>=20
>> Does hardware can really follow Figure 7-1: OTG A-device with HNP Stat=
e
>> Diagram at On-The-Go and Embedded Host Supplement to the USB Revision
>> 2.0 Specification? And can pass PET test?
>=20
> Seriously, what does this add to the conversation? It has already been
> stated that there's nobody asking for OTG certification on dwc3. So all=

> of this is vaporware from the point of view of dwc3.
>=20
>>>>>>>> For the real use case, some Carplay platforms need it.
>>>>>>>
>>>>>>> Carplay does *NOT* rely on OTG. Apple has its own proprietary and=
 closed
>>>>>>> specification which is not OTG-compliant.
>>>>>>>
>>>>>>
>>>>>> Yes, it is not OTG-compliant, but it can co-work with some standar=
d OTG FSM
>>>>>> states to finish role swap.
>>>>>
>>>>> What are you referring to as "finish role swap"? I don't get that.
>>>>
>>>> Change current role from host to peripheral.
>>>
>>> Okay, we have two scenarios here:
>>>
>>> 1. You need full OTG compliance
>>>
>>> 	For this, granted, you need the state machine if your HW doesn't
>>> 	track it. This is a given. With only one user, however, perhaps
>>> 	we don't need a generic layer. There are not enough different
>>> 	setups to design a good enough generic layer. We will end up
>>> 	with a pseudo-generic framework which is coupled with its only
>>> 	user.
>>>
>>> 2. Dual-role support, without OTG compliance
>>>
>>> 	In this case, you don't need a stack. All you need is a signal
>>> 	to tell you state of ID pin and another to tell you state of
>>> 	VBUS level. If you have those, you don't need to walk an OTG
>>> 	state machine at all. You don't need any of those quirky OTG
>>> 	timers, agreed?
>>>
>>> 	Given the above, why would you even want to use a subset of OTG
>>> 	state machine to implement something that's _usually_ as simple
>>> 	as:
>>>
>>> 8<-------------------------------------------------------------------=
---
>>> 	vbus =3D read(VBUS_STATE); /* could be a gpio_get_value() */
>>>         id =3D read(ID_STATE); /* could be a gpio_get_value() */
>>>
>>>         set_role(id);
>>>         set_vbus(vbus);
>>> ---------------------------------------------------------------------=
---
>>>
>>
>> In fact, the individual driver can do it by itself. The chipidea drive=
r
>> handles OTG and dual-role well currently. By considering this OTG/DRD
>> framework is worthwhile or not, we would like to see if it can
>> simplify DRD design for each driver, and can benefit the platforms whi=
ch
>> has different drivers for host and peripheral to finish the role switc=
h
>> well.
>=20
> simplify how?  By adding unnecessary workqueues and a level indirection=

> that just goes back to the same driver?

What do you mean by same driver?
Gadget driver, host driver and PHY (or MUX) driver (for ID/VBUS) can be 3=
 totally
independent drivers unlike dwc3 where you have a single driver in control=
 of
both host and gadget.

Questions not clear to me are:
1) Which driver handles ID/VBUS events and makes a decision to do the rol=
e swap?
Probably the PHY/MUX driver?
2) How does it perform the role swap? Probably a register write to the PH=
Y/MUX
without needing to stop/start controllers? Easy case is both controllers =
can
run in co-existence without interference. Is there any platform other tha=
n dwc3
where this is not the case?
3) Even if host and gadget controllers can operate in coexistence, there =
is no need for
both to be running for embedded applications which are usually power cons=
ervative.
How can we achieve that?

>=20
>>>> commit 11c011a5e777c83819078a18672543f04482b3ec
>>>> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> Date:   Thu May 19 11:12:56 2016 +0100
>>>>
>>>>     usb: echi-hcd: Add ehci_setup check before echi_shutdown
>>>>        =20
>>>>
>>>>
>>>> In some cases, the USB code (gadget/hcd->start/stop) needs to be cal=
led
>>>> during the role swap. For example, if you have mux driver, you may
>>>> need to call usb_remove_hcd when ID from 0 to 1. Without Roger's fra=
mework,
>>>> how can we do that?
>>>
>>> You don't really need to remove the gadget. Just mask its interrupts =
and
>>> ignore any calls to any gadget_driver ops, right? Likewise for
>>> XHCI. Just clear RUN/STOP and no events will ever reach XHCI. But, fr=
om
>>> the point of view of dwc3, it's simpler to unregister the platform
>>> device we create for xhci-plat.c. I need no changes in XHCI to do tha=
t
>>> and driver model will make sure to call xhci-plat's ->remove() which
>>> will handle everything for me correctly.
>>>
>>
>> I admit it can do in a IP driver, eg both host and peripheral for the
>> single IP, eg chipidea, dwc3, etc. But how can we clear RUN/STOP bit
>> or what else for HCD at mux driver?
>=20
> dwc3's OTG block has control of that, however, what I'll do is
> platform_device_del() xhci-plat's device. Not one line changes inside
> XHCI.
>=20

Let's talk about how non dwc3 based platforms can get it done.

Yoshihiro-san, could you please share your platform requirements from dua=
l-role
perspective?

cheers,
-roger


--tcC5dlFFRxisDsArQ7F00DXcAJaWaVmM5--

--TXKH5b3ruFgemAaOuFuV5Guhbv1B1TqOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXakMkAAoJENJaa9O+djCTIDEP/idcA+FZZ40HXt8C/Diq1z55
WQv6Wf0TO/lTK1+lF2C702S3RDMmiiBo440WgQHXLI6xdKYNrtEAMNTl0pWVosRh
J7YD+IdOtf7hcq1Fm+DJg/QlD3BXg8ouJ4BUaJzina0gyY0Q7D0Nt9965i/eq554
3wwKZhjDIn63OYgo19whi5nBlrTieEfD0xTLperIiglOMCnIn4hT9VN/gDIVeStQ
7PUuWVzP2nmQDNd2i8klgdjhuFW/gunUK7WyLuzzMPmW+5mu1hSmCgKMO9IIbYIu
JWClQGuxMi3GxzLycsamY8mQuE2M9eRL+jhUpPaX6+e9ex0eP8U5NCzkwxr5do41
Q07BVIxOWSEuxk4fI6MuPg4OO7neIEyrvCiscblAf/g2t3M+ZxtKCM3Ye9vXy2km
uuK4WUVbUNO4O7OaVqP9xlqFxME3ErRKKfpvgS2xX7MFHpXEVG48C+YXBlbG+SVr
aKW5addSBMygys3NJwpaNRhUcrFXEa72Dal7MUpfvh5LOpMyYVcvOINUwcCV9/V7
tHjuHd2k1DzORujkhtXuG7+84Ob61loBjzOjWfCShyxTkiMS4Yw2dH2ciZ7qxRXW
iNJ/lve3v9KVPKDtqXzb8nJS3HVn87xN0knxrkjqZ7r8JPYK4HiMvy5GOBHdkCYh
4Knr+VRxMCLzRYB8Cw5X
=4iz7
-----END PGP SIGNATURE-----

--TXKH5b3ruFgemAaOuFuV5Guhbv1B1TqOD--
