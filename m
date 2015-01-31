From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if UP
 system
Date: Sat, 31 Jan 2015 01:09:39 -0600
Message-ID: <20150131070939.GA4068@saruman.tx.rr.com>
References: <1422665010-5854-1-git-send-email-sboyd@codeaurora.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422665010-5854-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Stefan Agner <stefan@agner.ch>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+linux-omap

On Fri, Jan 30, 2015 at 04:43:30PM -0800, Stephen Boyd wrote:
> In a uniprocessor implementation the interrupt processor targets
> registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
> gic_get_cpumask() will print a critical message saying
>=20
>  GIC CPU mask not found - kernel will fail to boot.
>=20
> if these registers all read as zero, but there won't actually be
> a problem on uniprocessor systems and the kernel will boot just
> fine. Skip this check if we're running a UP kernel or if we
> detect that the hardware only supports a single processor.
>=20

Nice, I'll test this on AM437x on Monday but certainly looks promising:

Acked-by: Felipe Balbi <balbi@ti.com>


> Acked-by: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index d617ee5a3d8a..1b70e0de0f6e 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -346,7 +346,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>  			break;
>  	}
> =20
> -	if (!mask)
> +	if (!mask && num_possible_cpus() > 1)
>  		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
> =20
>  	return mask;
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
balbi

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUzH+zAAoJEIaOsuA1yqRED3QP/jc0k69M7z6I+mYMLpqe8977
Hm0gMYRx6jQgimACNVh/2NWRcQBLxHAJR+P9SUPokLYf1pTqlO/tDGp+nF/wxJg+
maB946brjRowIAGI5dAn14RSJqXCRvyfl1r2lqTitJ4vb4hbhRhmyyRPZCoxevxI
5QzTXSLA7GnSXQtQR6TaNd2Ec6urOt5pE78hd184pgcHVFS9qRAjMFWbeJx/L77f
/1xHHFztizeWWzy64ePSwSqHuZ4Pf01EbzEGJQxPV/glrxgdvaATuGZY1m+T2b85
H0gB48ooQX7PH5I0X+iIhKRv+svdsmzKtYqyOunGX7H1F4BwN0rl0ljj38AhxrS8
wC9TnfhOCy5f2LkXNLYxBfl6Pj08HkMojB63/Ojz9XONMPJgXBf2TU6RXhfqRyAj
u2Yznv7QQLu/6o3gSRrG+ivTAQkF/JmFnHC/NWHjPp5HrvnW2FgkmXEAeZ0qNmN0
dcv42gZYUBHBSoEu6U2+2bCYpAKv03KuQemrPO4Cy/0XW+SpcAdtW7pHRJPf6H13
Fdql2q+MdpVFVwl59Dgxm0UGsLTIpTBs8RwqAhuEXVUIrCGsWMXSyD5ZAd3MwvqV
y991z04MLkQ4ez1hCRvTHJs5BX8YkGj7beWBPzKr3XSpciaQFdowJnMSNK4LC4XT
X0ZcmzwcpDB28zWmYikq
=Ukqc
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
