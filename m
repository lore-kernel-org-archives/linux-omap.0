From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.9 to v4.10 regression: oops when USB cable is plugged in.
Date: Fri, 27 Jan 2017 22:55:12 +0100
Message-ID: <20170127215512.GG20571@amd>
References: <20170123222537.GA11543@amd> <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd> <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2647691047167377967=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170124145127.GC7403@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, b-liu@ti.com, linux-usb@vger.kernel.org, abcloriens@gmail.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============2647691047167377967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Can I get the copy of the patch?
> > >=20
> > > http://www.spinics.net/lists/linux-usb/msg152542.html
> > >=20
> > > ...but it is html mangled with no obvious way to unmangle it.
>=20
> Bounced it to you. FYI, patchwork.kernel.org should have it too, the
> "mbox" option there works the best.

Thanks, applied. Problem did not reappear so far.

> > > > I was able to hit that only once so far, do you hit it
> > > > every time with your built-in g_ether .config?
> > >=20
> > > I get it "way too often", like once a day. I don't yet know how to hit
> > > it reliably :-(.
>=20
> OK, well let's hope the patch linked above fixes it. At some point the
> number of musb fixes should just start going down if I'm predicting right=
 :)

Fingers crossed :-).

> Anyways, hitting these issues during late -rc cycle is too late. We
> really should have some n900 usability testing for core features with
> Linux next on at least weekly basis.

Ok, I can try. But so far even -rc1 is a lot of fun. But... I consider
phone calls core feature of a phone. I'd very much like to get that to
work. Unfortunately, that means real-time audio, and a lot of
fun. Plus, as it is touchscreen device, it needs a GUI.=20

> I've noticed that testing with Linux next is way less effort than chasing
> bugs every -rc cycle when it's too late. For about past four months or so
> next has been usable for me with only occasional minor issues that get
> fixed within a day or two.

Well, I am carrying some patches... but maybe mainline is now good
enough to be useable without them?

No promises. I really should find more time for N900
development. Hmm. Or more developers. Where are all those Eudyptula
Challenge people when you need them?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLwcAACgkQMOfwapXb+vLlzACeMVqTYVFr1USeJDrJ6aJxQL6i
+mAAnRuJG6REn/XWLmsWFoC8y6l3RcIx
=4Xrj
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--


--===============2647691047167377967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2647691047167377967==--
