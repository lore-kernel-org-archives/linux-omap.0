From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap3beagle: add a platform device to hook up the
	GPIO leds to the leds-gpio driver
Date: Tue, 10 Jun 2008 17:49:37 -0700
Message-ID: <20080611004937.GQ23796@atomide.com>
References: <1212195566-22695-1-git-send-email-k.kooi@student.utwente.nl> <96F02D3C-315B-4D51-812F-8E8B1C592B1A@student.utwente.nl> <20080610213106.GO23796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54883 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYFKAti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 20:49:38 -0400
Content-Disposition: inline
In-Reply-To: <20080610213106.GO23796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [080610 14:35]:
> * Koen Kooi <k.kooi@student.utwente.nl> [080610 14:26]:
> > 
> > Op 31 mei 2008, om 02:59 heeft Koen Kooi het volgende geschreven:
> > 
> > > From: Koen Kooi <koen@openembedded.org>
> > >
> > > omap3beagle: add a platform device to hook up the GPIO leds to the  
> > > leds-gpio driver
> > > * on revision A5 and earlier board the two leds can't be controlled  
> > > seperately, should be fixed in rev. B and C boards.
> > >
> > > Changes since v1: indented structs with tabs
> > >
> > > Signed-off-by: Koen Kooi <koen@openembedded.org>
> > 
> > 
> > Any objections against applying this patch?
> 
> Nope, and blinking leds are always considered the highhest priority
> patches ;) Pushing today.

Actually I ended up reformatting it a bit more.

Tony
