From: Tony Lindgren <tony@atomide.com>
Subject: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Mon, 28 Sep 2009 12:04:05 -0700
Message-ID: <20090928190404.GE18957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57395 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbZI1TEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 15:04:05 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1MsLW4-0002yE-C5
	for linux-omap@vger.kernel.org; Mon, 28 Sep 2009 19:04:08 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've updated our linux-omap tree to v2.6.32-rc1. I've also
added a branch omap-2.6.31 for the old code.

This time I also nuked the remaining omap legacy code we
still had lurking around :) The commits at the end of this
mail describe what I did first as commits, then I merged
everything to be the same as the mainline v2.6.32-rc1.

So currently the linux-omap master branch is:

v2.6.32-rc1 + omap-fixes + ehci + cbus

The new model is that I'll be resetting the linux-omap master
branch to mainline at each -rc, then merge in our various
upstream queues back in again.

Please note that "Remove omap extra version in Makefile"
commit means that you now need to set the ARCH and CROSS_COMPILE
for your compiler.

The good news is that now you can pull in the linux-omap master
branch into any Linux kernel tree without messing up the other
architectures.

Also note that "Remove DEBUG_LL hack to printk" means that
in order to get DEBUG_LL working, you need to patch printk.c
yourself. You can find the patch in the omap-debug branch.

As always, if something important got thrown out, please
send patches against the mainline tree to patch back in
the missing functionality!

Regards,

Tony


f286f075db630e2266ddd011248f4533b55e8f85 REMOVE OMAP LEGACY CODE: Remove omap extra version in Makefile
3dc42bd7663d0b40eeabb5d509f9ab6f969c9ede REMOVE OMAP LEGACY CODE: Remove old documentation
e1483467f256833d406a386ef3ec97f7f5bb3642 REMOVE OMAP LEGACY CODE: Remove arch/arm hacks
9f4eec944af394feb212b48e6a7c3947424edb16 REMOVE OMAP LEGACY CODE: Remove drivers/Makefile hacks
b99dcece4468584eb08f8646477b7f0ca0c27f0f REMOVE OMAP LEGACY CODE: Remove DEBUG_LL hack to printk
9275f8614fd98139ea465455335e06b4ac4de0c4 REMOVE OMAP LEGACY CODE: Remove hacks for booting P2
dc3df234a0187c81ab9c0355ac6b659e25b11b33 REMOVE OMAP LEGACY CODE: Remove drivers/cbus

