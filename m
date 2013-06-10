From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Mon, 10 Jun 2013 12:26:27 +0300
Message-ID: <51B59BC3.5010606@iki.fi>
References: <51B1C9D2.6060703@ti.com> <20130607183906.GB15295@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LXHWEOKSRRTETMXBIMFU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:37658 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab3FJJ0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 05:26:36 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so5553236lbf.8
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 02:26:34 -0700 (PDT)
In-Reply-To: <20130607183906.GB15295@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LXHWEOKSRRTETMXBIMFU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 21:39, Felipe Balbi wrote:

> sounds like there's something left in FIFO which is not getting read
> out, then we end up timing out.
>=20
> Can you try the patch below ? It's patch of a bigger patchset which I
> still need to clean a few things up, but they should be very close to
> being ready. IIRC, one of the patches creates a problem for N900 (only)=

> which gets fixed later, I just need to combine those two patches into
> one to avoid the regression.
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
> index aa3b91e..471b434 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1022,9 +1022,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  		}
>  	} while (stat);
> =20
> -	omap_i2c_complete_cmd(dev, err);
> -
>  out:
> +	omap_i2c_complete_cmd(dev, err);
>  	spin_unlock_irqrestore(&dev->lock, flags);
> =20
>  	return IRQ_HANDLED;
>=20

With this change the boot becomes unreliable:

[    3.024322] V2V1: 2100 mV
[    4.049530] omap_i2c 48070000.i2c: timeout waiting for bus ready
[    5.059417] omap_i2c 48070000.i2c: timeout waiting for bus ready
[    5.059448] twl: Write failed (mod 9, reg 0xe5 count 1)
and this continues.

I did manage to boot once, and running i2cdump printed each byte very
slowly, and with 0xff as the data.

 Tomi



------enig2LXHWEOKSRRTETMXBIMFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRtZvHAAoJEPo9qoy8lh71hqcP/Ra/WHEcq6ibkAmdpP8fRwgH
nHcKa7deQitkeZ7LZSm7tFjKdZRx5zry17LWW6pKiSFZWAoo/nuEVMyl3ejdcbC0
cmVIVgGZhUgqp7GF28GOxXrO7DJ1ZDUHZP8/3MxxDlBtX0WIiJpP140DrqQO1Dl/
VGyqziQH8HBNcUL22FNmQCJrY9kucd13TT0uqks0iutlMeX3wbPmdlbnmdwgVj3t
H7QmHznFn0ylzXdgF9ZRi4HKeWSb7l2XgadFmOQQTMEMDbWSofus4a5WkoT4uHgf
+qJawGRuCfbKkXRppO5whkFpAko7Xlt7fi1Uqtl0mmQV5yyci0OJJiZVorZNVSOg
dMqMhWZRGOFHJJ20Re/IKPukDUT6k6siANdDJhs6nlXnfpxPMZo0mEzHfIcNSVKi
JB4UODcsH7EeUsT+I7Amfk7fWnhT7pckP8QGbz8xptZcdZWnz/XvWxf2zHdKka8Y
59IwWsVXhr2KuKHP1HevgATlpg3Z/WrcogMYaJXGlPUb/2+j9+fJRoh6wrsOuAAG
o3Z6M3MUSkIazej4pfnmiXSwD2s+OF3iaGQ3kpSJS2U8Rl0UOnvxPqj9JTX7jyjw
Vqw6SxV/s+oPWbDULf/KY+85mscgQ+CJlmHUoMcHIwAbnDZjsDjtnJoLXbhOJGhZ
qJ81KU6sZ4VU3vH/Ki3B
=Y2sN
-----END PGP SIGNATURE-----

------enig2LXHWEOKSRRTETMXBIMFU--
