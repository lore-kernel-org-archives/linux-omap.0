From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Init updates for hsmmc, also second controller
Date: Thu, 30 Oct 2008 19:04:13 -0700
Message-ID: <1225418657-31775-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50456 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbYJaCET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:04:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi all,

I've been preparing the hsmmc code for mainline so we can mount root.
Here are the related changes for linux-omap for initializing the hsmmc.

This also makes the second controller work, at least on 3430sdp.

If anybody is interested in using the hsmmc with mainline, I've posted
my current patch series to:

http://www.muru.com/linux/omap/patches/hsmmc-2008-10-30.tar.gz

I'll be feeding these patches upstream, but that won't hit mainline
until next merge window.

Regards,

Tony
