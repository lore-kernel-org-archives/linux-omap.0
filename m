From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/5] Add support for Fujitsu USB host controller
Date: Thu, 29 Jan 2015 10:23:12 -0600
Message-ID: <20150129162312.GH21217@saruman.tx.rr.com>
References: <1422173608-24355-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <20150127152250.GB13776@saruman.tx.rr.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150127152250.GB13776-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sneeker Yeh <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 09:22:50AM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Sun, Jan 25, 2015 at 04:13:23PM +0800, Sneeker Yeh wrote:
> > These patches add support for XHCI compliant Host controller found
> > on Fujitsu Socs, and are based on http://lwn.net/Articles/629162/
> > The first patch is to add Fujitsu glue layer of Synopsis DesignWare USB=
3 driver
> > and last four patch is about quirk implementation of errata in Synopsis
> > DesignWare USB3 IP.
> >=20
> > Patch 1 introduces a quirk with device disconnection management necessa=
ry
> > Synopsys Designware USB3 IP with versions < 3.00a and hardware configur=
ation
> > DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1. It solves a problem where withou=
t the
> > quirk, that host controller will die after a usb device is disconnected=
 from
> > port of root hub.
> >=20
> > Patch 2 is to set Synopsis quirk in xhci platform driver based on xhci =
platform
> > data.
> >=20
> > Patch 3 is to add a revison number 2.90a and 3.00a of Synopsis DesignWa=
re USB3
> > IP core driver.
> >=20
> > Patch 4 introduces using a quirk based on a errata of Synopsis
> > DesignWare USB3 IP which is versions < 3.00a and has hardware configura=
tion
> > DWC_USB3_SUSPEND_ON_DISCONNECT_EN=3D1, which cannot be read from softwa=
re. As a
> > result this quirk has to be enabled via platform data or device tree.
> >=20
> > Patch 5 introduces Fujitsu Specific Glue layer in Synopsis DesignWare U=
SB3 IP
> > driver.=20
> >=20
>=20
> Mathias, let me know how you want to handle this. Either I take them
> all, or you take them all. What do you prefer ?

Mathias ?

--=20
balbi

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyl5wAAoJEIaOsuA1yqREwxMP/1+9wLz81eUXf8hLOeHLtdMm
j9a7Q4XuqNgldltRDnwTU0qWWF2uVGjGkv4Ng14DmGp4yPHV8uwOVHjGW9jJKJfU
7Rfq2YRZ2tKV6dXs+idKYpEWCgcmuXaEsq7WEekcJevJe2u8210CP4SesJ/WuWdh
9zGgz72XKstgDOXRCNnMKm4sMKn3N9mIidkiZLdFR8Kx0ILdKGd/DO2zVr77C0S1
9AVgO7oqRfgbos64FWCjNZ9Nrh22nCg7kkT0O0T0OC2AhfQlFWARR0g98UVJQALr
36OR6nw8wA4jfezdC5sAaQgGULLDQcRLmRa1ddYgLfsBp3HTGJaP+t0TokFZdwQ3
JHDvc4eBhLRNsIRQgFxq8VEcmJ5f3DMGeeCre50ribnRhjeyO/LtKMR0cqwVOQpJ
teoJY8yZQ/Nz4N6TctyhQ5Fa8//e5XEnY8xw2y/EU2iWziOwoulhQ3qnxCVkyeeb
5zb2ipyuhhnQMd+w/XH4Kl3XETvdRTaVJbe4nx2Oim1r0ztCwZ5yQnY+uYvclbOn
6Dblp6ZkCsHV5kUk+uy44AyIkLAuaHBLZK8HRp9grQw8LWyh3RSx3XcONE7O6dHy
kEjdWxwtMkOP/lBMsSy87rPJl3YDWzbi3j+ZjmntZv7Blj+sAabigPprNc5ralh+
p6YODD00932MyBod7WBI
=Ls/r
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
