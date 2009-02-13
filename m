From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/6] leds: lp5521: move to drivers/leds
Date: Fri, 13 Feb 2009 15:54:20 -0800
Message-ID: <200902131554.20869.david-b@pacbell.net>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com> <200902131249.00592.david-b@pacbell.net> <20090213223636.GP10711@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:34900 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753302AbZBMXyX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 18:54:23 -0500
In-Reply-To: <20090213223636.GP10711@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Friday 13 February 2009, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Sat, 14 Feb 2009 00:34:56 +0200
> Subject: [PATCH] leds: lp5521: use sysfs_streq()
>=20
> instead of using strcmp() for comparing strings,
> use sysfs_streq().
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Yes, just like that.


> ---
> =A0drivers/leds/leds-lp5521.c | =A0 =A08 +++++---
> =A01 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
> index b3ba52a..3e1ca31 100644
> --- a/drivers/leds/leds-lp5521.c
> +++ b/drivers/leds/leds-lp5521.c
> @@ -352,12 +352,14 @@ static ssize_t store_mode(struct device *dev,
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0mutex_lock(&chip->lock);
> =A0
> -=A0=A0=A0=A0=A0=A0=A0if (!strncmp(buf, "run", 3))
> +=A0=A0=A0=A0=A0=A0=A0if (sysfs_streq(buf, "run"))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip,=
 LP5521_MODE_RUN);
> -=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(buf, "load", 4))
> +=A0=A0=A0=A0=A0=A0=A0else if (sysfs_streq(buf, "load"))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip,=
 LP5521_MODE_LOAD);
> -=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(buf, "direct", 6))
> +=A0=A0=A0=A0=A0=A0=A0else if (sysfs_streq(buf, "direct"))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0lp5521_set_mode(chip,=
 LP5521_MODE_DIRECT_CONTROL);
> +=A0=A0=A0=A0=A0=A0=A0else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0len =3D -EINVAL;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0mutex_unlock(&chip->lock);
> =A0
> --


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
