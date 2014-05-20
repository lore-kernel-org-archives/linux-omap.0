From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 20 May 2014 06:57:49 +0200
Message-ID: <20140520045748.GA28812@earth.universe>
References: <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com>
 <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com>
 <537A540E.8070302@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <537A540E.8070302-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 19, 2014 at 09:57:18PM +0300, Tomi Valkeinen wrote:
> > 3. Having to maintain a database in kernel of display mappings separate=
ly
> >    in addition to the .dts files.
>=20
> Yes, that's slightly annoying. Not really a big burden, though, as it's
> quite rare to get a new encoder or panel driver.

I wonder if the "omapdss," prefix could be added to *all* remote
endpoints seen by omapdss. Pseudocode:

for each port in dss {
    for each endpoint in port {
        panel =3D get_phandle(endpoint, "remote-endpoint");

        /* only add prefix if it's not already there (kexec) */
        if (panel.compatible !=3D "omapdss,.*")
            panel.compatible =3D "omapdss," + panel.compatible;
    }
}

-- Sebastian

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTeuDMAAoJENju1/PIO/qaa90P/jWbyjy8ne+1LaxDrjVzww9Y
bLdyw0T0BD643YSAq/0OC/akNUVeANZyEqsTME+eE8gW9X8Q1jaDoTYCFRRCgMsG
vBXv3l0IAl3m97uxZEnriBqgOva4GxgZ+aRil0fjB+yq6mok+OqULRi92Gj5mfmm
0u1L5uOdv3fAJmW6UK6XepTJgW+tv5hxYKP/MznaVxQ/SlXweTf5jf2oPHBFjlg6
j4GaeJN30AH87J9xNFlrSzihvSUY73oT1mG1f7yrdLShVU6rkp3sVeDfLs9Tf/rn
8mw/FYh0JnJO0jqdw1OWPOGimSLE0zKIS1JZWF8Rb6K5lMijlkEctjKobu8aHKAc
R/dfe4wFCKzzcjRx1ar/cCYPcca740It+cJ9O1Gr+Jy5hhVRX44MqDKA9sSRuNG8
SDzQztmbsj7YWze87YrWLLU42E8dJHtusESYgSMkI5Ww0x1jo9aImLTe0vizt1Dg
RUIJlAiAG06o2lwGdmo40wZ63d+91ldxPC8m2hZE5WnwH42dYIQiK7K5OloFJTOU
P2lHVLEVeZ3weIdBZW2qCVsLDcOhFnK8ePqYpXQfzYx+Roh/f1d9P30qb6GS7cTk
txLFq1tqJzAiS5dfoC3aAVkKvM9iMFqbQwtNVW+mmd2CbKCqh6PJOsOU7Z933AbG
gJrX0Mw8OleUAWUnGqNm
=mWXY
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
