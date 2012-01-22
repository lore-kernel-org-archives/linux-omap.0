From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Sat, 21 Jan 2012 17:07:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown> <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com> <20120114100915.01c96727@notabene.brown> <20120118082410.48262777@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60824 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab2AVAHV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 19:07:21 -0500
In-Reply-To: <20120118082410.48262777@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Wed, 18 Jan 2012, NeilBrown wrote:

> Oh - another thing.
> Sometimes during early boot I get:
> 
> [    0.158447] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
> [    0.176879] omap_hwmod: hdq: softreset failed (waited 10000 usec)

This latter bug just got fixed, it's updated in the new HDQ series that I 
sent out:

http://marc.info/?l=linux-omap&m=132719073710874&w=2

BTW, if you could give that a spin for us at some point, it would be 
greatly appreciated; I don't think I have a board with a 1-wire device on 
it (at least, not that I know of).

> At the same time the UART seem to hiccup and my USB-Serial port loses track
> and doesn't see any more characters until I close and re-open.
> 
> Could that be related?  Any idea what it means?

It shouldn't be related.


- Paul
