From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: wait for TMDS to be high before
 putting
Date: Tue, 27 Mar 2012 13:30:02 +0300
Message-ID: <1332844202.1867.112.camel@deskari>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
	 <1332249307-26875-2-git-send-email-mythripk@ti.com>
	 <1332249307-26875-3-git-send-email-mythripk@ti.com>
	 <1332249307-26875-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-yINJ0CGYYGImuejc/mS5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53772 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956Ab2C0Kbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 06:31:52 -0400
Received: by mail-lb0-f170.google.com with SMTP id gg13so4700216lbb.29
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 03:31:51 -0700 (PDT)
In-Reply-To: <1332249307-26875-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-yINJ0CGYYGImuejc/mS5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-20 at 18:45 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Currently TX_PHY is put to TX_ON(transmission state) on receiving HPD.
> It just ensures that the TV is connected but does not guarantee
> that TMDS data lines and clock lines are up and ready for transmission.
> Which although is very rare scenario has a potential to  damage the HDMI
> port.
> Thus this patch adds the support based on PHY interrupts.
> On getting a HPD it registers for PHY connect/disconnect interrupt,
> On recieving those it is made sure TMDS lines are UP before changing
> the PHY state from LDO_ON to TX_ON.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/ti_hdmi.h         |    1 +
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   61 +++++++++++++++++++++++=
+++---
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 +
>  3 files changed, 58 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index 5e7e0da..5051df6 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -186,6 +186,7 @@ struct hdmi_ip_data {
>  	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct *=
/
>  	int hpd_gpio;
>  	bool phy_tx_enabled;
> +	bool phy_enabled;
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index 31d9927..a54c811 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -273,7 +273,8 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *=
ip_data)
>  {
>  	unsigned long flags;
>  	bool hpd;
> -	int r;
> +	int r =3D 0;
> +	struct hdmi_irq_vector irq_enable;
>  	/* this should be in ti_hdmi_4xxx_ip private data */
>  	static DEFINE_SPINLOCK(phy_tx_lock);
> =20
> @@ -286,11 +287,21 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data=
 *ip_data)
>  		return 0;
>  	}
> =20
> -	if (hpd)
> -		r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
> -	else
> +	hdmi_wp_clr_irq(ip_data);
> +	hdmi_wp_irq_init(&irq_enable);
> +	if (hpd) {
> +		if (ip_data->phy_enabled) {
> +			r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
> +		} else {
> +			irq_enable.phy_connect =3D 1;
> +			irq_enable.phy_disconnect =3D 0;
> +		}
> +	} else {
>  		r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
> -
> +		irq_enable.phy_connect =3D 0;
> +		irq_enable.phy_disconnect =3D 0;
> +		ip_data->phy_enabled =3D false;
> +	}

Why do you need this elaborate mechanism where you turn on/off the PHY
CONNECT/DISCONNECT interrupts? Why don't you just enable them when the
HDMI is enabled?

>  	if (r) {
>  		DSSERR("Failed to %s PHY TX power\n",
>  				hpd ? "enable" : "disable");
> @@ -300,6 +311,7 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *=
ip_data)
>  	ip_data->phy_tx_enabled =3D hpd;
>  err:
>  	spin_unlock_irqrestore(&phy_tx_lock, flags);
> +	hdmi_wp_irq_enable(ip_data, &irq_enable);

What happens if the connect irq happened before you enable the
interrupt?

