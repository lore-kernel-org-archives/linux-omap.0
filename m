From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Mon, 1 Dec 2014 08:35:48 -0600
Message-ID: <20141201143548.GB9264@saruman>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
 <20141117180413.GF7046@atomide.com>
 <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
 <20141118154204.GI7046@atomide.com>
 <CAFqH_508pYkDXO8BCR=cFGFY_CgfkhqvseUy=Z--fJMOQCo6Tg@mail.gmail.com>
 <20141119175348.GK7046@atomide.com>
 <CAGm1_kvZnkB4MWPv3ExCqibb0Rq4xXfkPHHpfDb9HOTFNf7BiA@mail.gmail.com>
 <20141129153521.GB14924@saruman>
 <CAGm1_ku4UYL0DX9DuSJWn9-QKhcq+mUKyVTA433F6XbRe2FnHg@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_ku4UYL0DX9DuSJWn9-QKhcq+mUKyVTA433F6XbRe2FnHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2014 at 08:57:14AM +0100, Yegor Yefremov wrote:
> On Sat, Nov 29, 2014 at 4:35 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > Hi,
> >
> > On Fri, Nov 28, 2014 at 11:35:53AM +0100, Yegor Yefremov wrote:
> >> On Wed, Nov 19, 2014 at 6:53 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrot=
e:
> >> > * Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141119 03:14]:
> >> >> 2014-11-18 16:42 GMT+01:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> >> >>
> >> >> Checked again, and no luck. It's very weird because from the OTG po=
int
> >> >> of view, OTG is exactly the same between Beagleboard-XM and IGEPv2.
> >> >>
> >> >> Can you confirm that you're using kernel 3.18-rc5 without other
> >> >> patches applied ? At this moment, I don't have a Beagleboard-XM to
> >> >> test, I'll try to get one because at this moment I'm a bit stuck wi=
th
> >> >> this problem.
> >> >
> >> > Yes it was with v3.18-rc5 and the defconfig patch I posted except
> >> > I had to disable all the other MUSB platforms. Also tested it with
> >> > built in modules.
> >> >
> >> > Maybe you need to check the .dts pinctrl entries for hsusb0_* lines?
> >>
> >> Just my 2 cents, My am335x based board shows similar symptoms
> >> (CONFIG_USB_MUSB_DUAL_ROLE enabled). Only if I specify  dr_mode =3D
> >> "host"; in my DTS I get device enumerated. 3.15, that I had before
> >> made no problems as OTG.
> >
> > Are you sure your ID pin is properly routed ? If you set dr_mode to otg,
> > then you *must* have a properly routed ID pin and use a proper
> > micro-/mini-ab receptacle. That's not true for e.g. beagle bone black.
> >
> > One USB port is using a Standard-A while the other uses mini-B. You
> > can't do any role swapping with those.
>=20
> Yes, I'm sure, that ID pin is routed properly. It is also not BBB, but
> real device Baltos iR 5221
> (http://visionsystems.de/produkte/baltos-ir-5221.html). With 3.15 I'm
> able to use OTG port both as device and host. I boot the device,
> insert FTDI based hardware into OTG port and my ttyUSBx devices, then
> disconnect and connect to PC and I get usb0 network interface and can
> communicate with PC.

if you know it works on v3.15, then you have a bisection point. Can you
bisect it down to one commit ?

--=20
balbi

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfHzEAAoJEIaOsuA1yqRE9VAP/0MLMGOtc8jtIiHK+S/KS7Wi
3/w/o4YdhTglggIMQmB5WLxZzA5UIIl259/Rel8KEo3x0Vi7n/0JyGaVrsCcRgti
sdC4l9Kgc9mm40XPoHgiehDvw9ChvE2QmhPvG5dPUZpGqm309DATq542Gm3xdaan
vQHBfpLHYfAR8bbYyCMhLKSxJRliwIrFnsV8EQhe7OARAsa4XUhykFBOc/T4Wkde
Agh7ihJIQQfq1cLOzXqfbsuRNn2r1jFvB6gZpWrTzk2x1+8avW7Tqw/a3lzdb3/C
cldd6ANqjJid7giY+To/VAYiC8R8N9+ITnpLUIqB8kBpmL0XM/S74+VlxV4txtL+
+bcK1HBNOmp/GinXoGA/LEtraKGAgpkjSkotaGIsquX9JvO9IAoYqWzASFGTaa3H
nRr6SN3QIq1tFIm0cFPLWN70KCraKUFxB8TedCv7BGZxdRjkr6MwNoaNq2gSB16U
c5lDrLjMPHylR4zsir+/er93LGgcMGkvf4jWdbXQlZLxs5cPaDka3Mjlvvr07z5e
wDglc3RyGvintxjJIBkYALjPVpfw/eyaPdoBuAOcD0devAflTJsqIhoPaaQaXB5q
V+MT91KDf0Jc5CoHRcgiQaeuewUgxkLnDiu+LHl1IJ6fs/pH6OK8thrZmceVLN5m
++MM71ZAo5IUu8yWvqlo
=FEXz
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
