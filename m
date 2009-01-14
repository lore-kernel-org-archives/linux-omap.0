From: Tony Lindgren <tony@atomide.com>
Subject: Re: Important changes, please read
Date: Wed, 14 Jan 2009 16:11:00 +0200
Message-ID: <20090114141100.GL29324@atomide.com>
References: <20090114134152.GJ29324@atomide.com> <B3F388AE-0C4C-4790-B700-042A0F761620@student.utwente.nl> <20090114140938.GK29324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56649 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbZANOLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 09:11:00 -0500
Content-Disposition: inline
In-Reply-To: <20090114140938.GK29324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [090114 16:10]:
> * Koen Kooi <k.kooi@student.utwente.nl> [090114 16:01]:
> >
> > Op 14 jan 2009, om 14:41 heeft Tony Lindgren het volgende geschreven:
> >
> >> Hi all,
> >>
> >> I'll be merging in v2.6.29-rc1 soonish, and suggest that we make some
> >> changes to continue aligning our tree with the mainline tree. So
> >> I suggest:
> >>
> >> - We move the dspgateway code into a separate branch as discussed
> >>  earlier.
> >>
> >> - We stop using source.mvista.com git tree, and only use the
> >>  kernel.org git tree. There's no need for having two master trees,
> >>  and kernel.org is the standard way to go. Big thanks to
> >>  Monta Vista for hosting us for many years.
> >>
> >> - We reset arch/arm/mach-omap1 to be what's in the mainline and
> >>  tag that patch again with "REMOVE OMAP LEGACY CODE" so it's easy
> >>  to find later on. Naturally any code in that patch can be reworked
> >>  so it can be integrated to the mainline kernel.
> >>
> >> - We add a clocks branch maintained by Paul Walmsley that's based
> >>  off the mainline tree
> >>
> >> - We change the pm branch maintained by Kevin Hilman to be based
> >>  on top of the mainline tree
> >>
> >> Comments and suggestions anybody?
> >
> > Will there be some official 'staging' tree that pulls in trees like  
> > bridge, dss2, etc? I'm fine with pulling patches from this mailinglist, 
> > but a single source for gathering them would be nice.
> 
> We could have something like that that automatically merges those in.

A staging branch I mean.

> > Also, what's the medium and long term plan for the clocks and pm branch?
> 
> The clocks branch patches we should start sending to Russell asap so
> we can get them into the mainline kernel hopefully for the next merge
> window. Then we should start feeding the pm branch patches after
> the dependencies to the clock patches are merged.
> 
> 
> > regards,
> >
> > Koen
> >
> >
> >>
> >>
> >> BTW, I've also re-cloned the omap tree on kernel.org as it had
> >> tons of old objects that we don't need. It should not affect
> >> local trees, but report problems here. It will take a while
> >> to get mirrored, and some branches might be missing until
> >> mirroring is done.
> >>
> >> I have also set up and empty for-next branch that will contain
> >> the reviewed patches for next merge window. This will also get
> >> pulled into Stephen Rothwell's linux next tree on daily basis.
> >>
> >> Regards,
> >>
> >> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