>  	return r;
>  }
> =20
> @@ -312,17 +324,54 @@ static irqreturn_t hpd_irq_handler(int irq, void *d=
ata)
>  	return IRQ_HANDLED;
>  }
> =20
> +int hdmi_ti_4xxx_rxdet(struct hdmi_ip_data *ip_data)
> +{
> +       int tmds_lines =3D0;
> +
> +	tmds_lines =3D hdmi_read_reg(hdmi_phy_base(ip_data),
> +					HDMI_TXPHY_PAD_CFG_CTRL);
> +
> +	return (tmds_lines && 0x7F80);

I'm quite sure the line above is not correct, and thus the whole rxdet
system doesn't work properly.

>  /* Interrupt handler */
>  void ti_hdmi_4xxx_intr_handler(struct hdmi_ip_data *ip_data)
>  {
> -	u32 val;
> +	u32 val, r =3D 0;
> +	struct hdmi_irq_vector irq_enable;
> =20
>  	val =3D hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS);
> +
> +	hdmi_wp_clr_irq(ip_data);
> +	hdmi_wp_irq_init(&irq_enable);
> +
> +	if (val & HDMI_WP_IRQSTATUS_PHYCONNECT) {
> +		if (ip_data->phy_tx_enabled && hdmi_ti_4xxx_rxdet(ip_data)) {
> +			r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
> +			irq_enable.phy_connect =3D 0;
> +			irq_enable.phy_disconnect =3D 1;
> +			ip_data->phy_enabled =3D true;
> +		}
> +	}
> +
> +	/* We can get connect / disconnect simultaneously due to glitch	*/
> +	if (val & HDMI_WP_IRQSTATUS_PHYDISCONNECT) {
> +		if (ip_data->phy_tx_enabled && !hdmi_ti_4xxx_rxdet(ip_data)) {
> +			r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
> +			irq_enable.phy_connect =3D 1;
> +			irq_enable.phy_disconnect =3D 0;
> +			ip_data->phy_enabled =3D false;
> +		}
> +	}

Instead of spreading this code into two functions, why not handle
everything in one function. You have four states, connected/disconnected
for both HPD and PHY. Just track the states of those, and have one
function decide what to do depending on those states.

> +
> +	if (r)
> +		DSSERR("Failed to set PHY TX power\n");
> +
>  	/* Ack other interrupts if any */
>  	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS, val);
>  	/* flush posted write */
>  	hdmi_read_reg(hdmi_wp_base(ip_data), HDMI_WP_IRQSTATUS);
> =20
> +	hdmi_wp_irq_enable(ip_data, &irq_enable);
>  }
> =20
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data)
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.h
> index 3090e81..38af675 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> @@ -48,6 +48,8 @@
>  #define HDMI_WP_AUDIO_CFG2			0x84
>  #define HDMI_WP_AUDIO_CTRL			0x88
>  #define HDMI_WP_AUDIO_DATA			0x8C
> +#define HDMI_WP_IRQSTATUS_PHYCONNECT		0x02000000
> +#define HDMI_WP_IRQSTATUS_PHYDISCONNECT		0x04000000

Use (1 << xx) style there. And you could name them the same way as other
components: HDMI_WP_IRQ_PHYCONNECT. And if you add few, just add them
all.

 Tomi


--=-yINJ0CGYYGImuejc/mS5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZaqAAoJEPo9qoy8lh710kIQAKP9e7OfNIwJj4+wVtsH+406
uhz1s5Ux2Cl0oaJ3j6o31XdKHdKwVR61X2OXuc4vjMjcleo3KTvUUgc/kYLAgH2Z
T6lXEpi2bA6hsisBa88qmcQwjzMgeV2P8KPnhdPSnfTrojh+DK0oEpv/gvK3TUhW
ZpheOzNgqMrwIYEg0XBgThRe1/C/iKBAoPimCx2/P4MENKwWlng1uLfBepuuo0wV
E9XrNxoorPlsaE+lGfFoKQKL7j26wJbQhl6ZF6CNRPL5EmdZcYCYfaL/vo241BPK
l58OyUhKKu2dmFQSVJ/aR2G6OlAJIVTOMrgCubuW0QvQv9hvwOYPmIWkp0pf7jka
hWhu9JEiwzwUg7h9AQhdxjP/0tTiMRc/Zzt3pufVXas+ToqiAH7h+5dcWgxaRELw
KXL8xlRzJ0H+Hm8InDfJOtJR52Q4nRhkxgzsUVsswbiit5sEM76T9qSiuTlG0PLt
LvQHul8OgEctphWZqUVbF5AYy4pnbomo9D5u2W0p3lpnzuvj7ZIGZ/LGhFST7uQg
G0mMLK5JiWhrxln4sAiCypMkeVeenSg0AlarE2D/Ev7gzf2jnbWYb2CnFljdPFSM
VvTWK/zHUdplmQkQxDrt+Ruvjcx5lJLPPkIUJdKpett8ZNpK/z8zBKUqxoLrLgeA
8uxo1x9/DE9s4qO2jE0Z
=LdQh
-----END PGP SIGNATURE-----

--=-yINJ0CGYYGImuejc/mS5--

