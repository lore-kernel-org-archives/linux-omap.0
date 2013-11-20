From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Wed, 20 Nov 2013 19:02:13 -0300
Message-ID: <20131120220212.GA12776@localhost>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384984714-19860-1-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

(Forgot to Cc OMAP people)

On Wed, Nov 20, 2013 at 06:58:34PM -0300, Ezequiel Garcia wrote:
> The 'gpio_reset' field was implicitly set to zero, which is a valid
> GPIO line and results in the NOP PHY layer trying to request it.
>=20
> Instead, the AM335x SoC need special USB PHY reset handling so let's
> set 'gpio_reset' to EINVAL and prevent the NOP PHY from messing with =
it.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
> Commit bd27fa44e13830d2baa278d5702e766380659cb3 (usb: phy: generic:
> Don't use regulator framework for RESET line) introduced this.
>=20
>  drivers/usb/phy/phy-am335x.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335=
x.c
> index 6370e50..7fff9f3 100644
> --- a/drivers/usb/phy/phy-am335x.c
> +++ b/drivers/usb/phy/phy-am335x.c
> @@ -43,6 +43,9 @@ static int am335x_phy_probe(struct platform_device =
*pdev)
>  	if (!am_phy)
>  		return -ENOMEM;
> =20
> +	/* Prevent GPIO Reset from the Generic PHY */
> +	am_phy->usb_phy_gen.gpio_reset =3D -EINVAL;
> +
>  	am_phy->phy_ctrl =3D am335x_get_phy_control(dev);
>  	if (!am_phy->phy_ctrl)
>  		return -EPROBE_DEFER;
> --=20
> 1.8.1.5
>=20

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
