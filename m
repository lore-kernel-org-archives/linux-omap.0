From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 05/16] mfd: omap-usb-tll: Add OMAP5 revision and HSIC
 support
Date: Wed, 21 Nov 2012 14:12:38 +0200
Message-ID: <20121121121238.GG10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-6-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-6-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:03PM +0200, Roger Quadros wrote:
> The TLL module on OMAP5 has 3 channels.
> HSIC mode requires the TLL channel to be in Transparent UTMI mode.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/omap-usb-tll.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 31ac7db..c48d545 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -54,10 +54,13 @@
> =20
>  #define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
>  #define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
> +#define OMAP_TLL_CHANNEL_CONF_DRVVBUS			(1 << 16)
> +#define OMAP_TLL_CHANNEL_CONF_CHRGVBUS			(1 << 15)
>  #define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
>  #define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
>  #define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
>  #define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
> +#define OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI	(2 << 1)
>  #define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
>  #define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
> =20
> @@ -96,6 +99,7 @@
>  #define OMAP_USBTLL_REV1		0x00000015	/* OMAP3 */
>  #define OMAP_USBTLL_REV2		0x00000018	/* OMAP 3630 */
>  #define OMAP_USBTLL_REV3		0x00000004	/* OMAP4 */
> +#define OMAP_USBTLL_REV4		0x6		/* OMAP5 */

looks wrong to me. Are you sure this is what that 32-bit register reads
out ? Bits[31:30] should read as 0b01 as per internal documentation.

--=20
balbi

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrMU2AAoJEIaOsuA1yqREo8cP/0MrCajCmxRDDH3xmAf3X9PO
g+/o8/AqZUWeSxqyb297fhlHGXi7mXWI+/Wv4D77UQk4vxN0L/5K6IZOD6HT48aa
Mntb+QTWIHDkIEUTMcZ0Xq53qbWtpqNFZPvjrYOwZ9QEFl55XLTr18uhOwUeK2m7
wjSMKsFGxjIvaiGOukDJWfNMx5cDAUZtxw15v35VxhBLSJZzQasVGN4dzEQTu4qa
0lM3XWHuszm9l0wStDuUUrTLqFwh8+bgBw4gXP+QsXaiu9bINHPtcd3XRGM5u5A1
iSIryWWLu/twCaAogjU8t97G7e99ayFHqs/8NoS8cjU9TPhCM1JWkJ/+YGjTNeFW
kYx72iEJiQe+k/PJtmK4FKEeBtlNRwprg5s8AXNeqtKJ4dhS00dgfPFR53xu5Uly
2Dj1hzoS4YwENKWAhmZFSDZe+/PmOcuSvQC+nXop3u2cEMtZGeh2HPQJK2ezD/nB
YnE3zQ8PaBU8lzysCUCYyIcDUGB+B8zY+vY+D6P6I7mx+pN8gBZyumD00fUSmiUN
5blHZ833v8hC1bN13gEPIvH5Y2WocILmmyzacol5eH9BzJMi0NBr+CvpdD9xP8m6
EsCg64T2UXQVUAkdEy4Wdb7ABt2mKwNb4n52NRT/BsYy7Liqvu+wf9Ck+ihIMK41
lmSmZaW3dTou0LPrBDv8
=eWGM
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
