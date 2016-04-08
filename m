From: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Subject: Re: [PATCH v1] regulator: twl: Provide of_map_mode for twl4030
Date: Fri, 8 Apr 2016 18:08:29 +0200
Message-ID: <20160408160828.GA10562@earth>
References: <20160404222638.GM2350@sirena.org.uk>
 <1459835974-31664-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160407175745.GK32257@rob-hp-laptop>
 <20160408154907.GT16484@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160408154907.GT16484-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, Apr 08, 2016 at 08:49:07AM -0700, Tony Lindgren wrote:
> * Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160407 10:58]:
> > On Tue, Apr 05, 2016 at 08:59:34AM +0300, Ivaylo Dimitrov wrote:
> > > of_map_mode is needed so to be possible to set initial regulators mod=
e from
> > > the board DTS. Otherwise, for DT boot, regulators are left in their d=
efault
> > > state after reset/reboot. Document device specific modes as well.
> > >=20
> > > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  .../bindings/regulator/twl-regulator.txt           |  6 ++++++
> >=20
> > Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>=20
> I'd like to test these patches, but I don't know which combination
> of patches needed? It seems we're waiting for an update on at least
> one of the patches in this series?
>=20
> Might be best to repost the whole series so people can test the
> right patches.

As far as I can see Mark has already queued all patches in his
for-next branch and they are already in today's linux-next, so
you can just test linux-next.

-- Sebastian

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXB9d6AAoJENju1/PIO/qaYMkP/iGxNl3b7gtUKcA4CVpI4YW8
1Smjo1EM1kmSKWYkHxpKuKFkIX0+DGLTmpFOewVfJDAu54oeUXxfgr7cZ+BP3HLY
9kMlF8bdC0L7Tq2uv4sq4fv42M1fDFJxhdaoT+Pe/iu74n3Oo9p2wreBuRdAjW5o
ojYqIx/rS6MVR5652F2TPopQKs6/2omd3Oq//0HiVvV2EciOIdoXAB/szEL3QkBX
JizZJF7py5SgjDyCBkk9dbocy9BwkC94A3D/27Bn9PqbheENd62s7WpGi/FlQkrm
UX4GyVggcz+i6HUOB2stJ+Y/XTGnfMZzCXhMCk516SODkOIf8ir+hKNRGRacYsxX
/hnxqnRfihfMcD2UkxjnjOtTTezgC7aMm+63ZaiQpRaQNRYIL1fiTgKsBQwNucob
VGeqdJOE8wuD1dRqOIEtiJH8+mSDs7M+mj8FUGnEhWHof7jpLoPVAOTqacmM8YMc
V6GvBPQZEZnEQAofD3SDkWfQzOKS0ni5J6AgohGEPazGkCjZx6/7l6VnvfLRvmAw
0YdgMax5xbQUsPvWfj+DKcIhr8NvwLQzJ7Z9s0bAFbgxAHmzAUDg3aDy7F7mWEsB
uGZslooT7oyNOGUu4mG1IzBdD0dWeiC/KCNxtCXJEDDp0s5j/GJItAQlwtURHF+Y
Thqi0Xz4FxSfKZ7+HQpt
=jtym
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
