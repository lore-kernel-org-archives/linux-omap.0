From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: Don't warn user about expected behaviour in mmc-twl4030
Date: Fri, 3 Apr 2009 18:03:33 -0700
Message-ID: <200904031803.33648.david-b@pacbell.net>
References: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk> <200903301353.44087.david-b@pacbell.net> <20090331210019.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n25.bullet.mail.mud.yahoo.com ([68.142.206.220]:43563 "HELO
	n25.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937257AbZDDBDi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 21:03:38 -0400
In-Reply-To: <20090331210019.GA12304@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 31 March 2009, Mark Brown wrote:
> On Mon, Mar 30, 2009 at 01:53:43PM -0700, David Brownell wrote:
> 
> > So when are you going to fix the regulator docs to report that:
> 
> > 	ALL regulator consumers must start by enabling and
> > 	then disabling the regulator.
> 
> The documention should not be changed to say that since only consumers
> that need the regulator to be off at startup should do this, and then
> probably only if they find that it is already enabled.

"Probably" shows you still don't have a good answer...

I see that mainline now has ca7255614e0861e36480103f4a402a115803d7b5
which is a variant of the first late-fixup patch I sent.  The isssue
with that approach is that it leaves a huge window between regulator
init and its late fixup ... during which driver probe() calls suffer
the bad effects of the current self-inconsistent initialization.  So
it doesn't really address the MMC cases.


On Friday 03 April 2009, Tony Lindgren wrote:
> 			... what
> if we have something in regulator_init_data that would tell the
> regulator to reset the regulator on init?

That would address the MMC scenario, where the stack always wants to
start with regulator "off" if it's possible.

And in fact, that's exactly what I think folk should be doing with
the recent additions to twl4030-power supporting explicit init of
all the power resources ... as done with e.g. Beagle.  The benefit
of doing it that way is that it can cover the regulators which are
not actually used on the board (like VAUX3 on Beagle, which u-boot
enables but is not wired to anything) plus non-regulator resources
like CLKREQ etc.

So there's an OMAP-specific workaround now in place, albeit not
yet headed towards mainline.

- Dave

