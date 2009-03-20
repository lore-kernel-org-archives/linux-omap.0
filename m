From: David Brownell <david-b@pacbell.net>
Subject: Re: PM branch rebased to 2.6.29
Date: Fri, 20 Mar 2009 12:46:50 -0700
Message-ID: <200903201246.51202.david-b@pacbell.net>
References: <87bprz9zju.fsf@deeprootsystems.com> <200903191520.55565.david-b@pacbell.net> <20090320185927.GR29546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n10.bullet.mail.mud.yahoo.com ([209.191.125.208]:25135 "HELO
	n10.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760816AbZCTTqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2009 15:46:55 -0400
In-Reply-To: <20090320185927.GR29546@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Friday 20 March 2009, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [090319 15:27]:
> > 
> >  * Least hassle ... I think all these should merge to the
> >    linux-omap tree in any case (and thence linux-pm):
> > 
> >     http://marc.info/?l=linux-omap&m=123699264117846&w=2
> >     http://marc.info/?l=linux-omap&m=123699340818395&w=2
> >     http://marc.info/?l=linux-omap&m=123705919713239&w=2
> 
> Pushed these. That way we'll end up with a working
> 2.6.29-omap1 :)

I approve that message.  ;)


> Dave, got a version of the third patch above against the
> mainline kernel? That could be added to the omap3-boards
> queue for the upcoming merge window.

That patch was a bit messy ... combined the VPLL2 bits,
and the twl4030-power bits.  The former can go to mainline,
but only after the regulator framework updates for VPLL2;
I'll make such a patch.  The latter needs twl4030-power to
get to mainline ...


> > The second fix -- in some flavor -- is IMO still needed,
> > since the first fix is just avoiding regulator framework
> > bugs.  
> 
> To me it sounds like the regulator framework should eventually
> handle the regulators left on by the bootloader. Just let me
> know if some other patches are needed to l-o tree meanwhile.

I may just prepare an mmc-twl4030 patch with ugly workarounds,
since I'm getting the strong feeling that it'll take forever
to get the regulator framework fixed in that area.

Meanwhile, I suggest merging the updated version of the Overo
patch, as sent by Steve.

- Dave


