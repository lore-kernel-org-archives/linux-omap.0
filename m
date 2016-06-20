From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Mon, 20 Jun 2016 15:08:15 +0300
Message-ID: <8737o8qd00.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160620114904.GC26936@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> > It provides APIs for the following tasks
>> >
>> > - Registering an OTG/dual-role capable controller
>> > - Registering Host and Gadget controllers to OTG core
>> > - Providing inputs to and kicking the OTG state machine
>>=20
>> I think I have already mentioned this, but after over 10 years of OTG,
>> nobody seems to care about it, why are we still touching at all I don't
>> know. For common non-OTG role-swapping we really don't need any of this
>> and, quite frankly, I fail to see enough users for this.
>>=20
>> Apparently there's only chipidea which, AFAICT, already had working
>> dual-role before this OTG State Machine was added to the kernel.
>
> Some users would like to know if vendor's platform is OTG compliance,
> so we add it to pass usb.org USB OTG certification test.

I strongly doubt that's really what they mean. IMHO, users want to know
if they can swap roles. Ask them if they are really going for OTG
certification. Ask them if they have an OPT tester. Ask them if they
really want all those timers. If they want HNP polling, etc etc etc.

So far, I haven't seen anybody talking about real USB OTG (the spec)
when they say OTG. Usually they just mean "a method for swapping between
host and peripheral roles, but we really don't want all the extra cost
of the OTG specification".

> For the real use case, some Carplay platforms need it.

Carplay does *NOT* rely on OTG. Apple has its own proprietary and closed
specification which is not OTG-compliant.

>> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> > index f4fc0aa..1d74fb8 100644
>> > --- a/include/linux/usb/gadget.h
>> > +++ b/include/linux/usb/gadget.h
>> > @@ -328,6 +328,7 @@ struct usb_gadget_ops {
>> >   * @in_epnum: last used in ep number
>> >   * @mA: last set mA value
>> >   * @otg_caps: OTG capabilities of this gadget.
>> > + * @otg_dev: OTG controller device, if needs to be used with OTG core.
>>=20
>> do you really know of any platform which has a separate OTG controller?
>>=20
>
> It may not be a real separate OTG controller. It can be a hardware part
> (external connector, external IC, SoC OTG register area, etc) to handle v=
bus
> ,id and other signals which are used for role swap.

That's already solved. EXTCON solved that years back and OMAP has been
using EXTCON to program its UTMI mailbox.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ9yvAAoJEIaOsuA1yqREEMcP/2mxfPFK0gi9AIA2eFm0CAWn
KnkGUBAEZst10hrhCLGzvkB6Th9MwPZCY/fszIx9/DvmD3NRxtH+gVS8ln6Yp0V2
Wev4JbbD8b2KSAU7veTiyB8t9aS4zidTnMzpWRBR98yR/ixp0tcvoBixDCYGhw5K
y73MAuf7VL3pRRN0i0ZyBuW3Uls+epNRgemb315BeHgqdHzseDMap9DbIzNO22M/
IOvA+Q4sjOHI4X+ZH1B99riwWYtmeYc7ONjjeE5v2PFQ7fAnL7sK6Q84mDDp/jkI
4MrkqXlNqgd+AL0preBZeL5ruCQy2SGhgl3ccvj7ZGasA7DF/yidi16siqAUgvQ3
eQYHmviJlk5vLLW7mqZscvfvDbNBt0KWMjUUH5vDuh5VPulHoyZxXifR077qjtL6
kGKXx+N89jmlufH195fSJxNMgURwVpAx2OSqLP6X4iTT3XJ4EGxesoo/MXaL4+5H
4I8cjbJ+QpUTNrTLqpH7vC9CH3sF+uiwRs755ESqWJVxuiBAzFo9S52Bc0FxjQy1
uMDjLoXcpIfvA16dTE+77WTaGwd8PFFXwUz5Om/s8O2hv0bC8UJPZwv3a+UxMWD+
Vlyq3oau2SNdDTxU0WaNYQI+drYCzcNIPEzsaE0VIr0wKZl93q1dGzcecbu8Hh+R
+sIH0uf3T/oSxE1E72Xu
=TFSG
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
