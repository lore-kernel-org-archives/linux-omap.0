From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP support in mainline?
Date: Thu, 18 Sep 2008 09:46:53 -0700
Message-ID: <200809180946.54124.david-b@pacbell.net>
References: <87tzcgi1gv.fsf@nokia.com> <1221738810.3873.37.camel@localhost> <13B9B4C6EF24D648824FF11BE896716203657701DB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:41588 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754593AbYIRRDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 13:03:23 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203657701DB@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Thursday 18 September 2008, Woodruff, Richard wrote:
> It would be nice if whatever code was on the main branch was not
> so frequently broken.

That's (at least) a current problem.  And the issue is how
to fix it... a *big* part of that involves having enough
(and current-enough) OMAP code in mainline that using one
of the OMAP branches (linux-omap, zoom, etc) isn't the
only realistic choice.


> Maybe those who are interested in it should work on a branch
> in the tree and periodically merge back at stable points.

Right, the basic model for code in mainline is that the
code there should be stable, with updates merged during
the RC0 window and otherwise just bugfixes.

Problem right now:  it seems most development on OMAP
branches (BTW, having two wastes effort/resources) isn't
working within that model.  Movement upstream is sluggish


> Maybe finally merged drivers at kernel.org will server that
> purpose and the local tree's can be all development.     

That requires discipline that has to some extent been missing.
Consider just the hsmmc driver ... it's been in OMAP branches
for how long now?  Yet it's never been submitted upstream.

- Dave
