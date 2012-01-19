From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 10:17:21 +0000
Message-ID: <WC20120119101721.07072A@terrafix.co.uk>
References: <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com> <20120113222045.37f9b4ec@notabene.brown> <1326870839.1954.23.camel@deskari> <20120118221538.342b4782@notabene.brown> <1326886940.1999.5.camel@lappy> <20120119073032.74cc0992@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:41721 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752492Ab2ASKRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 05:17:38 -0500
In-Reply-To: <20120119073032.74cc0992@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

...snip...
> 
>    cat /sys/kernel/debug/omapdss/clk
> 
> is below and reports 66461538 for fck, so 66MHz?  Still safe for OPP50.
> 
> And disabling SMART REFLEX had no obvious effect.
> 
> If you can think of anything else I could try to explore to narrow down
> the source of this, I am very happy to test or examine anything you
> suggest.
> 
> Thanks,
> NeilBrown
> 

I'm not sure if this will give you any pointers but i'll tell you what I'm fairly certain I'm seeing...

If I run the stock 3.2 with the changes to dss.c and dispc.c to make the pm_runtime_put()'s in to pm_runtime_put_sync()'s then the DSS warnings when 
suspending do indeed go away.

I have two wake sources, one being the UART the console is on and the other being a GPIO button.

I've tested the following situations:
 - If I sleep using the console and wake by typing a character then I *never* get a SYNC_LOST error.
 - If I sleep by pressing a button on the display (which does a system ("echo mem > /sys/power/state") and then wake by typing a character in to the console then 
I *never* get a SYNC_LOST error.
 - If I sleep by pressing a button on the display (which does a system ("echo mem > /sys/power/state") and then wake by pressing a button attached to the GPIO 
then I get a sequence of SYNC_LOST errors which continue at a rate of about one every 0.5 seconds until a type a character in to the console and then everything 
settles down and starts working again.

So, at least from what I'm seeing, the SYNC_LOST errors seem related somehow to the UART, if that is indeed possible?

Cheers,
Joe


