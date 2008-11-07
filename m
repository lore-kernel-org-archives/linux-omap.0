From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap git] hsmmc gpio updates
Date: Fri, 7 Nov 2008 09:50:49 -0800
Message-ID: <200811070950.50033.david-b@pacbell.net>
References: <200811062115.30519.david-b@pacbell.net> <5e088bd90811070619h73120f30ye7608e2aaff5e514@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:32320 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750879AbYKGRvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 12:51:01 -0500
In-Reply-To: <5e088bd90811070619h73120f30ye7608e2aaff5e514@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

On Friday 07 November 2008, Steve Sakoman wrote:
> Nice work! =A0Overo uses TWL4030 gpio-0 for card detect (just like
> Beagle) and GPIO-54 for WP.
>=20
> Would you like me to prepare a patch to add on top of yours or would
> you prefer to add it to yours (if you have a revision planned)?

Patch on top of this, please; I have no revision planned.
Don't forget to set up the mmc_cd bitmask too!

How can WP work for a Micro-SD card though?  I don't see a
switch on any of mine...

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
