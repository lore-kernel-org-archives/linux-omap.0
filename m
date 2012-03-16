From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Fri, 16 Mar 2012 13:03:45 +0200
Message-ID: <1331895825.1653.15.camel@lappy>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	<1331728737.2386.76.camel@deskari>
	<CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
	<1331730465.1542.8.camel@lappy>
	<CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
	<1331732624.1542.32.camel@lappy>
	<CAF6AEGsCpz4zXCSXhP5qA7hL4Xac9+c03rS1PZejhUog_+SHkg@mail.gmail.com>
	<1331801177.2768.8.camel@deskari>
	<CAF6AEGtC9BA-8WZGNOs_rMFrzt88XPNjVRUooG7-Nxe7yDKjpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0820337180=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAF6AEGtC9BA-8WZGNOs_rMFrzt88XPNjVRUooG7-Nxe7yDKjpA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org
List-Id: linux-omap@vger.kernel.org


--===============0820337180==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Maqtc/dw+meYZgxGKgUk"


--=-Maqtc/dw+meYZgxGKgUk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-15 at 07:32 -0500, Rob Clark wrote:
> On Thu, Mar 15, 2012 at 3:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Wed, 2012-03-14 at 10:06 -0500, Rob Clark wrote:
> >
> >> > Well, as I said, it's not an issue for me and from my side it can be
> >> > improved later.
> >>
> >> yeah, when CMA is actually merged, there are a few other things I'd
> >> like to do to, incl converting omapfb over to use CMA and remove
> >> omap_vram.. but I guess those will be other patches.
> >
> > Right, I just realized CMA is not in the kernel, nor does it seem to be
> > in the linux-next. Is there a reason why you want it already merged?
> > Wouldn't it be easier to get it in only when it can actually be used.
> > Especially if there's room for improvement.
>=20
> Some folks are already pulling CMA into product kernels for various
> reasons.. keeping this w/ #ifdef CONFIG_CMA guards seemed like it
> would make their life a bit easier.
>=20
> But if people feel strongly about it, I can strip that out.

Well, I wouldn't say "feel strongly", but... I think the mainline kernel
should have code only for the mainline kernel, not for some custom
kernels. And the code is not testable in any way, not even compilable. I
think all code going in should be tested and compiled. Also, if the CMA
code is not in, who says it won't change. Perhaps the CMA function won't
even exist in the version going into mainline.

 Tomi


--=-Maqtc/dw+meYZgxGKgUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPYx4RAAoJEPo9qoy8lh71GZ0QAKOqSKG/8fe0rHr8Ol2HKdWB
XYwdNsSnSIpfmjYY00LE4aYKpcT4G147h1uy7pi3OXK0fsI+EMH2FOoulohjDrFV
BCif4Dno87EL9TpqqMgpuuS3tFo45Xhejdt2wB9h8c1O6Wn9k2u5uFEDwdv9QSm+
+m3MdkkkZ+JWqSKbG1jmw9UJ8QK3JfeKiUIk7CkoLnl/MYrR90yEXSKA1sYNEPdX
99o6PxtTaRg938GDx/6ZZTSHVkHyIY2Xzp69g2Fw56dke13nhmdyYL1GrUegNtEy
g3J+fZe993sWrGjrVRFr85p2JvsifTAuB3vZBOqWu5LPVeOLY8UqpJ9as92mG97P
EopvNIziqZffENFhEe40BUabGyc7UCbiIY3o3mU1RX7fSfp9MXYwtJa2XLPwwC7/
uBKzZeM8pxydC8nrDUPt9sD3Wh/rDDZCPuqEI+HNDJtMz1/zxutqN6mgjJ5fW9/V
pq+3PFDMSRLEt1Dmdu6MrarsrJ4a47ZZBURB4iO3AswYs7kU1pRIqjt9mocXGT9F
vquVr8dj0jjZ/SitX0NLp74VAr8totiAPRCdGi90ckerRTyC7PAI3x8oqBE+GfrU
5vapSRZvII3gzjhIcx1GM9kidmjkLgA0ejKl4O5godVQXqMVjEGKnBIbClP3tN3s
6Q9QbCaRqJ8kxamYX2A3
=Ml5x
-----END PGP SIGNATURE-----

--=-Maqtc/dw+meYZgxGKgUk--


--===============0820337180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0820337180==--
