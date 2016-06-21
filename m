From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 10:26:00 +0300
Message-ID: <877fdjovef.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2> <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621060517.GA5108@shlinux2>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >> > It provides APIs for the following tasks
>> >> >
>> >> > - Registering an OTG/dual-role capable controller
>> >> > - Registering Host and Gadget controllers to OTG core
>> >> > - Providing inputs to and kicking the OTG state machine
>> >>=20
>> >> I think I have already mentioned this, but after over 10 years of OTG,
>> >> nobody seems to care about it, why are we still touching at all I don=
't
>> >> know. For common non-OTG role-swapping we really don't need any of th=
is
>> >> and, quite frankly, I fail to see enough users for this.
>> >>=20
>> >> Apparently there's only chipidea which, AFAICT, already had working
>> >> dual-role before this OTG State Machine was added to the kernel.
>> >
>> > Some users would like to know if vendor's platform is OTG compliance,
>> > so we add it to pass usb.org USB OTG certification test.
>>=20
>> I strongly doubt that's really what they mean. IMHO, users want to know
>> if they can swap roles. Ask them if they are really going for OTG
>> certification. Ask them if they have an OPT tester. Ask them if they
>> really want all those timers. If they want HNP polling, etc etc etc.
>>=20
>> So far, I haven't seen anybody talking about real USB OTG (the spec)
>> when they say OTG. Usually they just mean "a method for swapping between
>> host and peripheral roles, but we really don't want all the extra cost
>> of the OTG specification".
>>=20
>
> That's what I thought before, but the request from the Marketing guy is
> "To prove the SoC is OTG compliance, support HNP and SRP", don't you
> see the SoC reference manual say "it supports HNP and SRP"?
>
> If there is no request, who else wants to implement so complicated FSM
> but seldom use cases, and go to pass OTG compliance test (tested by PET).

I stand corrected :-)

So there is one user for this layer. And this user has its own role
control registers. I'm not convinced we need this large generic layer
for one user.

>> > For the real use case, some Carplay platforms need it.
>>=20
>> Carplay does *NOT* rely on OTG. Apple has its own proprietary and closed
>> specification which is not OTG-compliant.
>>=20
>
> Yes, it is not OTG-compliant, but it can co-work with some standard OTG F=
SM
> states to finish role swap.

What are you referring to as "finish role swap"? I don't get that.

> Notice, it needs to swap role without disconnect cable.

right, I can swap role without changing cable, but that's not OTG. The
mechanism for that, AFAICT, is not HNP. I don't know details about
CarPlay because the spec isn't public, but my understanding is that
CarPlay doesn't rely on anything from OTG spec.

>> >> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> >> > index f4fc0aa..1d74fb8 100644
>> >> > --- a/include/linux/usb/gadget.h
>> >> > +++ b/include/linux/usb/gadget.h
>> >> > @@ -328,6 +328,7 @@ struct usb_gadget_ops {
>> >> >   * @in_epnum: last used in ep number
>> >> >   * @mA: last set mA value
>> >> >   * @otg_caps: OTG capabilities of this gadget.
>> >> > + * @otg_dev: OTG controller device, if needs to be used with OTG c=
ore.
>> >>=20
>> >> do you really know of any platform which has a separate OTG controlle=
r?
>> >>=20
>> >
>> > It may not be a real separate OTG controller. It can be a hardware part
>> > (external connector, external IC, SoC OTG register area, etc) to handl=
e vbus
>> > ,id and other signals which are used for role swap.
>>=20
>> That's already solved. EXTCON solved that years back and OMAP has been
>> using EXTCON to program its UTMI mailbox.
>>=20
>
> No, that's not the same thing, it does not include the swap role.

Read your original comment:

"handle vbus, id and other signals which are *used for* role swap"

You didn't include role swap in your original comment. Semantics aside...

> Consider the use case the host driver is at host/ and udc driver is
> at gadget/udc, how to finish to role swap?

... why does the source code placement matter? And what do you mean by
"finish role swap"?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaOwIAAoJEIaOsuA1yqREgbYP/RxCZFJBLW3omHXg87xcfooS
pVmygfbmh1qXSBDhsH9812mXRd7usMmduKWfeVHFMmkJLWpZ082RbG3ENJjteEdt
FPIwAl3u+nzIcF1kXHH2PGENg29PyO9/D2xmI5sjXNRdsXsntDupuKG5ejfTvBjY
RFgRJOE7te0oE36p1VBo4lIzmBJYOneDl8kFq+gOND99bKB+FjLZHY70KhhDIiag
F7CZcD1zqj73QIT4XbvXTt8PejTkCoQKMjYcm/GlFwEXbBgk1Rd4SY/3p6KY+95G
85vCnU8jd1BKfMvE3XiYQ/ebQ3okWWwA9G05lETR3QlyP84lYCU4oeafgMWcuB8m
urI/XlsWcX+UhYhsHaRYVwHKp/Z085zUIWwxu5uhI/N+3844m6dvJwVOm/etvw84
NHQTfQZrtZlFbJaTdQ+HZTSc2htTEOcIq8+Av4KAcde11TspLpfKyoUkbT3NxHUM
9jyNc8J96e8aULOvVQVvvlz6h2kd1KnrU4hv79+0EJ9DjS73H7MXuDSXaqPnvzGs
gEoiwA+OLMHUFNuzJYRJYJDtGZrBY2YYBsFMuBD2Qnz0n7t4a/Q3E0X590g3SOiG
K3C7zQGTROaCeqBkonrtpmp4aIUv4HjBdgAHc9qrIfGoqkdfD8zKW4FKPfwJFLru
N6P6TqcagQAmvBe3trkq
=67uV
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
