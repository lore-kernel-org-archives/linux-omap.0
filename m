From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] irqchip: omap-intc: improve IRQ handler
Date: Mon, 20 Jul 2015 11:44:08 -0500
Message-ID: <20150720164408.GB31951@saruman.tx.rr.com>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150119213458.GK18552@atomide.com>
 <20150715064923.GA17550@atomide.com>
 <alpine.DEB.2.11.1507151435480.18576@nanos>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4646255388095684781=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.11.1507151435480.18576@nanos>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============4646255388095684781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2015 at 02:36:54PM +0200, Thomas Gleixner wrote:
> On Wed, 15 Jul 2015, Tony Lindgren wrote:
> > Felipe,
> >=20
> > * Tony Lindgren <tony@atomide.com> [150119 13:41]:
> > > * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > > > as it turns out the current IRQ number will
> > > > *always* be available from SIR register which
> > > > renders the reads of PENDING registers as plain
> > > > unnecessary overhead.
> > > >=20
> > > > In order to catch any situation where SIR reads
> > > > as zero, we're adding a WARN() to turn it into
> > > > a very verbose error and users actually report
> > > > it.
> > > >=20
> > > > With this patch average running time of
> > > > omap_intc_handle_irq() reduced from about 28.5us
> > > > to 19.8us as measured by the kernel function
> > > > profiler.
> > > >=20
> > > > Tested with BeagleBoneBlack Rev A5C.
> > > >=20
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > >=20
> > > Jason, looks like this is not showing up in Linux next. The
> > > same for the changes I did for dm81xx.
> >=20
> > Can you please resend this to Jason? Looks like this
> > is still not merged.
>=20
> Please send it to me asap and please cc lkml on irqchip patches.

building and testing again. Will resend shortly

--=20
balbi

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrSVXAAoJEIaOsuA1yqREKHAQALRBTyQcTkcrDvZ8MClpU76/
TkiIjbDYHzE5HTZPRWa4zqRV8FH0tEglEUvO5Ex+J36Y0Cl+zxSKwEul3D6E/lVo
aCJtnAy/kdOekYlQ3vlO1kYGG2WCQTyERd4pwaBjhlML/4yYPY6bNDTXOS8B70ES
wHYvYoFSjtG7a5RxHl8Rj3hjqqDWWMnZ+SxxNKh8TB+HCI8ppWLJaO6dFyUAhIuE
Lz/UmK2wcyqdFqiX6kD87SRJqgxrjJt+RqObUVolu+0Eq+PmKxtaRjapCzKeC+Xs
/B5Mena8bEbSmQFBZbElyTKMjovPcdQWIjW9h52B4O2NhVm52tPC1+oPJkdq/G3v
EfRC1++nhAsaa5dCwmQj2lal+QhBMSmb6IgZXIsuYPWiJWoWaQaUhxkHwIuOpQlt
50IDXyfdKq8/zID+0e6jP4I0CQ/rPTVZrPrb/Tcr9Lnx8DqqapYCpSNJjaYNXdg/
VQzGEdt0PzGmJHrXEWFJ8pQfWrwZiGMpQqT+O93Zxjm+8oFmklccLXXP0obyAcSJ
WVlzE9kNYrCz0UGNBfZnlFyjqpYdFJ35kkDFaTZVhAUt/IcdonelbgWJJUCWNZxS
TIGwtx64DgWyY8M2LG38U8k+u5rmh/QCv2DetuDsu/zIIUoFQf3z1krrmlARdnk9
YKjF/KL4oYhGyEhIv1Mb
=+Kbs
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--


--===============4646255388095684781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4646255388095684781==--
