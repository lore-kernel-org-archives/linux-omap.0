From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] media: omap3isp: fix unbalanced dma_iommu_mapping
Date: Thu, 15 Mar 2018 11:52:00 +0100
Message-ID: <20180315105200.GA27057@amd>
References: <20180314154136.16468-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0079132683811893677=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180314154136.16468-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Lindgren <tony@atomide.com>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0079132683811893677==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-03-14 10:41:36, Suman Anna wrote:
> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> ARM DMA backend. The current code creates a dma_iommu_mapping and
> attaches this to the ISP device, but never detaches the mapping in
> either the probe failure paths or the driver remove path resulting
> in an unbalanced mapping refcount and a memory leak. Fix this properly.
>=20
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> v2 Changes:
>  - Dropped the error_attach label, and returned directly from the
>    first error path (comments from Sakari)
>  - Added Sakari's Acked-by
> v1: https://patchwork.kernel.org/patch/10276759/
>=20
> Pavel,
> I dropped your Tested-by from v2 since I modified the patch, can you
> recheck the new patch again? Thanks.

I updated to new -next version and re-ran the test.

Tested-by: Pavel Machek <pavel@ucw.cz>
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqqUFAACgkQMOfwapXb+vKlrwCeKHhgwusf0xhYT9HB1cZ5aNCb
L0UAnRm2HvW0qtnYBT+v2dPNM1obgJS5
=9aI2
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


--===============0079132683811893677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0079132683811893677==--
