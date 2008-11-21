From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: Switch to gpio_direction_output in OMAP_LDP.
Date: Thu, 20 Nov 2008 23:52:10 -0800
Message-ID: <200811202352.10830.david-b@pacbell.net>
References: <1227189663-27966-1-git-send-email-stanley.miao@windriver.com> <200811201111.09749.david-b@pacbell.net> <1227253842.14497.75.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:40348 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751926AbYKUHwN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:52:13 -0500
In-Reply-To: <1227253842.14497.75.camel@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stanley.miao@windriver.com
Cc: linux-omap@vger.kernel.org

On Thursday 20 November 2008, stanley.miao wrote:
>=20
> > Use gpio_set_value() to replace omap_set_gpio_dataout(), except
> > when initializing. =A0The reset pin *was* being toggled...
>=20
> These actions are in init function. so keep omap_set_gpio_dataout() i=
n
> place.

No, omap_set_gpio_dataout() is gone.  You can't call it any more.

  gpio_direction_output(gpio, initial_value)

is what you'd want after gpio_request().
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
