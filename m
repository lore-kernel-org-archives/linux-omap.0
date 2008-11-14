From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap 0/4] twl4030 regulator support
Date: Thu, 13 Nov 2008 17:25:05 -0800
Message-ID: <200811131725.05573.david-b@pacbell.net>
References: <200811111756.20719.david-b@pacbell.net> <200811131646.12074.david-b@pacbell.net> <20081114010311.GE3106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:38230 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754516AbYKNBZH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 20:25:07 -0500
In-Reply-To: <20081114010311.GE3106@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 13 November 2008, Tony Lindgren wrote:
>=20
> > Oh, and somewhat related ... nothing seems to turn off unused
> > regulators. =A0I'm thinking that bitmasks to define the P1/P2/P3
> > group memberships of most power resources would do the job.
>=20
> Yeah I was wondering about that too. Should the processor group
> membership be set only once during init?

I think it should certainly be set during init.  The PM scripts
don't change membership, but I can imagine some of them would
want to use custom type or subtype codes that would also need to
be set during init.

The current way to enable/disable a regulator for Linux purposes
is to add/remove it from the P1 group.  That seems OK for now...
only a handful of regulators use software control like that,
which would change membership after init.

But we *could* enable/disable by directly setting the mode.
I decided against doing it that way, on the grounds that until
we get some use cases that need something else, we're best off
keeping things simple.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
