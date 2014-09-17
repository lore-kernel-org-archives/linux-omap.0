From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/2] Documentation: devicetree: mfd: twl4030-power:
 Use the standard 'ti,system-power-controller' to mark power control
Date: Wed, 17 Sep 2014 18:55:30 +0200
Message-ID: <20140917165529.GA24699@earth.universe>
References: <1410957252-764-1-git-send-email-nm@ti.com>
 <1410957252-764-2-git-send-email-nm@ti.com>
 <20140917154400.GE30918@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140917154400.GE30918@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2014 at 08:44:00AM -0700, Lee Jones wrote:
> On Wed, 17 Sep 2014, Nishanth Menon wrote:
> > ti,system-power-controller is more or less the standard way of
> > indicating that the PMIC is the system wide power controller and hence
> > may be used to switch off the system. Almost ALL TI PMIC drivers and
> > many Maxim PMIC drivers follow the same style.
> >=20
> > So support 'ti,system-power-controller' in addition to the usual
> > 'ti,use_poweroff' to indicate that the PMIC instance has control for
> > switching off the system.
> >=20
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > ---
> >=20
> > V2: picked up documentation suggestion from Sebastien
>=20
> It would be good to get Sebastian's Ack.

Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

[...]

> > +- ti,system-power-controller: This indicates that TWL4030 is the
> > +  power supply master of the system. With this flag, the chip will
> > +  initiates an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
> > +  system poweroffs.

One minor thing: While the documentation is updated you may want to
fix the typo "will initiates" to "will initiate" (or just drop the
"will").

-- Sebastian

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUGb0BAAoJENju1/PIO/qarXYP/3COxHZgxiuoxt2x4BPugsOA
gyuR3HWunXDARYAnhjIKIBvUKqFxbPzai2qdR6dinNu9q704mYtwcBL5WP+xZtbK
zl/d4GVQ5QOQG7GUQ1s5E/YPoAXEA6TbgWnurrzdzRQOyROLyBlj87DTS4AryFf6
8OFOvZr8HdQJOTwY2VsrtxLYI8tFJAwnfXlAZofcmlXUYxEwlnXql2wt+mdn1DcU
/tnLHlCcsgOoJXwLEGcbbYVxoxfPb10vb2+pBy40K22HCT+KYv3GAh4iiv6iS1M7
qAA16HXp06FyfPnAIwuqvD77M8eL9ItVCp8acT7+DiHVV4EkM+D2njOcV3kgp+fP
40pFs4AS+obHAJUQc5sJ5s4FNH2raQiRpjgim8i8V2yJ+rehqeLZm2Dyh/45dQJ8
CnV8BBqvTYLQV4OQ8VVNSqtj1jpA4YrpNvYrqfXGd5ovZU6ZAE7rZhWnfuNgX3XX
CNmTnmhG+VO51uCEA3LpVjIVXlNvSUjbVExs7GjsNFVVchMdPjwji9JAlCBSH/yk
L9x2BQRZgNgQbO2oMkLZo9Fat5AkW9t8q/yO7zmxq5tXiyxsWMFBAxFJHBNq772E
edjvelZpXgQ2e8xty2HT3/FfKpNgz1Y0yWwM/aKOwVWbzcV84q0enlnO89QvhscT
5jfaY2E7epONARknfmJk
=/DFi
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
