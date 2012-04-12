From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Thu, 12 Apr 2012 02:26:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60252 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759703Ab2DLI0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 04:26:07 -0400
In-Reply-To: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hello Vaibhav,

On Fri, 30 Mar 2012, Vaibhav Hiremath wrote:

> After some healthy discussion, now we have come to the conclusion and
> decided to handle AM33XX PRM/CM part separately; as AM33XX-PRCM module is
> different than OMAP3 and OMAP4 architecture.

Have been reviewing these patch sets here.  Are these associated with any 
board file?  I had to hand-apply several patch sets due to some 
differences in mach-omap2/io.c.  Upon looking more closely, and looking at 
your GitHub branch:

https://github.com/hvaibhav/am335x-linux/tree/am335x-prm-cm

it seems that internally you've been modifying the AM3517 EVM board file 
to test the BeagleBone?  But due to the init_early changes, this is 
presumably not going to work if we want to keep the AM3517EVM working -- 
is this your understanding as well?

I'm kind of wondering how we're to test these...

...

BTW, the branch that I'm experimenting with is at 
git://git.pwsan.com/linux-2.6 -- branch name 'am33xx_support_3.5' -- I am 
still reviewing the patches there.


- Paul
