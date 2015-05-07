From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Thu, 7 May 2015 11:16:56 -0500
Message-ID: <20150507161656.GB29183@saruman.tx.rr.com>
References: <554AA11B.9040909@logicpd.com>
 <20150507160606.GB15563@atomide.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150507160606.GB15563-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 07, 2015 at 09:06:06AM -0700, Tony Lindgren wrote:
> * Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org> [150506 16:19]:
> > Hi all -
> >=20
> > I'm running kernel v3.19 (although I've tried v4.1-rc2's version of the=
 MUSB
> > code) on a DM3730 processor.  I'm running into an issue where if I enab=
le
> > MUSB Inventra DMA, plug in a USB Ethernet Dongle, and run iperf between=
 the
> > dongle and a PC, the MUSB driver stops working.  I get the following in=
 my
> > kernel log, twice back-to-back:
> >=20
> >     musb_host_rx 1762: Rx interrupt with no errors or packet!
> >=20
> > Any ideas?
> >=20
> > The test above works in PIO mode, but I'd like to reduce the system CPU
> > usage of the driver by using DMA.  I'm using a ASIX AX88772B Ethernet
> > dongle, although, this shouldn't impact the error above.  I also tried
> > re-reading the RXCSR register immediately after the error printout abov=
e,
> > and the immediate subsequent time it contains the bit the driver is loo=
king
> > for.  I tried nesting the check so that if the bit the driver is lookin=
g for
> > is set with an immediate subsequent read that it would continue past it=
, but
> > it still keels over (albeit lasting maybe a second longer).
> >=20
> > Something about this feels race conditiony too.  Depending on the kernel
> > configuration options in the kernel debug menu (which slows down other =
parts
> > of the kernel), or if I enable verbose debug message output from the MU=
SB
> > driver, it lasts much, much longer before keeling over as a system.  Yo=
u can
> > restore normal behavior by unplugging/replugging in the device.
>=20
> This sounds like some issue dealing with certain size transfers where
> there's data remaining after a DMA transfer. You might be able to make
> it easily reproducable with a variable size ping from your PC even with
> debugging enabled. Something like the script below.
>=20
> Regards,
>=20
> Tony
>=20
> 8< --------------
> #!/bin/bash
>=20
> device=3D$1
> size=3D$2
>=20
> while [ 1 ]; do
> 	#echo "Pinging with size $size"
> 	if ! ping -w0 -c1 $device -s$size > /dev/null 2>&1; then
> 		break;
> 	fi
> 	size=3D$(expr $SIZE + 1)
>=20
> 	if [ $size -gt 8192 ]; then
> 		size=3D1
> 	fi
> done
>=20
> echo "Test ran up to $size"

I'd be very much interested in getting such logs :-)

--=20
balbi

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVS4/4AAoJEIaOsuA1yqREjg4QAJySJJ9zb8W1Pi1T3iAUjtiU
PBZ88B0lOgFVfSvXCwX8ngzqDx6zyItGEsXQJAUt2G0IaVrY7NMKFHDPE+i6DE+E
o2Cm/V36ak4bbS4MJIF5Cflqhn7GMIaozqgPylIzFHqbbc0ufG01497okjxw5CFQ
ZXmiMsDMSKBcR4wI2aN4aFZ9iOetFf7/mXIaAvLCj5FGqvBEdRr3oxT3zn1vLM0I
APzvBdMqykX9P7Q/n8aGmiUbvt9Or5ti9a7JZqm6t+xvyIL0KmJH9JysD6MW93SQ
dJ8GWt3piLKjT5KggnV5ox8hGymaX4jecF8NnSDPzuGi0zWgVzDO5HvJvSznrV1T
npcMAm5IA2ICYPc1kpc5cR4NGyowK9O2YfMRQtar1Thv6QuHK7lefeMnxupM52nb
2sxn8kdzyt9OuXtD12LN6JFArhr+Mld1ZsNWMbpw6yFzeJx7X6REDpHCB8cne7nU
QQZNTD7ryTGlCT7SDPiap6ynY3cDlBIcPJ70+lU6WY6GDq1u/FSkEOorYSmAgm/n
gK4XQ7E0ygv/B72qtiFQriA0vv38Y40MTHZWJJIdJDIbg5Uqi9LSxjpx/kEesRTq
gGiXJRyHPDltAamVBvvdYEWQFG74J/0OnDlrFtyBxb6ksujPLXPokE6+apvEHBsE
7H6edrueK0G4RKkaTVHZ
=IjsJ
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
