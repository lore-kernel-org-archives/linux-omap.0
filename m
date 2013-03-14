From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/6] mfd: omap-usb-host: Actually update hostconfig
Date: Thu, 14 Mar 2013 16:03:24 +0200
Message-ID: <20130314140324.GG26080@arwen.pp.htv.fi>
References: <1363083940-20050-1-git-send-email-rogerq@ti.com>
 <1363083940-20050-4-git-send-email-rogerq@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8255260550632455854=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363083940-20050-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============8255260550632455854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline

--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 12:25:37PM +0200, Roger Quadros wrote:
> The helper functions omap_usbhs_rev1_hostconfig()
> and omap_usbhs_rev2_hostconfig() don't write into
> the hostconfig register. Make sure that we write
> the return value into the hostconfig register.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

makes sense :-)

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQdisAAoJEIaOsuA1yqREZywP/jBK6J4O1fM75PGTPvrgENvr
OrSFM/YWc+pD/drAA1JavyCFTf5rxMP7lOSlynTE9qctXy9fyMbhvfnrGUo+FZmH
ei6ihNPTRYenSO5ugtc2ml9JT7GIToFH47Qi/ch2jst8wrCx9v0JmHJzk4/DhcwY
X2sLRT6Wl+M+EMDZAyTWuPwSiW0lcM1rLe9oXUbpgiVg1PMQRItJ+1DUGKjl2Gn/
AAacInWPJJwrZsTrnMSY+u+IFpHkQGMNuMNh0gpfrbvDnb2mXpZ30CiD5+2k37PP
neq3wQxruKc4ZhvCQ1BwF+AeHqop0Mx1RYr4/S8hyViWnaF2uOtAcvapB/aOdh54
bGqbtb2IAE/w0iaVx/ydWqrCmrO+C8dodtligviEd+ZkZn8VdT1aG8hBr4bfB81/
pwz/1xy7camkJdqlqO7M1So6zyexdtkb6NT5QHEKeE4nVsQp6mD5MoxrejhmovOA
hbb5ChEso7VPpvxoHR/YivjqAHzttcF3859h7Vg2V1uWUxfYjwBa0MVo+bMO1VFD
1w5RywWP3bV1+/WiuVvJk0xiqRM8vIxwwLh7Kki3WZFN1lWdjd8VcaXVvnAzAXje
Syyi+cm7yWibNduNNCANEgfHyy7kr8jfe2mq2rSF/HSi6L+tMQhEsXtBtDSeoCeI
6h1bSWi62twLm1TxW4V2
=uCzX
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--

--===============8255260550632455854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8255260550632455854==--
