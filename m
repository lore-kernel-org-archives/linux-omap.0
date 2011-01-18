From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Tue, 18 Jan 2011 16:28:58 +0000
Message-ID: <20110118162858.GA17398@n2100.arm.linux.org.uk>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk> <20110117100857.GS6917@pengutronix.de> <20110117104618.GB18626@n2100.arm.linux.org.uk> <20110118153257.GA10686@pengutronix.de> <20110118154344.GG10997@n2100.arm.linux.org.uk> <20110118155851.GC10686@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40456 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab1ARQaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 11:30:12 -0500
Content-Disposition: inline
In-Reply-To: <20110118155851.GC10686@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 04:58:51PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Russell,
>=20
> On Tue, Jan 18, 2011 at 03:43:44PM +0000, Russell King - ARM Linux wr=
ote:
> > On Tue, Jan 18, 2011 at 04:32:57PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Jan 17, 2011 at 10:46:18AM +0000, Russell King - ARM Linu=
x wrote:
> > I will continue to mail out patches which I want people to test and=
 give
> > feedback on, because that is the _only_ way to do it.
> Note that I didn't suggest to stop sending out patches and collecting
> the acks and tested-bys there.  The automated tests are just a differ=
ent
> test.
>=20
> And IMHO it's not harder to reply with a git commit-id, but it makes =
it
> more likely that a reply to a wrong mail is detected.

No.  Take a moment and think.

Two people pull the commits one evening.  One gets in during GMT mornin=
g,
checks their tests, and reports "git commit X passed, have this Tested-=
by".
So, their tested-by is added to the commit, which changes the git ID to
Y.

Second person gets in during GMT afternoon, and reports "git commit X
passed."  Now instead of looking in the current branch, I'd have to
cross-reference it back to what was originally there, check that's
what they actually meant, look that up in the new branch, and apply
their tested-by to that instead.

More complicated means more things to go wrong.  No thank you.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
