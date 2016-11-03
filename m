From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] ARM: OMAP3: Fix formatting of features printed
Date: Thu, 3 Nov 2016 22:03:54 +0100
Message-ID: <20161103210354.qtf4ljbcmcgtvo6j@earth>
References: <20161103173439.20657-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5063144806112600346=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161103173439.20657-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============5063144806112600346==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwv4n2i6imvnv7q3"
Content-Disposition: inline


--hwv4n2i6imvnv7q3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 03, 2016 at 10:34:39AM -0700, Tony Lindgren wrote:
> With the printk cleanups merged into v4.9-rc1, we now get the omap
> revision printed on multiple lines. Let's fix that and also remove the
> extra empty space at the end of the features. And let's update things
> to use scnprintf as suggested by Ivaylo Dimitrov
> <ivo.g.dimitrov.75@gmail.com>.
>=20
> Reported-by: Adam Ford <aford173@gmail.com>
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/id.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--hwv4n2i6imvnv7q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYG6YzAAoJENju1/PIO/qae9QP/1JiFYX8TPKZWeEfnu9RouiB
QJc9MN7+SyIi8T0cxnDqETxGTV2p7RY6Z37GO1oQiXD4ShnS3IVGgrpudzucS+yk
7QrT0dyluiqBCMVATBvPalQOlHiAMJsVhJrvdQVklosdBBCvRfLu2jG6jOGcTNJF
gIgny9qElyOvdfKgKyPuEmJVcxL/87GRynydIeI4IeOEM1S0dk3mcyBxIEsL2tvN
BKjRYihk9SBSZx9rOiq/uClAzkaaVvAL9Y2w0+gzknAEaQrTobm4qNx/CN0eF12t
PYUi1XdHO/+q8rOVRANTcetMOG+1p9eL/teaoZkH0GTD8gBV7R+sCbYGJ9h4eNyV
B/j7eCvAFM8/5kr5fQIZIStOqpP8UIy8dUAMlwrXzAmFmcNxK9f3W6SmUx27FsyE
WGpt2DHfZ1UnrJPJoHpPtWjj6OFHj3wCXPcK7hm4eqjMWKrSy4foXlggOg9itAYN
xPU5lrCjvHrHq1K2FVK9cKiVtllWrovxnPm8iOhc0tSpr7Sm8vm3OhqQQf2PamiN
NwRGKYFG58zKwiXPR8SQyw48HtzK3cErMxHjejH5G61AlH/EJOk6HiDm7kR3lNeY
wnCYPlQ6yyYZlbMoOS6rS6GdACez1zUTVZvVce/rzzU7hOdOv7FR4LZsjoEGbf6J
5+E9wa+W0ANvgg1FFY9E
=IGTy
-----END PGP SIGNATURE-----

--hwv4n2i6imvnv7q3--


--===============5063144806112600346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5063144806112600346==--
