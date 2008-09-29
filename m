From: David Brownell <david-b@pacbell.net>
Subject: Re: [i2c] [PATCH 7/8] i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
Date: Mon, 29 Sep 2008 16:06:36 -0700
Message-ID: <200809291606.37236.david-b@pacbell.net>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com> <20080929222942.GT2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:29026 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751629AbYI2XGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 19:06:45 -0400
In-Reply-To: <20080929222942.GT2716@fluff.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Tony Lindgren <tony@atomide.com>, i2c@lm-sensors.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Monday 29 September 2008, Ben Dooks wrote:
> > -static void __exit omap_i2c_exit_driver(void)
> > +static void __devexit omap_i2c_exit_driver(void)
>=20
> a differerent change to the one advertised.
>=20
> > =A0{
> > =A0=A0=A0=A0=A0=A0platform_driver_unregister(&omap_i2c_driver);
> > =A0}

And incorrect too.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
