From: Paul Walmsley <paul@pwsan.com>
Subject: Re: About 1-Wire driver of OMAP4
Date: Mon, 17 Dec 2012 23:21:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212172250000.29833@utopia.booyaka.com>
References: <04b23e3459eb3657ab313de044c95c22@127.0.0.1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39844 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab2LQXVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 18:21:14 -0500
In-Reply-To: <04b23e3459eb3657ab313de044c95c22@127.0.0.1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herman516@totalbb.net.tw
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>

Hi

On Mon, 10 Dec 2012, herman516@totalbb.net.tw wrote:

> I implemented gas gauge driver by 1-Wire interface in OMAP4 CPU, the
> driver we used is a GPIO pin to simulate 1-Wire bus but it sometimes can't
> work well of timing issue. So we want to use HDQ/1Wire controller in OMAP4,
> does anyone have experience of OMAP4 1-Wire driver of using its controller?
> Our gas gauge is DS2780 and we use "android-omap-3.0" kernel branch. I
> tried to do below steps but it still can't work. Or do you have any
> suggestion? Thanks.
> 
> 1. Add hwmod of hdq1w in omap_hwmod_44xx_data.c file
> 2. Use omap_hdq.c file
> 3. Select "CONFIG_HDQ_MASTER_OMAP", "CONFIG_W1", "CONFIG_HDQ_MASTER_OMAP"
> and "CONFIG_BATTERY_DS2780" in menuconfig.

HDQ1W should work on OMAP3 in mainline if the 

hdq_experimental_idle_fix_3.5

branch of

git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-devel.git

is added in.  (Of course, it will have to be forward-ported to take 
account of the recent common clock framework changes.)

But that branch won't help the OMAP4 situation, since it doesn't have 
explicit interface clock autoidle control.  The question here is whether 
the OMAP4 has the same hardware idle handling bug that the OMAP3 did.  If 
so, you might have to enable another IP block in the L4_PER clockdomain 
while the HDQ is active :-( It might also be possible to keep the L4_PER 
clockdomain in software-supervised mode; not sure.

So.  You might want to try backporting the HDQ driver in current mainline, 
along with the relevant hwmod integration data and any associated hwmod 
code, to the 3.0 Android kernel you're using.  Then if that doesn't help, 
maybe try the l4_per hacks mentioned above.

With regards to OMAP3, we still need to plug in a more permanent fix for 
mainline.  Unfortunately it's fallen down the priority ladder :-(


- Paul
