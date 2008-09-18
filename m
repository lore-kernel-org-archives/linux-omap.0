From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 13:10:49 -0700
Message-ID: <200809181310.49569.david-b@pacbell.net>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918195007.GA14307@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:43225 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755461AbYIRUK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 16:10:56 -0400
In-Reply-To: <20080918195007.GA14307@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, wim@iguana.be

On Thursday 18 September 2008, Russell King - ARM Linux wrote:
> What I say to Tony: do you want OMAP to be merged into mainline, or
> don't you. =A0If you do, do _not_ accept this patch but get the chang=
es
> already in your tree for omap_wdt.c up to Wim, and then get this patc=
h
> there. =A0Provide the carrot by getting the driver up to date in main=
line,
> and the stick by only accepting patches for this driver once they've
> been acked by Wim. =A0Explicitly ask Wim to ack them for you.
>=20
> Then you have one less driver to worry about constantly being out of
> date with mainline.

That sounds like a plan.  One could go further and work
something like the "stable" tree ... not merging into the
OMAP tree until the patch is merged, or at least queued,
for upstream.  Minimal exceptions, if any.  (And not for
this watchdog!)

That should be workable for most drivers; sometimes with
a few arch/arm/plat-omap/include/mach/*.h updates you may
need to ack.  Things like CBUS support (no framework for
that is upstream) are cases where it'd fail.

I'm not exactly in this particular loop except as a gadfly
with relevant insight/background/experience, but I suspect
that a basic goal *MUST* be to avoid having Tony and/or
Russell in the loop unless it's unavoidable. =20

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
