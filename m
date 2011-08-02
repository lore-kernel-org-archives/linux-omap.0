From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] Fixes for "input: Add initial support for TWL6040
 vibrator"
Date: Tue, 2 Aug 2011 15:33:09 +0300
Message-ID: <20110802123308.GF7951@legolas.emea.dhcp.ti.com>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
 <1312284526-1656-2-git-send-email-peter.ujfalusi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36050 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754387Ab1HBMdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 08:33:12 -0400
Received: by mail-fx0-f43.google.com with SMTP id 17so6403565fxg.30
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 05:33:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312284526-1656-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 02, 2011 at 02:28:42PM +0300, Peter Ujfalusi wrote:
> @@ -145,7 +143,7 @@ static int vibra_play(struct input_dev *input, void *=
data,
> =20
>  	ret =3D queue_work(info->workqueue, &info->play_work);
>  	if (!ret) {
> -		dev_err(&input->dev, "work is already on queue\n");
> +		dev_info(&input->dev, "work is already on queue\n");

why ???

>  		return ret;
>  	}
> =20
> @@ -266,12 +264,10 @@ static int __devinit twl6040_vibra_probe(struct pla=
tform_device *pdev)
>  		goto err_irq;
>  	}
> =20
> -	printk(KERN_ERR "%s:powering twl6040\n", __func__);
>  	ret =3D twl6040_power(info->twl6040, 1);
>  	if (ret < 0)
>  		goto err_pwr;
> =20
> -	printk(KERN_ERR "%s:powered\n", __func__);

this hunk is not part of this patch.

>  	return 0;
> =20
>  err_pwr:
> @@ -297,7 +293,6 @@ static int __devexit twl6040_vibra_remove(struct plat=
form_device *pdev)
>  	twl6040_free_irq(info->twl6040, TWL6040_IRQ_VIB, info);
>  	input_unregister_device(info->input_dev);
>  	kfree(info);
> -	platform_set_drvdata(pdev, NULL);

neither is this.

--=20
balbi

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJON+6EAAoJEAv8Txj19kN1nSEH+gN5Lq3rhiht2iTcRJU+2R3H
/3SyVJWq8b5qkn+KEeEk7AX8dj7WZneTHceCliKgB8Xhw9X+GM/J2hFcX/vQDR84
2VIzf5JPQ6oaUporkaEz/tp9HBVlaIAwObuQmo0c/xtDEXeJb9OZfCjxYP9TPyZY
pWH3FO3BKKtaYf8YKyT1nhu4Vt3I0o26PjA7HM+WMVesVv6hyU+KVTHrmxj9DUFS
YWcluCRDMyD7AxQ2iI6YhvK/r5hSYck06rue6YaJ00A2xIMspUA57UTzJfRmt8Q0
yFPBowhial5sHI0O7Kqu2jSqGIyQLjoYZ3MoOO/nMm2jWkta7oz+PHk1D6J5UC0=
=QaX8
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
