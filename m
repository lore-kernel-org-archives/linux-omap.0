From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Add support for TPS6235x support
Date: Fri, 13 Feb 2009 14:30:28 -0800
Message-ID: <200902131430.28951.david-b@pacbell.net>
References: <1233723366-13053-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:44264 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751899AbZBMWab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 17:30:31 -0500
In-Reply-To: <1233723366-13053-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: broonie@sirena.org.uk, linux-omap@vger.kernel.org

On Tuesday 03 February 2009, Manikandan Pillai wrote:
> +static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
> +{
> +=A0=A0=A0=A0=A0=A0=A0unsigned char vsel1;
> +=A0=A0=A0=A0=A0=A0=A0struct tps *tps =3D rdev_get_drvdata(dev);
> +
> +=A0=A0=A0=A0=A0=A0=A0tps_6235x_read_reg(tps, TPS6235X_REG_VSEL1, &vs=
el1);
> +
> +=A0=A0=A0=A0=A0=A0=A0return !(vsel1 & TPS6235X_EN_DCDC);
> +}

Let me correct my earlier comment about bugs in this routine.
Today's is_enabled() predicate *DOES* support error reporting.
So that code should be

	ret =3D tps_6235x_read_reg(...);
	if (ret < 0)
		return ret;

But another bug here is the "!(vsel & ...)", returning zero
when the regulator is *ENABLED* not disabled.

Either return "!!(vsel & ...)" to return zero/one, or
else remove the "!( )" entirely

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
