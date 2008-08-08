From: Jean Delvare <khali@linux-fr.org>
Subject: Re: testers wanted: isp1301_omap conversion to new-style i2c
 driver
Date: Fri, 8 Aug 2008 11:17:51 +0200
Message-ID: <20080808111751.494702cc@hyperion.delvare>
References: <20080617204300.77c8e516@hyperion.delvare>
	<20080807183416.115c67ba@hyperion.delvare>
	<200808071651.43297.david-b@pacbell.net>
	<20080808072954.GH24923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:18699 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYHHJSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 05:18:05 -0400
In-Reply-To: <20080808072954.GH24923@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Deepak Saxena <dsaxena@plexity.net>

Hi Tony,

On Fri, 8 Aug 2008 10:29:55 +0300, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [080808 02:51]:
> > On Thursday 07 August 2008, Jean Delvare wrote:
> > > Still no testers for these patches? 
> > 
> > Right now I don't seem to be able to boot OMAP1 in mainline,
> > so pulling that H2 out of its box would be futile.  :(
> 
> Grr, looks like I can't access my H2 remotely right now as my
> remote power switch is hung, and would need to be remote rebooted..
> 
> So I can't access H2 for few more weeks, can somebody else test
> on H2 meanwhile?
> 
> BTW, this patch should OK to apply as we've had it in the
> linux-omap tree since December, and I've occasionally boot tested
> H2, last time I think was when I removed the __REG macros few
> months ago.

It is possible that you have had the 1st patch in your tree for some
time. However, the second patch I wrote 1.5 month ago or so, so I doubt
that you can have it in your tree since December 2007 ;)

Maybe your can update the omap tree with my patches? This would give
them the testing they are missing, and then we can push them upstream.
Ideally that would have gone in 2.6.27, but it starts being a bit late
for that now.

Thanks,
-- 
Jean Delvare
