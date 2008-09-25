From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Updates for i2c-omap from linux-omap tree for review
Date: Thu, 25 Sep 2008 10:16:26 +0300
Message-ID: <1222326994-26836-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55318 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYIYHQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:16:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi all,

This series contains pending i2c-omap patches from linux-omap tree
for review.

Looks like we've managed to pile up stuff in the omap tree for this
driver again... Anyways, future patches will be coming straight via
the i2c list.

The first two patches could be pushed as fixes to current -rc series,
but I'm fine with them going in later too.

I've left out some clean-up from the last patch so it won't conflict with
omap ioremp changes that are currently in Russell King's devel
branch.

Regards,

Tony
