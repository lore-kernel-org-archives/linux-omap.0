From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Wed, 30 Sep 2009 10:31:33 -0700
Message-ID: <20090930173132.GN16865@atomide.com>
References: <20090928190404.GE18957@atomide.com> <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com> <20090929182639.GA16865@atomide.com> <4AC37F0E.8010206@nokia.com> <71a0d6ff0909301002k7e56b7falfdc8d5e445487d29@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64024 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbZI3Rbf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 13:31:35 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Alexander Shishkin <virtuoso@slind.org>, Roger Quadros <ext-roger.quadros@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [090930 10:05]:
> > >>
> > >>>
> > >>> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
> > >>> other people report similar issues:
> > >>> http://www.spinics.net/lists/linux-omap/msg17968.html
> > >>>
> > >>> Have you got 2.6.32-rc1 (+fixes) to boot?
> > >>
> > >> Hmm, looks like it's musb again. This is what I get on my
> > >> overo after applying the DEBUG_LL hack from omap-debug branch:
> > >
> > > i've just sent a fix for this musb problem. patch is labelled "twl4030: Fix
> > > boot with twl4030 usb transceiver enabled"
> > 
> > I can't quite locate it in linux-usb archives (or anywhere within
> > google's reach). Could you sand it here or provide a link?
> > 
> 
> Here you go. Patchwork rocks!
> 
> <http://patchwork.kernel.org/patch/50721/>
> 

Great, thanks. Roger, please send your fix to Samuel for merging.

Meanwhile, I'll apply it into fixes-testing while waiting for it
to get to mainline via Samuel.

Regards,

Tony
