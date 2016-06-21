From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 13:02:59 +0300
Message-ID: <87h9cmoo4s.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2> <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2> <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621090738.GD5108@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen@gmail.com> writes:
>> >> So far, I haven't seen anybody talking about real USB OTG (the spec)
>> >> when they say OTG. Usually they just mean "a method for swapping betw=
een
>> >> host and peripheral roles, but we really don't want all the extra cost
>> >> of the OTG specification".
>> >>=20
>> >
>> > That's what I thought before, but the request from the Marketing guy is
>> > "To prove the SoC is OTG compliance, support HNP and SRP", don't you
>> > see the SoC reference manual say "it supports HNP and SRP"?
>> >
>> > If there is no request, who else wants to implement so complicated FSM
>> > but seldom use cases, and go to pass OTG compliance test (tested by PE=
T).
>>=20
>> I stand corrected :-)
>>=20
>> So there is one user for this layer. And this user has its own role
>> control registers. I'm not convinced we need this large generic layer
>> for one user.
>>=20
>
> You mean chipidea or dwc3? I have more comments below.

chipidea. From the point of OTG (or DRD) dwc3 is very
self-sufficient. HW itself tracks state machine, much like MUSB does.

>> >> > For the real use case, some Carplay platforms need it.
>> >>=20
>> >> Carplay does *NOT* rely on OTG. Apple has its own proprietary and clo=
sed
>> >> specification which is not OTG-compliant.
>> >>=20
>> >
>> > Yes, it is not OTG-compliant, but it can co-work with some standard OT=
G FSM
>> > states to finish role swap.
>>=20
>> What are you referring to as "finish role swap"? I don't get that.
>
> Change current role from host to peripheral.

Okay, we have two scenarios here:

1. You need full OTG compliance

	For this, granted, you need the state machine if your HW doesn't
	track it. This is a given. With only one user, however, perhaps
	we don't need a generic layer. There are not enough different
	setups to design a good enough generic layer. We will end up
	with a pseudo-generic framework which is coupled with its only
	user.

2. Dual-role support, without OTG compliance

	In this case, you don't need a stack. All you need is a signal
	to tell you state of ID pin and another to tell you state of
	VBUS level. If you have those, you don't need to walk an OTG
	state machine at all. You don't need any of those quirky OTG
	timers, agreed?

	Given the above, why would you even want to use a subset of OTG
	state machine to implement something that's _usually_ as simple
	as:

8<----------------------------------------------------------------------
	vbus =3D read(VBUS_STATE); /* could be a gpio_get_value() */
        id =3D read(ID_STATE); /* could be a gpio_get_value() */

        set_role(id);
        set_vbus(vbus);
=2D-----------------------------------------------------------------------

>> > Notice, it needs to swap role without disconnect cable.
>>=20
>> right, I can swap role without changing cable, but that's not OTG. The
>> mechanism for that, AFAICT, is not HNP. I don't know details about
>> CarPlay because the spec isn't public, but my understanding is that
>> CarPlay doesn't rely on anything from OTG spec.
>
> Since it is non-public, I can't say much. Some flows of its role-swap
> refers to On-The-Go and Embedded Host Supplement to the USB Revision 2.0
> Specification.=20
>
> But OTG FSM is not the only way, the platform which can do role-swap
> without disconnection can support it too.

Right, all you need for CarPlay is what I wrote above. You don't need
full OTG compliance for that, right?

