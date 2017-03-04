From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Sun, 5 Mar 2017 00:50:38 +0100
Message-ID: <20170304235038.6oy3hknuys5o6bhc@earth>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170302013707.GK20572@atomide.com>
 <20170302014910.GM20572@atomide.com>
 <20170303110144.seoxa6xwago7q5ir@earth>
 <20170303162824.GW20572@atomide.com>
 <20170304162655.GZ20572@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr6hkj5oxecr4fg7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170304162655.GZ20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--gr6hkj5oxecr4fg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 04, 2017 at 08:26:55AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170303 08:31]:
> > * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170303 03:03]:
> > > On Wed, Mar 01, 2017 at 05:49:11PM -0800, Tony Lindgren wrote:
> > > > Some of the command mode LCD patches could be sent out too, and
> > > > if the timing patch is OK then we can configure the LCD in the dts
> > > > too. Have you had a chance to look at those related to what all I
> > > > broke for n950?
> > >=20
> > > I took your patchset and fixed it for N950. The main problem was,
> > > that you dropped the fifo size update, which is required for OMAP3
> > > (HW bug). Here is a branch based on recent master branch from
> > > torvalds. I had a quick test with droid4 and dmesg still looked fine,
> > > but I did not have the lm3532 patches in that branch and nothing is
> > > visible without display backlight. Can you check if the branch works
> > > for you on D4?
> >=20
> > OK good to hear you figured it out. Yeah I tried to cut down the
> > changes to minimum to get some idea what's going on and noticed I did
> > not need the fifo changes for droid 4. I'll take a look later on today
> > or over the weekend.
>=20
> I tested your branch and those patches work just fine on droid 4.
>=20
> I did not test the fifo patch as it's missing something compiles
> as loadable modules:
>=20
> ERROR: "dispc_ovl_set_fifo_threshold" [drivers/gpu/drm/omapdrm/omapdrm.ko=
] undefined!
> ERROR: "dispc_ovl_compute_fifo_thresholds" [drivers/gpu/drm/omapdrm/omapd=
rm.ko] undefined!
>=20
> Probably just EXPORT_SYMBOL missing?

Yes, I didn't notice, since I test stuff with monolithic kernel.
kbuild test robot already noticed missing EXPORT_SYMBOL before you,
though and I rebased the branch (obviously after you already pulled
it).

> Anyways, yeah I guess that set is pretty much ready to be sent for
> review if you feel like sending it. Or let me know if you want me to
> send it.

Ok. It's just being sent out.

-- Sebastian

--gr6hkj5oxecr4fg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli7UswACgkQ2O7X88g7
+pqo2w/7BdE+qyxbxOwnyUfCaLWBq4YeP0umKHkUHwJj1G+JBDdyPMfIR1uyYR7Q
US3XuFJQqc0fwzlPQhXjS4dm+WS8pdbNrXWPayrmxAfnY6+OF18NCeKlB91RIHYC
1/TMCrmrLFqczuVlV+BVQSvC+79W54ctZz69fxmM9GvoPa0pb+ajgVK5m1Dw4At3
L/xXyZGO72qfZ2EuZ5kAMxaHvy+zAEj+dqGMwa9pKWs+/Z7oW9GlPS+jlMq4j9Zb
FYLeFpR4FFbH6Iumv1ooj1wTWkFQxdwDpn8RJew0eVjBv2IBT0Ehw76cpHyn4ckJ
0kYVqaYxd9zP+wA6kICRaW111b2Qj4+bH8uchHvymTGQpeNrYOzvTmdJJby3Epmn
btNHf2G4bgwhe7SZuB3kES6OoKVKKSzYoMKuHS2fH+0DN0vtLla6JMQpPaJisOdE
/qXanW4K7XtXKCW75jRlEz7O5rSoj2sR3rI3DHeJ1b9brY61D5beEKT1hMXb74N4
9flujJGvXiwcxUIENZnQ4QDTLx9sadN/zTgnC1W7BW7jb/jwyh+LqS1ln4qjTdto
XAB4YJ3yvBxxT9NIL3n4lP2y4+zuzooPUO+LOwhnd28yvv+m47azUHvVwtgskRcg
Q+BgPm8pG/YQz5i2DNY9GnVnuTdM2vXPB4xcDPzCu0uYTpIMZaE=
=zvGj
-----END PGP SIGNATURE-----

--gr6hkj5oxecr4fg7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
