From: Tony Lindgren <tony@atomide.com>
Subject: Re: testers wanted: isp1301_omap conversion to new-style i2c driver
Date: Fri, 8 Aug 2008 12:45:52 +0300
Message-ID: <20080808094551.GP24923@atomide.com>
References: <20080617204300.77c8e516@hyperion.delvare> <20080807183416.115c67ba@hyperion.delvare> <200808071651.43297.david-b@pacbell.net> <20080808072954.GH24923@atomide.com> <20080808111751.494702cc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57311 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbYHHJqC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 05:46:02 -0400
Content-Disposition: inline
In-Reply-To: <20080808111751.494702cc@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Deepak Saxena <dsaxena@plexity.net>

Hi,

* Jean Delvare <khali@linux-fr.org> [080808 12:18]:
> Hi Tony,
> 
> On Fri, 8 Aug 2008 10:29:55 +0300, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [080808 02:51]:
> > > On Thursday 07 August 2008, Jean Delvare wrote:
> > > > Still no testers for these patches? 
> > > 
> > > Right now I don't seem to be able to boot OMAP1 in mainline,
> > > so pulling that H2 out of its box would be futile.  :(
> > 
> > Grr, looks like I can't access my H2 remotely right now as my
> > remote power switch is hung, and would need to be remote rebooted..
> > 
> > So I can't access H2 for few more weeks, can somebody else test
> > on H2 meanwhile?
> > 
> > BTW, this patch should OK to apply as we've had it in the
> > linux-omap tree since December, and I've occasionally boot tested
> > H2, last time I think was when I removed the __REG macros few
> > months ago.
> 
> It is possible that you have had the 1st patch in your tree for some
> time. However, the second patch I wrote 1.5 month ago or so, so I doubt
> that you can have it in your tree since December 2007 ;)

Sorry, I totally missed your second patch. I guess I was just looking
at the patch name which is same.

> Maybe your can update the omap tree with my patches? This would give
> them the testing they are missing, and then we can push them upstream.
> Ideally that would have gone in 2.6.27, but it starts being a bit late
> for that now.

Yeah, I will add it to linux-omap for testing for sure. This should be
easy to test though, it either works or does not.. But we need to find
somebody to boot it and connect USB cable to it :)

Thanks,

Tony
