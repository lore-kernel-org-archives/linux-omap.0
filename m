From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc5-omap-git] mach-omap2/mmc-twl4030: fix for vmmc = 0
Date: Wed, 25 Feb 2009 02:04:53 -0800
Message-ID: <200902250204.53559.david-b@pacbell.net>
References: <200902231014.26352.david-b@pacbell.net> <200902241213.06500.david-b@pacbell.net> <49A51323.1030701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:20016 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762049AbZBYKE4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2009 05:04:56 -0500
In-Reply-To: <49A51323.1030701@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >> Looks fine to me, but I wonder if you know why the regulator is
> >> turned on (DEV_GRP) and then the voltage is selected (DEDICATED).
> > 
> > History, I'd guess.  I seem to remember some sequencing
> > constraint, but couldn't find it when last I sought it
> > out in the reference manual.
> 
> What about section 5.5.1 item 6?

That's an example.  I'm thinking the constraint had
to do with one or more of the USB regulators.  It just
doesn't make sense to have a *general* rule that the
resource needs to be enabled before tweaking.  Maybe
it was an erratum or something.


> >> Wouldn't it make more sense the other way around?
> > 
> > I had the same thought.  Eventually I'd like this code
> > to mostly wither away ... using the regulator framework
> > for the hsmmc driver will eliminate most of the remaining
> > bits of twl4030-specific code.  So I'd just leave it be
> > for the moment.
> > 
> > 
> >> Doesn't the new regulator framework do it that way?
> > 
> > No; setting voltage and enabling are distinct operations.
> 
> Perhaps, but there are features like regulator constraints,
> or the Virtual regulator that do set the voltage and then
> enable.

Right, and I have most certainly configured regulators
with regulator_init_data.constraints.apply_uV so that
the VSEL gets set to a sane value as Linux sets up,
since u-boot wasn't touching it.

- Dave


