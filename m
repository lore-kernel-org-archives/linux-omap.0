From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 22 Jun 2016 09:56:22 +0300
Message-ID: <87por9lnjd.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2> <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2> <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2> <87h9cmoo4s.fsf@linux.intel.com> <20160621130512.GF5108@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621130512.GF5108@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >> >> So far, I haven't seen anybody talking about real USB OTG (the spe=
c)
>> >> >> when they say OTG. Usually they just mean "a method for swapping b=
etween
>> >> >> host and peripheral roles, but we really don't want all the extra =
cost
>> >> >> of the OTG specification".
>> >> >>=20
>> >> >
>> >> > That's what I thought before, but the request from the Marketing gu=
y is
>> >> > "To prove the SoC is OTG compliance, support HNP and SRP", don't you
>> >> > see the SoC reference manual say "it supports HNP and SRP"?
>> >> >
>> >> > If there is no request, who else wants to implement so complicated =
FSM
>> >> > but seldom use cases, and go to pass OTG compliance test (tested by=
 PET).
>> >>=20
>> >> I stand corrected :-)
>> >>=20
>> >> So there is one user for this layer. And this user has its own role
>> >> control registers. I'm not convinced we need this large generic layer
>> >> for one user.
>> >>=20
>> >
>> > You mean chipidea or dwc3? I have more comments below.
>>=20
>> chipidea. From the point of OTG (or DRD) dwc3 is very
>> self-sufficient. HW itself tracks state machine, much like MUSB does.
>
> You mean HW can do state machine switch? If we are A device,
> - Does the hardware knows if B device is HNP enabled or not?

that's enabled through control message, keep a flag.

> - And if B device is HNP enabled, does it can switch itself from host
> to peripheral when the B device is disconnected (a_suspend->a_peripheral)

It cannot. It must rely on hnp polling which is, again, a control message.

> Does hardware can really follow Figure 7-1: OTG A-device with HNP State
> Diagram at On-The-Go and Embedded Host Supplement to the USB Revision
> 2.0 Specification? And can pass PET test?

Seriously, what does this add to the conversation? It has already been
stated that there's nobody asking for OTG certification on dwc3. So all
of this is vaporware from the point of view of dwc3.

>> >> >> > For the real use case, some Carplay platforms need it.
>> >> >>=20
>> >> >> Carplay does *NOT* rely on OTG. Apple has its own proprietary and =
closed
>> >> >> specification which is not OTG-compliant.
>> >> >>=20
>> >> >
>> >> > Yes, it is not OTG-compliant, but it can co-work with some standard=
 OTG FSM
>> >> > states to finish role swap.
>> >>=20
>> >> What are you referring to as "finish role swap"? I don't get that.
>> >
>> > Change current role from host to peripheral.
>>=20
>> Okay, we have two scenarios here:
>>=20
>> 1. You need full OTG compliance
>>=20
>> 	For this, granted, you need the state machine if your HW doesn't
>> 	track it. This is a given. With only one user, however, perhaps
>> 	we don't need a generic layer. There are not enough different
>> 	setups to design a good enough generic layer. We will end up
>> 	with a pseudo-generic framework which is coupled with its only
>> 	user.
>>=20
>> 2. Dual-role support, without OTG compliance
>>=20
>> 	In this case, you don't need a stack. All you need is a signal
>> 	to tell you state of ID pin and another to tell you state of
>> 	VBUS level. If you have those, you don't need to walk an OTG
>> 	state machine at all. You don't need any of those quirky OTG
>> 	timers, agreed?
>>=20
>> 	Given the above, why would you even want to use a subset of OTG
>> 	state machine to implement something that's _usually_ as simple
>> 	as:
>>=20
>> 8<----------------------------------------------------------------------
>> 	vbus =3D read(VBUS_STATE); /* could be a gpio_get_value() */
>>         id =3D read(ID_STATE); /* could be a gpio_get_value() */
>>=20
>>         set_role(id);
>>         set_vbus(vbus);
>> ------------------------------------------------------------------------
>>=20
>
> In fact, the individual driver can do it by itself. The chipidea driver
> handles OTG and dual-role well currently. By considering this OTG/DRD
> framework is worthwhile or not, we would like to see if it can
> simplify DRD design for each driver, and can benefit the platforms which
> has different drivers for host and peripheral to finish the role switch
> well.

simplify how?  By adding unnecessary workqueues and a level indirection
that just goes back to the same driver?

>> > commit 11c011a5e777c83819078a18672543f04482b3ec
>> > Author: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> > Date:   Thu May 19 11:12:56 2016 +0100
>> >
>> >     usb: echi-hcd: Add ehci_setup check before echi_shutdown
>> >=20=20=20=20=20=20=20=20=20
>> >
>> >
>> > In some cases, the USB code (gadget/hcd->start/stop) needs to be called
>> > during the role swap. For example, if you have mux driver, you may
>> > need to call usb_remove_hcd when ID from 0 to 1. Without Roger's frame=
work,
>> > how can we do that?
>>=20
>> You don't really need to remove the gadget. Just mask its interrupts and
>> ignore any calls to any gadget_driver ops, right? Likewise for
>> XHCI. Just clear RUN/STOP and no events will ever reach XHCI. But, from
>> the point of view of dwc3, it's simpler to unregister the platform
>> device we create for xhci-plat.c. I need no changes in XHCI to do that
>> and driver model will make sure to call xhci-plat's ->remove() which
>> will handle everything for me correctly.
>>=20
>
> I admit it can do in a IP driver, eg both host and peripheral for the
> single IP, eg chipidea, dwc3, etc. But how can we clear RUN/STOP bit
> or what else for HCD at mux driver?

dwc3's OTG block has control of that, however, what I'll do is
platform_device_del() xhci-plat's device. Not one line changes inside
XHCI.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXajaWAAoJEIaOsuA1yqREgRQP/A6XkUnDtNHQKXAHV+RBureo
92pNt3TWIZSmu5MT9AyPIDbW6Tieke2Fw6mrGH4u6Ms3SKakVtTRPwb1PWOi59n+
FOG20TfYanIGB8YFG6cFlFeNLOi0rL4svj90ObE5eyLvGST9meKuAqOO3YtOK52D
4rL+3aWEhib0IE31Q0ZunVUa9cEBXlyVviO4Xye4jb6l7C+hK9mjZM6Dklumnsy9
oAy/KkTv1JXy4Kf/PZrlrC2zxZH313oG0GQht8VYitpBDxu8KOu2pnjxcvZeYufh
80AXLkvASDrNUPrlYT7C57S7ZyL+MPrpfZOAEF8PW7r/dgNtHBNdAYJfh4Fx/hV2
+SSqueB/eSdfmd9O003jQVk6i3f/7AWlLabyh3l4mRvkmw2ZSODFBVUbCR72K06H
56OxqPBl76jgcscwrmmdNiIGLBUopH1oFwM7zKV1p+2OENkJeor3cdiTaJp/nKvg
i0n4v0Nt4nap85Mcwoa/K320C7vCpKZOwpaXhY1yePxBOuScwAhdfSsaOf4ldC4k
8bhI1vIGdufLQw0FZYAUZRznJYuNiDxz6o/oVIGea7r2k50rrzFyGAg0hKQ3mEYK
8eaRD0/96AA45XyIbYyxv+ZHx9NGid3dwhGFT83pHYzoNRD/tGQ6bP9aU67K/oEi
1sDkPm/+cMt4/Znp3h6d
=p1u3
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
