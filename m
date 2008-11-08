From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] Adapt twl4030 power code to new twl4030 code
Date: Fri, 7 Nov 2008 16:05:35 -0800
Message-ID: <200811071605.35623.david-b@pacbell.net>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com> <200810070919.55138.david-b@pacbell.net> <20081008064913.GA4542@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:31964 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752702AbYKHAFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 19:05:38 -0500
In-Reply-To: <20081008064913.GA4542@codecarver.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Peter 'p2' De Schrijver wrote:
>=20
> > 		=A0I don't quite know the details of what these
> > PM scripts are doing ... could they be misbehaving on Beagle,
> > so that they explain why "reboot" on RC8 fails?
>=20
> It might. At least the warmreset script might cause problems on Beagl=
e.
> I'm not familiar enough with beagle to know for sure.

Just for the record, now that I finally got around to making
that experiment:  if I disable CONFIG_TWL4030_POWER, "reset"
works again on my Beagle (with current GIT).

Exactly why it fails on Beagle but not on Overo (with twl5030
not twl4030), I don't know.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
