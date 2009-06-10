From: Tony Lindgren <tony@atomide.com>
Subject: Important changes, bunch of legacy code removed from linux-omap
	tree
Date: Wed, 10 Jun 2009 06:56:17 -0700
Message-ID: <20090610135616.GH2617@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51175 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbZFJN4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 09:56:18 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1MEOHs-000NQp-96
	for linux-omap@vger.kernel.org; Wed, 10 Jun 2009 13:56:20 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I've pushed a big pile of patches that take us to sync with what's about to get
merged to the mainline kernel. So we'll be using the mainline omap code that is
already queued up to go in this merge window for 2.6.31. It's basically a
backport of omap code that will be in 2.6.31 to 2.6.30.

This means that tons of legacy code got removed. That needs to be worked to
get it to mainline, so some people may want to carry those patches along in
their tree for a while. Apologies for doing it so late in the game with 2.6.30
out already, but after diffing and thinking about it for a few days, that just
seemed like the sanest way to go forward.

This will also make it way easier for us to merge in various topic branches
such as Kevin's PM branch and Tomi's DSS branch as all the topic branches are
(or at least should be) done against the mainline tree.

Also all the board-*.c files got reset to their mainline versions. So all 
board-*.c maintainers, please send patches against the mainline kernel to add
back any of the lost functionality! Help is really needed now to get the
remaining board-*.c patches done and queued up for mainline.

I've left in the base N8x0 stuff so we can clean that up for mainline as
discussed earlier. For the SDP boards, we should put together a generic
sdp-flash.c board init file and get that to mainline too.

If you want to see what legacy code has been removed, just do:

$ git log --grep="REMOVE OMAP LEGACY CODE"

Some of this code has been merged back from Imre's fb-upstream branch, and
Hiroshi's iommu branch. Looks like Paul's omap-clock-upstream branch needs
to be refreshed in order to merge it. We should also start merging in
Kevin's PM branch and Tomi's DSS2 branch as soon as they are available.

For the other legacy code, at least the following changes need to be done:

- The gpio-switch.c should be replaced with a combination of gpio-keys.c
  and gpiolib, where gpio-keys handles input events, and gpiolib can handle
  toggling of the GPIO pins from userspace.

- Omap specific ATAGs should not be used as they are not going to get
  into mainline as discussed earlier. Instead, standard cmdline options
  should be used. If ATAGs are needed, they should be ARM generic.
  Also the open firmware device tree might offer a solution to replace
  the omap specific ATAGs.

I'll branch out omap-2.6.30 by 2.6.31-rc1, so let's try to sort out the
remaining issues by then.

Cheers,

Tony


