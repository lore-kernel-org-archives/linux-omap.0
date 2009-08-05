From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after
	irq_disable
Date: Wed, 5 Aug 2009 18:11:00 +0300
Message-ID: <20090805151059.GT7374@atomide.com>
References: <B00E06E2766C2744B022DE9BAF3C59D532D196@zmy16exm69.ds.mot.com> <20090805123354.GF7374@atomide.com> <877hxi9vl7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55563 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933080AbZHEPLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 11:11:07 -0400
Content-Disposition: inline
In-Reply-To: <877hxi9vl7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Wang Sawsd-A24013 <cqwang@motorola.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [090805 17:36]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Hi,
> >
> > Sorry for the long delay on replying to this one.
> 
> Tony, this one has been superceded, and the irq_enable/disable stuff no
> longer is needed due to the patch
> 
>   OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask
> 
> from my PM fixes queue.
> 
> An updated version (currently in the PM branch) is here:
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=c80a909697ad931ffad9d30ed321469fa699b208

OK, thanks.


> 
> but...
> 

<snip>

> > To me it looks like the right way to deal with the level gpio
> > would be to change it temporarily to be edge for the duration of
> > idle, then change it back to be level after returning from idle.
> 
> Not sure about that.  That would have to be experimented with to 
> see if there are any other side effects.
> 
> In any case, that kind of change would be independent of this change
> as this change just fixes a bug so wake-enables are only set on
> edge-triggered GPIOs.

OK. Just FYI, I think I experimented on that for 2420 at some point
and it worked, but that was several years ago.

Tony

