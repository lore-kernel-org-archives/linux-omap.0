From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Thu, 10 May 2012 09:54:50 +0300
Message-ID: <1336632890.5182.9.camel@deskari>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zlF4Nx/me7jpcmjZxL2p"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:35297 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755881Ab2EJGy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:54:57 -0400
Received: by lbbgm6 with SMTP id gm6so1005565lbb.5
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:54:52 -0700 (PDT)
In-Reply-To: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-zlF4Nx/me7jpcmjZxL2p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 15:08 -0700, Russ Dill wrote:
> The Beagleboard xM gpio used for TFP410 powerdown is connected through
> an I2C attached chip which means setting the GPIO can sleep. Code that
> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.
>=20
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  drivers/video/omap2/displays/panel-tfp410.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'll apply this to dss tree, thanks.

 Tomi


--=-zlF4Nx/me7jpcmjZxL2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq2Y6AAoJEPo9qoy8lh71YzAP/369xufeiqHwgdo3gFSVtQhV
8OW/MMcNFtAB9QZBDeTUFPm3hsr9VCr1p9IS+oYLfKB+hhFWg9TxEjHVWdRCgj1s
0sthygOUYJq67cVZsxrKsY4dXdiFK3fQAvxjxuhLkFZPJadNUPJsB+jAMzNUyfYC
Z7uivIuoV+FfeCx3f1lrnWfBAE0ta+r6He7kkiLU8DAcmqsiWQza+v5Tp+QyP05i
3y/aa3FNq2LcksDksPDXFYHwhiaoajNShCfSQWikB47xK7R0FPkTyq7ko4P4sS9W
CvZSOfCYENjP6RCj8OeWNADOU2/Z23hKPdK8QHrZ1mG+bn1zYTZ01s3X888apSXV
ToZAyyEoffzHsDQ2odyLw9IZXrsBY7K0HgDk+J4nwCBLz7gfLoKuwZT/8BKjxVEF
e3XYvgCU2x8TmdBxhR+SGrpS+/HbzHNQOLqMbzGf1SxcVV+qUSwvIdoct7Zb11rN
IFtZYKdYbGQcg102aZtmWs/Ej4ICvapYKE5PIe0ilFSwaQwZAsxobt3JfEMm5Xap
OtdW52rkLD6jGcp8rA2ZVV7v72a+FKN0fhVLqOOl++j6Dw1tMvzYFEpXudhra19i
8SwsVK7NY4PR4E4ORkF8GKlCPZT41MZByF8K6x1yee1AmLuzEwXqz+kQ6WxwTjuW
YqG2+WS1eJz3p+56hhbN
=eUEu
-----END PGP SIGNATURE-----

--=-zlF4Nx/me7jpcmjZxL2p--

