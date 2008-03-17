From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] I2C: Fix unhandled fault in i2c-omap controller, take #2
Date: Mon, 17 Mar 2008 00:07:49 -0800
Message-ID: <200803170107.50083.david-b@pacbell.net>
References: <20080313155123.GI11653@atomide.com> <20080317064619.GO11653@atomide.com> <20080317071949.GP11653@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:23685 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752344AbYCQIHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Mar 2008 04:07:52 -0400
In-Reply-To: <20080317071949.GP11653@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, i2c@lm-sensors.org

On Monday 17 March 2008, Tony Lindgren wrote:
> @@ -360,7 +374,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2=
c_msg msgs[], int num)
> =A0=A0=A0=A0=A0=A0=A0=A0int i;
> =A0=A0=A0=A0=A0=A0=A0=A0int r;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0omap_i2c_enable_clocks(dev);
> +=A0=A0=A0=A0=A0=A0=A0omap_i2c_unidle(dev);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> @@ -374,7 +388,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2=
c_msg msgs[], int num)
> =A0=A0=A0=A0=A0=A0=A0=A0if (r =3D=3D 0)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r =3D num;
> =A0out:
> -=A0=A0=A0=A0=A0=A0=A0omap_i2c_disable_clocks(dev);
> +=A0=A0=A0=A0=A0=A0=A0omap_i2c_idle(dev);
> =A0=A0=A0=A0=A0=A0=A0=A0return r;
> =A0}
> =A0

Wouldn't it be nice -- from a pure power management perspective
of course! -- if more drivers were this careful about idling
their clocks when they have no work to do.  ;)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
