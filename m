From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] input: keypad: lm8323: convert to threaded IRQ
Date: Mon, 20 Jun 2011 11:26:07 +0300
Message-ID: <20110620082605.GE14262@legolas.emea.dhcp.ti.com>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
 <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
 <20110619195604.GC14262@legolas.emea.dhcp.ti.com>
 <694a51cff83de55276b804b23668447e@doppler.thel33t.co.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <694a51cff83de55276b804b23668447e@doppler.thel33t.co.uk>
Sender: linux-input-owner@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: balbi@ti.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 19, 2011 at 11:01:43PM +0100, Leigh Brown wrote:
> On Sun, 19 Jun 2011 22:56:06 +0300, Felipe Balbi wrote:
> >Hi,
> >
> >On Sun, Jun 19, 2011 at 07:00:13PM +0000, Leigh Brown wrote:
> >>Many thanks for trying to assist me with my problem. To recap,
> >
> >yeah, no problem ;-)
> >
> >>I'm seeing the keypad lock-up on my N810 using this driver,
> >>when I type quickly.
> >>
> >>I tried your patch, and it doesn't fix the issue.  However, I've
> >>read the datasheet for the lm8323 and it looks to me like the
> >>interrupt should be level rather than edge triggered.
> >>
> >>The following additional patch makes things work for me.  I
> >>couldn't tell you if it's the correct thing to do but I can no
> >>longer cause the keypad to lock-up by typing too fast.
> >
> >good good. Looks like IRQF_ONESHOT is what did the trick.
> >
> >Did you check if IRQF_ONESHOT alone was enough ?
>=20
> I tried that first, but it didn't fix it, although it makes it a
> little bit harder to trigger.  I've just tried again to be sure,
> but I got a lock-up quite easily.

Ok, cool thanks... Can you send your patch as a proper patch (with your
Signed-off-by line and everything) saying that it fixes the lock up ?

My patch converts to threaded IRQ and yours fixes the triggering ;-)

--=20
balbi

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN/wQdAAoJEAv8Txj19kN1MfwIAILFk9BX7hfPeqKNMzrzPUwa
J7yB/yn6G97ua/dT9oPPfkPELDRKtmrdTatxlecckZ02k4XwpPPKLsLXjn57L8Ii
O/OzUN1sKpfqe+LQ4G51I8wSEhH6RSN7RVPpobWJ1HyVMYoDNxs/xUlXjpW6wTs3
s58R3fGfgLc7kqGn1kzrJoakh2kqYD+VAV+tisFU3YnM/5t6+dF7KHt5VVwZ5wx2
szgLDIZs6mGLeoHW4kVkgBOckhhmyDFE3cK/Db5d6EqU/4G0iZP1ooxX8RV73yGv
msJq2YAEk9yu2iVoXQ1Q19grBpOKGlug8FY3WBwhP5HovorEyAXDxtCE3N0cMjU=
=6YMs
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
