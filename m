From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Tue, 17 Mar 2009 03:25:41 -0700
Message-ID: <200903170325.41841.david-b@pacbell.net>
References: <200903110518.34945.david-b@pacbell.net> <200903170007.18908.david-b@pacbell.net> <49BF4D56.2070704@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:29142 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754078AbZCQKZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2009 06:25:44 -0400
In-Reply-To: <49BF4D56.2070704@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: OMAP <linux-omap@vger.kernel.org>

On Tuesday 17 March 2009, Adrian Hunter wrote:
> >=20
> > Elaborate please? =A0The regulator framework complains
> > if it's not there, even when that's not a bug.
>=20
> Sorry, I am at home but I realise now that I did record the message:
>=20
> regulator: Unable to get requested regulator: vmmc_aux

That's just the regulator framework being stupid.
In two ways:  (a) doesn't say which device didn't
have a "vmmc_aux" supply, (b) even if it did indicate
a bug, that would be the responsibility of the driver
to handle (when it gets an error from that lookup).


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
