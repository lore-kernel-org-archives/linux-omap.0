From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/0] Power domain and clock domain patches for omap
Date: Wed, 16 Jul 2008 18:19:05 +0300
Message-ID: <1216221555-18958-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59662 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045AbYGPPRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 11:17:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi all,

This patch series contains power domain and clock domain specific patches
for omap posted to linux-arm-kernel list during 2.6.25-rc5.

I'm reposting the series to a wider audience as Russell King suspected that
other archs may be interested in reviewing these too, or at least some
parts of the code.

Please take a look and comment the code. Also please point out the pieces of
code that may be suitable for your arch too!

This patch series also available via git at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap2-clock

Regards,

Tony
