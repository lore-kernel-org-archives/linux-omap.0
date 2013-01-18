From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/6] usb: otg: Add an API to bind the USB controller
 and PHY
Date: Fri, 18 Jan 2013 13:48:43 +0200
Message-ID: <20130118114843.GB4379@arwen.pp.htv.fi>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-2-git-send-email-kishon@ti.com>
 <50F7C643.600@ti.com> <50F7DD2C.90500@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5247437509214908447=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50F7DD2C.90500-l0cyMroinI0@public.gmane.org>
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
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5247437509214908447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2013 at 04:44:52PM +0530, kishon wrote:
> >>@@ -171,6 +188,11 @@ static inline void devm_usb_put_phy(struct device =
*dev, struct usb_phy *x)
> >>  {
> >>  }
> >>
> >>+static inline struct usb_phy_bind *usb_bind_phy(const char *dev_name, =
u8 index,
> >>+				const char *phy_dev_name)
> >>+{
> >>+	return NULL;
> >>+}
> >>  #endif
> >>
> >>  static inline int
> >>
> >
> >Controllers like ehci-omap which don't need OTG functionality would
> >benefit from this API. Can we make these PHY APIs not dependent on OTG /
> >OTG_UTILS?
>=20
> Actually much of whatever is in otg.c can be used by controllers
> which don't have OTG functionality (except otg_state_string). I
> vaguely remember, there was a patch that renamed otg.c to phy.c etc..
> I'm not sure what happened to that.

right, that has to be done eventually ;-)

--=20
balbi

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ+TabAAoJEIaOsuA1yqREgncP/1NggeNZzkZbEl1pkZ1sB1a+
qA0bmIbEoEOUJxpCqdLwUsyg9FEnq46mThtN6zXEvxpwEFIwo0OE/Wncxow2xZZu
H8X5tr3lVO6ytFqLEjdiGh2QLdJaQZmBEi7s1/C/gGZVtcsr3ew9EGcHXILst1wa
SPn3GN4r9ywX5pEzzGjaG4Y1OPinFDFcyRhce1hw7qLfrPrcF4vUGtreFF/ZVu1r
JiqDegt28enVMJOa1AcMmojy5oF41FT4sOTVe4pfG8HQ7dbh/jv12MLdzgFjr7sI
KwaT1j3wEFq6Wt/TlvmV4FXPmQM0E+UKQuVluP/450Bu/vqP637Qg5jfpbQJ+SBm
o33oxFhQ0wBa89Fer8PRFCPlbSEz1KDlxpZ8h9iXBvgf95yeI1wC8FwlgR6DrC1+
S7MFYSnXPbMARyT3SQysgWmYTYNUiIlSTdI1+VsNcd3hg0oc+27kCnXH3s5Mggwn
DVKjVUnGCgXoqe3pxBOlHG4roSyVRABg62tOPEcfqYzzOZ+5rtUx8rMeGeM71dit
mRNmQABiyP9kNgP8wKjonX025bjQkGpHSECEjZv3edKcgTWB6/Et6WuXPqJbesqT
k2nbuiotOLb3Xl8ktDntPnxJHlZaY3RS1bYBjaIBSC/3RJig0QGrJvkMEZwrdQcE
pgbna7YCHExTNw2BA0ez
=+ptv
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

--===============5247437509214908447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5247437509214908447==--
