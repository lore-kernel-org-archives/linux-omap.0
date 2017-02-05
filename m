From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: v4.9 to v4.10 regression: oops when USB cable is plugged in.
Date: Sun, 5 Feb 2017 22:44:13 +0100
Message-ID: <20170205214413.GA7573@amd>
References: <20170123222537.GA11543@amd>
 <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd>
 <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com>
 <20170127215512.GG20571@amd>
 <20170127234832.cte4ki4ajwme2b2j@earth>
 <20170203075907.GA21338@amd>
 <20170203163048.GA3721@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170203163048.GA3721-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-02-03 08:30:48, Tony Lindgren wrote:
> * Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> [170203 00:00]:
> > Hi!
> >=20
> > > On Fri, Jan 27, 2017 at 10:55:12PM +0100, Pavel Machek wrote:
> > > > Ok, I can try. But so far even -rc1 is a lot of fun. But... I consi=
der
> > > > phone calls core feature of a phone. I'd very much like to get that=
 to
> > > > work. Unfortunately, that means real-time audio, and a lot of
> > > > fun. Plus, as it is touchscreen device, it needs a GUI.=20
> > >=20
> > > Talking about testing - kernelci's n900 is broken?
> > >=20
> > > https://kernelci.org/boot/omap3-n900/
> >=20
> > The N900 regressions are now more of "audio mixers no longer work"
> > than "it fails to boot" kind -- thus difficult to test automatically,
> > I'm afraid.
>=20
> Talking about audio testing, next now has commit 9834ffd1ecc3
> ("ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent glitches"),
> care to check if that also fixes the n900 audio glitch issues you
> reported earlier?

Yes, audio was choppy when I tried to use n900 as an mp3
player. Hmm. I re-checked v4.9, and it seems to work ok now. I'll
speak up if it re-appears.

Thanks,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliXnK0ACgkQMOfwapXb+vKT5gCfbc1t6/5TS6s9gLyqIkiz1ato
XZUAn060bJ5vKXmjBU6vz+7Aoo7Qb1Lz
=20nv
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
