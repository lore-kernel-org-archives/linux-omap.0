From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/5] power_supply: tps65217-charger: Add support for
 IRQs
Date: Mon, 15 Aug 2016 21:26:03 +0200
Message-ID: <20160815192602.cpibysrzshm5tr7q@earth>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-4-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mj3hw3cm4t2vfm45"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160620105056.25843-4-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--mj3hw3cm4t2vfm45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 20, 2016 at 12:50:54PM +0200, Marcin Niestroj wrote:
> Make use of IRQ resources defined in tps65217 mfd code. If they are valid
> we use them instead separate poll task, in order to define AC power state.

Thanks, queued into power-supply's -next branch.

-- Sebastian

--mj3hw3cm4t2vfm45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXshdHAAoJENju1/PIO/qaRLsQAJLqeAiiZGgAiWGL/kn0lZlM
FwHfBwcXDIYFOtnJexiTkIgzseDau2/xr1MrSkQ/6Qusgx1Kb7EgBHc6qhDkcyHT
Q7mr8atoX05hM9R2XyNIOjdyhVIpVnbYpAF9DHaTftcwTntnfpkzIcxB5YIoEGo7
vKvejtZ+lxEwdONoDSj7REQppfk1dKVLQlLhxbbVmxc+od5DM0T1EDg7nEqu1D76
e+XEftu9bCMLIJGfDOOK+2G1v5Owh9NkW4vdp8Fh75b3I5w/sqU5cK3gPg+6CjSu
rU8knmJ4/bL94fXlRDAV2wUiVZGOx22/QkIgOdZmd8ZcbkDkLZDdczYuXKhB/gBO
apk+jD9zwmYrGI11cfTh5PsK+JIiaLG1FwlC1kqewi7PeH8ZOSDvtHu8tc4p5AH4
mms3sfYl4s7KZbXDRbZlhiALPoZbxLNP97dRTGslcLzAhYKjAs0bC/AZE9tv1Jhb
jxgP4IM6P2UhrRuSmQ6I5zividazNK6t/rybyymNs9MPnFQg2zMpGhh68by1GDTp
fR0cuMomcvcCTdp08poOl90iM/Xwtj/i/Z0HA4P0KEJrgFylKMdpcRuIH0oj86JE
WvD4iMcXdnae+SXAv948Ytw4pjKoImFPf6V5P+TVfqT1tjQnQOztnw0hGmUSl6Ga
b3iLBjB9BPIRocO0unHu
=bZw1
-----END PGP SIGNATURE-----

--mj3hw3cm4t2vfm45--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
