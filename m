From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 03/15] mfd: menelaus: Convert to threaded irq
Date: Tue, 10 Dec 2013 10:31:24 -0600
Message-ID: <20131210163124.GD22750@saruman.home>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-3-git-send-email-balbi@ti.com>
 <20131210093213.GV12675@lee--X1>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3175884464229240193=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131210093213.GV12675@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============3175884464229240193==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline

--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2013 at 09:32:13AM +0000, Lee Jones wrote:
> On Mon, 09 Dec 2013, Felipe Balbi wrote:
>=20
> > We don't need that extra workqueue when we have generic threaded irq
> > handlers support. This patch just moves over to threaded irqs and
> > deletes the unnecessary workqueue.
> >=20
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 29 ++++-------------------------
> >  1 file changed, 4 insertions(+), 25 deletions(-)
>=20
> <snip>
>=20
> > -		err =3D request_irq(client->irq, menelaus_irq, 0,
> > -				  DRIVER_NAME, menelaus);
> > +		err =3D request_threaded_irq(client->irq, NULL, menelaus_irq,
> > +				IRQF_ONESHOT, DRIVER_NAME, menelaus);
>=20
> devm_* managed resources please.

that would be subject to another patch. One that converts to devm_* on
the entire driver.

--=20
balbi

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSp0HcAAoJEIaOsuA1yqREVtIP/A6dvkfZjLgRH0nFlRectd3C
zIus1jKv6TPfbtM6HRRO5B7adTgrXULFLEQAWdB6JHhdrFBRh4xQC6897Hr7/vIt
3r/4YqXlI0MYVVsgIpumHngkZcbCsxUHBj8xatfjp62AcVhtduxofMilP9DDh+qf
AJ/PHif4q0bLjbc66UB1RCUtFP1gT20nfCafsbWZHJR2OmcpHurpSQT1r9YV3lwP
CTpeEyvct7yJsCN+PdPl6y7J53+GjhihixCtU9h4Ylzd9qy8twCotSoK1Vg/PMHB
92HPoqWB2wYrbZTFd122Ae3JhMJAsYjoxeaXQaCuHsHR3DYqTeDb8SnS+TxrGzVS
nsWWLRQ9gWPGAeceL6Vz/wm726oUeenFPEwROcqnqIC+xq2AYp9UQLKDmoHbhGE5
itsk3aqZnojkbGIp1CMx5YLU+bIUiomvU51iVP7w7GZw0IOB8uu9JKghVnL6sGl/
0xDrDGZDX8bZK4Q/PF7ezgaq+1qzlbahYRBP/bWDaJ2tv/lf/wh51YhaMQmxUDX0
oHlLQjJvPRFbDUSzFoEpM0IkR2g9ZMwhscq3knUrutvYe4CcVadOS8xoeJ81NWJA
8KCMTyjPc2sbBCE1xWqwLjxpLb/do+5iRMy11YxWESH8WwiOKRF3uKAsz7jN0Vzd
SkT8a5tW3ybdBQnW1Snk
=iLfe
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--


--===============3175884464229240193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3175884464229240193==--
