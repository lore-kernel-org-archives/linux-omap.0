From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 01/33] add lp5521 driver
Date: Sun, 31 Aug 2008 13:39:21 -0700
Message-ID: <200808311339.21660.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27499 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757961AbYHaVTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:08 -0400
In-Reply-To: <1220116593-862-2-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Saturday 30 August 2008, Felipe Balbi wrote:
> +static int lp5521_configure(struct i2c_client *client)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int ret =3D 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Enable chip and set light to logarithmic mod=
e*/
> +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_ENABLE=
, 0xc0);
> +
> +=A0=A0=A0=A0=A0=A0=A0/* setting all color pwms to direct control mod=
e */
> +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_OP_MOD=
E, 0x3f);
> +
> +=A0=A0=A0=A0=A0=A0=A0/* setting current to 4.7 mA for all channels *=
/
> +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_R_CNTR=
L, LP5521_CURRENT_4m7);
> +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_G_CNTR=
L, LP5521_CURRENT_4m7);
> +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_B_CNTR=
L, LP5521_CURRENT_4m7);
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Enable auto-powersave, set charge pump to au=
to, red to battery */
> +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_MISC, =
0x3c);
> +

This highlights one reason many of these drivers haven't gone
upstream: embedding non-general assumptions.  In this case it
should be simple enough to define platform data to represent
various options like these ...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
