From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch] some drivers switch away from OMAP-specific GPIO calls
Date: Thu, 25 Sep 2008 09:52:12 -0700
Message-ID: <200809250952.12282.david-b@pacbell.net>
References: <200809241935.57001.david-b@pacbell.net> <20080925125311.GT5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:20170 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751135AbYIYQwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 12:52:14 -0400
In-Reply-To: <20080925125311.GT5222@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 25 September 2008, Tony Lindgren wrote:
> >=20
> > This updates most of the OMAP drivers which are in mainline to
> > switch to using the cross-platform GPIO calls instead of the
> > older OMAP-specific ones.
> >=20
> > This is all fairly brainless/obvious stuff. =A0Probably the
> > most interesting bit is to observe that the omap-keypad
> > code seems to now have a portable core that could work with
> > non-OMAP matrix keypads. =A0(That would improve with hardware
> > IRQ debouncing enabled, of course...)
>=20
> Do you want push this to mainline as part of gpiolib patches?

I'l send it now that I have your Signed-off-By.
CC a few subsystem maintainers ... but I see no
point in splitting this into mini-patchlets.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
