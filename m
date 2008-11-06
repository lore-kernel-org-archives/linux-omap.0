From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 6 Nov 2008 12:52:25 -0800
Message-ID: <200811061252.26205.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200811052309.59974.david-b@pacbell.net> <20081106170445.GU21736@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:34847 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752662AbYKFUw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 15:52:29 -0500
In-Reply-To: <20081106170445.GU21736@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org

On Thursday 06 November 2008, Tony Lindgren wrote:
>=20
> > I'll have a look at write protect ... it wouldn't normally
> > be an IRQ, just an input GPIO. =A0Unlike the CD, which gets
> > used for both purposes; that code looks iffy too.
>=20
> OK. We also need to figure out what to do if we need to support other
> gpios than twl gpios.

Mostly addressed in the patch you'll see.
The remaining bit is better handling of
debouncing.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
