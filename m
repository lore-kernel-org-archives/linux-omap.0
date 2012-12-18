From: =?big5?B?SGVybWFuTWFvKKTyp7ukryk=?= <Herman516@totalbb.net.tw>
Subject: RE: About 1-Wire driver of OMAP4
Date: Tue, 18 Dec 2012 21:47:20 +0800
Message-ID: <CF179A504B3E42DD8C317D3CE445A231@hermannb>
References: <04b23e3459eb3657ab313de044c95c22@127.0.0.1> <alpine.DEB.2.00.1212172250000.29833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from msr7.hinet.net ([168.95.4.107]:35708 "EHLO msr7.hinet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807Ab2LRNsE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Dec 2012 08:48:04 -0500
In-Reply-To: <alpine.DEB.2.00.1212172250000.29833@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, 'NeilBrown' <neilb@suse.de>

Hi Paul,

Thanks your suggestion, I will take a look.

Regards,
Herman

-----Original Message-----
From: Paul Walmsley [mailto:paul@pwsan.com] 
Sent: Tuesday, December 18, 2012 7:21 AM
To: herman516@totalbb.net.tw
Cc: linux-omap@vger.kernel.org; NeilBrown
Subject: Re: About 1-Wire driver of OMAP4

Hi

On Mon, 10 Dec 2012, herman516@totalbb.net.tw wrote:

> I implemented gas gauge driver by 1-Wire interface in OMAP4 CPU, the
> driver we used is a GPIO pin to simulate 1-Wire bus but it sometimes can't
> work well of timing issue. So we want to use HDQ/1Wire controller in
OMAP4,
> does anyone have experience of OMAP4 1-Wire driver of using its
controller?
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

