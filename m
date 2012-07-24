From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Tue, 24 Jul 2012 01:16:38 -0700
Message-ID: <20120724081636.GT6522@atomide.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com>
 <20120713064713.GI1122@atomide.com>
 <20120714085257.GB6522@atomide.com>
 <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
 <20120716083609.GG6522@atomide.com>
 <alpine.DEB.2.00.1207180341001.16772@utopia.booyaka.com>
 <20120719115216.GP6522@atomide.com>
 <alpine.DEB.2.00.1207191242080.14390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12293 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab2GXIQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 04:16:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207191242080.14390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120719 12:17]:
> On Thu, 19 Jul 2012, Tony Lindgren wrote:
> 
> > Well I'm still a bit confused :)
> > 
> > Which branch in arm-soc tree should this fix be applied then?
> 
> In terms of arm-soc, it's needed in arm-soc for-next, due to commit 
> 066b6eba6d58ad1cb9ec3917b6ee79730c3c3310 ("Merge branch 'next/cleanup' 
> into for-next").  That merge commit resolves the conflict the same way 
> that the linux-omap tree commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 
> ("Merge tag 'omap-cleanup-for-v3.6' into tmp-merge") did.
> 
> 066b6eba is also present in a few other arm-soc branches:
> 
>   arm-soc/staging/io-cleanup-pci
>   arm-soc/tmp
> 
> I did not do an exhaustive search for similar mismerges under different 
> commit IDs.

OK looks like Linus fixed up part of it, care to check what's needed
against current mainline now?

Tony
