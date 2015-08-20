From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
Date: Thu, 20 Aug 2015 11:48:08 -0500
Message-ID: <20150820164808.GB4938@saruman.tx.rr.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com>
 <55D6001E.3000504@hackerion.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3689062561301475997=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <55D6001E.3000504@hackerion.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Baldyga <r.baldyga@hackerion.com>
Cc: nicolas.ferre@atmel.com, robert.jarzmik@free.fr, m.szyprowski@samsung.com, devel@driverdev.osuosl.org, cernekee@gmail.com, michal.simek@xilinx.com, stern@rowland.harvard.edu, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, leoli@freescale.com, johnyoun@synopsys.com, Robert Baldyga <r.baldyga@samsung.com>, linux-geode@lists.infradead.org, haojian.zhuang@gmail.com, andrzej.p@samsung.com, linux-omap@vger.kernel.org, petr.cvek@tul.cz, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

--===============3689062561301475997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 06:28:14PM +0200, Robert Baldyga wrote:
> Hi Felipe,
>=20
> On 08/20/2015 05:35 PM, Felipe Balbi wrote:
> [...]
> >just letting you know that this regresses all gadget drivers making them
> >try to disable previously disabled endpoints and enable previously
> >enabled endpoints.
> >
> >I have a possible fix (see below) but then it shows a problem on the
> >host side when using with g_zero (see further below):
> >
> >commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
> >Author: Felipe Balbi <balbi@ti.com>
> >Date:   Wed Aug 19 18:05:27 2015 -0500
> >
> >     usb: gadget: fix ep->claimed lifetime
> >
> >     In order to fix a regression introduced by commit
> >     cc476b42a39d ("usb: gadget: encapsulate endpoint
> >     claiming mechanism") we have to introduce a simple
> >     helper to check if a particular is enabled or not.
> >
> >     After that, we need to move ep->claimed lifetime to
> >     usb_ep_enable() and usb_ep_disable() since those
> >     are the only functions which actually enable and
> >     disable endpoints.
> >
> >     A follow-up patch will come to drop all driver_data
> >     checks from function drivers, since those are, now,
> >     pointless.
> >
> >     Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
> >     	claiming mechanism")
> >     Cc: Robert Baldyga <r.baldyga@samsung.com>
> >     Signed-off-by: Felipe Balbi <balbi@ti.com>
> >
> >diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epauto=
conf.c
> >index 978435a51038..ad45070cd76f 100644
> >--- a/drivers/usb/gadget/epautoconf.c
> >+++ b/drivers/usb/gadget/epautoconf.c
> >@@ -126,7 +126,6 @@ found_ep:
> >  	ep->address =3D desc->bEndpointAddress;
> >  	ep->desc =3D NULL;
> >  	ep->comp_desc =3D NULL;
> >-	ep->claimed =3D true;
>=20
> Removing this line causes autoconfig can return the same endpoint many
> times. This probably causes problems with g_zero.
>=20
> I will try to fix it ASAP.

I was considering the same thing, but the lifetime of ->claimed doesn't
look correct to me either way. Note that once the flag is enabled, it
won't get disabled by most gadget drivers.

--=20
balbi

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1gTIAAoJEIaOsuA1yqRENRwP/jERHLHSy7zsmYb4oXiOzOTo
8huA+a2zJr0L7/wm9cZXmnDgIx96735HJfwhUoC9beeD9kqpzcWeI66l9DdGCX4G
Khr7d2kPAQXBrpKLfpj2hNtyt7TYLQELstqKZt/wgGNJVFjFHBhkfD79itxG1Dr+
3MGNjMNSSN/whOk7ara27zkRDiy21/Vz5gliV9Oujq2OxXmDuTIe56sqvYUPvwug
nNglT5RlvQU8RKqi0A7/O28POvoq83u/weSZIY9BSKzoKv/7+fYrKEsnEEUhJBXE
ue6KSGoNknPTbRouP0bT/1FsaYD4jO9TmpOwhFfAOmG5FACX/Vy2Xhp7RJL8/Mi/
S/fZ97Lfe6Flm+ZTZqXV+aojYTWu9htf13aJ4dzwAsahVt/DmYFFVaDZyMWtgvjv
9CZ9d8rbNvSmrLPBQ1X6cibvWdYZuS5TKLAoCuZ3l81IPM9HR1xi9zbaJoYVFdim
vb6dxOLHPbHazljaj0JDQLnNpruAaIPFtnmtbgNYHT7AQfEkIAtLAlsJO3H/CuyY
SyNU+tmWi2AjWdlHFoXWro4T5G8oKKPSuhNBwXp0sfV/Ww057HNJDCuVUvIxthz2
2wnUCJb4df9nsgGsBJ1etyhK64sdHRCAZLdYFn4gnq7CYdTgavQml7BEWaSwrlIn
Z36D8OE5hXT8tOh0fY9t
=m2Em
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

--===============3689062561301475997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3689062561301475997==--
