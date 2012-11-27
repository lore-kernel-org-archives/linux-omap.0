From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Tue, 27 Nov 2012 18:30:22 +0200
Message-ID: <20121127163022.GB24240@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <87fw49cnvh.fsf@deeprootsystems.com>
 <50AA05C3.7010003@ti.com>
 <876251b2kq.fsf@deeprootsystems.com>
 <50B4D167.4090205@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37742 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755861Ab2K0QhG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 11:37:06 -0500
Content-Disposition: inline
In-Reply-To: <50B4D167.4090205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 04:42:47PM +0200, Roger Quadros wrote:
> On 11/20/2012 01:22 AM, Kevin Hilman wrote:
> > Roger Quadros <rogerq@ti.com> writes:
> >=20
> >> Kevin,
> >>
> >> On 11/16/2012 10:08 PM, Kevin Hilman wrote:
> >>> Roger Quadros <rogerq@ti.com> writes:
> >>>
> >>>> Hi,
> >>>>
> >>>> This patchset addresses the following
> >>>>
> >>>> - Avoid addressing clocks one by one by name and use a for loop + bu=
nch
> >>>>   of cleanups.
> >>>> - Get number of channels/ports dynamically either from revision regi=
ster
> >>>>   or from platform data. Avoids getting clocks that are not present.
> >>>> - Add OMAP5 and HSIC mode (Not tested)
> >>>> - Save power on Panda when EHCI driver is not loaded.
> >>>>
> >>>
> >>> Seeing the clock changes/cleanups, I gave this a spin on OMAP3
> >>> (3530/Beagle, 3530/Overo, 3730/Beagle-xM, 3730/OveroSTORM) to see if =
it
> >>> fixed up the problem where CORE does not hit retention in idle when U=
SB
> >>> host is enabled, even with no devices attached.
> >>>
> >>> Unfortunately, it didn't help. :(
> >>
> >> oh that's bad. But this series wasn't meant to fix that ;).
> >=20
> > Oh, sorry.  Yeah, I didn't mean this as a nak.  Just an opportunity to
> > complain to the maintainers that a long-standing issue needs to be
> > addressed.
> >=20
>=20
> Kevin,
>=20
> I gave a quick look at the issue. It seems that the High Speed USB Host
> module is kept in Software forced wakeup mode as a quick fix workaround
> to a bunch of silicon erratas. And we do nothing on USB global suspend.
> That's why CORE does not hit retention.
>=20
> If we runtime_suspend the USB host module on USB global suspend then it
> will be put in Force Idle mode. This will allow CORE to hit retention
> but then we will no longer be able to detect USB device connect events.
>=20
> So, till we have a better solution I will suggest to keep EHCI_HCD as a
> module in omap2plus_defconfig.

I guess that "better solution" would be I/O pads wakeup interrupts ? But
I don't think that's already in mainline, is it ?

--=20
balbi

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtOqeAAoJEIaOsuA1yqREK+wP/1muJ8ECRhpQD4TKdYENOSop
eBUgezWS5flpM5Jiljr8Sd09ORfeoaRxdp+tzEcwprdhY7jpiKE7nubr6iVuM95l
P0thIHB83smpf7yvsJE2H9rbTHGuPHod4e16Cw8V7OjI5rW21ZPkR6rufJPDBwOM
FS/5Uk+68t5E+AGcF3LnxeVESdoyPYMORKN199vt5hR/YET5OSHxfpc8OEVGt4CA
R6cMIRL8dPWCQpEff3l8OH1BOfOBmjMmBSWBXUYxuo2GkyKCBr0SpfuoI5ekiMzk
Q+9w6ITWGprNLqMKfDvcJWCWAPZnmv0D1HWkpQkOsZu3r4RZWd93O8nk4galPifI
gVt6GswYti48dOGANIIpwaf4arhAzMZ7Z7Z+VOZ6k3eXG0nqeU4ZeBlICfDlY7aE
NllDfLDm3FsBp8TJsLbL/Q3xOC1JqYNVP3Vjl23EeKIWnGcgRpMyBmapMVyRU7P2
lMqqGwrGxHZSLyrSYDvFWPnPtNFT6Zb+bskzeoY5st8aQ1ElXVmNXfw/hcMLnoOU
zE/C0d+wOAyTNI1lICJFlp8s6NCbmAUqh1DRD7JYu8Q6293Ui9edErTP97Nq+m2q
KfanQSx8fwl/FeiH1t9giANmiCEDIOPu7fF/C8pLFbKkj1Lx4LYMv4SS5qmVsSxn
wrH23P8ASNGgJhHPFcAm
=ZkWI
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
