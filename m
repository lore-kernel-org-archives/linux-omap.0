From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: OMAP2+: Return correct error values from device and
 hwmod
Date: Fri, 20 Feb 2015 09:22:26 +0100
Message-ID: <20150220082226.GB14057@amd>
References: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60654 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbbBTIW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2015 03:22:29 -0500
Content-Disposition: inline
In-Reply-To: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

On Fri 2015-02-20 00:41:41, Pali Roh=E1r wrote:
> Without this patch function pm_runtime_get_sync() returns 0 even when=
 some
> omap subfunction fails. This patch properly propagate error codes fro=
m omap
> functions back to caller.
>=20
> This patch fix problem, when loading omap-aes driver in qemu cause ke=
rnel oops.

"fixes"

> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -3350,16 +3350,17 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
>   */
>  int omap_hwmod_idle(struct omap_hwmod *oh)
>  {
> +	int r;
>  	unsigned long flags;
> =20
>  	if (!oh)
>  		return -EINVAL;
> =20
>  	spin_lock_irqsave(&oh->_lock, flags);
> -	_idle(oh);
> +	r =3D _idle(oh);
>  	spin_unlock_irqrestore(&oh->_lock, flags);
> =20
> -	return 0;
> +	return r;
>  }

Normally, such variable is called ret or res...

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