>> >> >> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadg=
et.h
>> >> >> > index f4fc0aa..1d74fb8 100644
>> >> >> > --- a/include/linux/usb/gadget.h
>> >> >> > +++ b/include/linux/usb/gadget.h
>> >> >> > @@ -328,6 +328,7 @@ struct usb_gadget_ops {
>> >> >> >   * @in_epnum: last used in ep number
>> >> >> >   * @mA: last set mA value
>> >> >> >   * @otg_caps: OTG capabilities of this gadget.
>> >> >> > + * @otg_dev: OTG controller device, if needs to be used with OT=
G core.
>> >> >>=20
>> >> >> do you really know of any platform which has a separate OTG contro=
ller?
>> >> >>=20
>> >> >
>> >> > It may not be a real separate OTG controller. It can be a hardware =
part
>> >> > (external connector, external IC, SoC OTG register area, etc) to ha=
ndle vbus
>> >> > ,id and other signals which are used for role swap.
>> >>=20
>> >> That's already solved. EXTCON solved that years back and OMAP has been
>> >> using EXTCON to program its UTMI mailbox.
>> >>=20
>> >
>> > No, that's not the same thing, it does not include the swap role.
>>=20
>> Read your original comment:
>>=20
>> "handle vbus, id and other signals which are *used for* role swap"
>>=20
>> You didn't include role swap in your original comment. Semantics aside...
>>=20
>> > Consider the use case the host driver is at host/ and udc driver is
>> > at gadget/udc, how to finish to role swap?
>>=20
>> ... why does the source code placement matter? And what do you mean by
>> "finish role swap"?
>>=20
>
> Well, it depends on your driver design, do you want the host driver's
> API is still be called when current role is peripheral? One typical
> problem you can refer below:

That's a driver bug and those needs to be fixed. This has nothing to do
with an OTG FSM, or lack thereof.

Here's what I plan on doing for dwc3 (as soon as I get some time):

request_threaded_irq(dwc->otg_irq, ...);

irqreturn_t dwc3_otg_irq_thread(int irq, void *_dwc)
{
	struct dwc3 *dwc =3D _dwc;
        u32 reg;

        reg =3D readl(OSTS);
        if (reg & PERIPHERAL)
        	dwc3_gadget_init(dwc);

	if (reg & HOST)
        	dwc3_host_init(dwc);

	if (reg & SESSION_END)
        	dwc3_disable_host_and_peripheral(dwc);

	return IRQ_HANDLED;
}

Then, when building the driver with OTG support, we never start Host or
peripheral by default. Only the OTG IRQ handler, since that becomes the
entry point.

That's all we need for DRD support on DWC3. As for OTG, it won't be much
different because the HW tracks OTG state machine. The only difference
will be implemeting HNP (just another big in IRQ handler) and SRP
(already implemented as gadget_wakeup())

> commit 11c011a5e777c83819078a18672543f04482b3ec
> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date:   Thu May 19 11:12:56 2016 +0100
>
>     usb: echi-hcd: Add ehci_setup check before echi_shutdown
>=20=20=20=20=20=20=20=20=20
>
>
> In some cases, the USB code (gadget/hcd->start/stop) needs to be called
> during the role swap. For example, if you have mux driver, you may
> need to call usb_remove_hcd when ID from 0 to 1. Without Roger's framewor=
k,
> how can we do that?

You don't really need to remove the gadget. Just mask its interrupts and
ignore any calls to any gadget_driver ops, right? Likewise for
XHCI. Just clear RUN/STOP and no events will ever reach XHCI. But, from
the point of view of dwc3, it's simpler to unregister the platform
device we create for xhci-plat.c. I need no changes in XHCI to do that
and driver model will make sure to call xhci-plat's ->remove() which
will handle everything for me correctly.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaRDTAAoJEIaOsuA1yqREdRMP/irQAxHsWEQ3RDUWCnRMFEqa
OhJOGumDS17g1EJm1sqlT1ekilQiIfNmfmCJtc6/1Kn/njMCcGSgfrCTEp5KjikH
iBL6avkMYBchLcIA8EBZ42geqPRplcRJ9qSeLVT4YOtTzD+Y0P4VCHFsNlf9YaPW
k0iXrES2WsQ7nurhUsN52UEqR0AypSkywB1BVpjpYXi7REiCsF8dNAW55G3T7Y6j
luMueM9Kq22lI1S55Z9EGIjr4de9H5XRv6rbddG9c1IyMGbRTNNqIvONv3q70wc6
udpA4nHeSlU+jh6dUPMmyBttdkEZX3+2KyTKtvZvqLLr3IfaU2dfCLdv5NawZN6I
/ASOBAYfHYeElo6TJHu+CYooZhnHFo7pycJJXopJneNuBbk+JAAVLfLSS/XmCpDQ
VXEZ/yTxRti5BC5gr8ktEiY/R9QIEm0ggWUa3lwUmJrRf7A4On+fbNlsQRu6Qp3J
id06VwCTxHB7xpALVgEQ6bBwQdHX8PwNIaV5vvJqSlg3c39wZmvYAEDq7szy4J5n
R10jKneYVIoC0l9EaouDy50MYbgyPGyT7LzA8Bv8jt9DpN3NKAK10EbpOg/hoi7A
JDV2oZuuQXapPZ9dKy4BX7inva/hlqLM58/H1i/67zXbu12/EVFm/rbnfJrkI3aY
/5d8sjXEtr/jZShQM+I0
=BiIm
-----END PGP SIGNATURE-----
--=-=-=--
