From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Thu, 21 Aug 2008 14:55:16 +0300
Message-ID: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55552 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbYHUL4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 07:56:13 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7LBtonc020739
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 14:56:10 +0300
Received: from localhost.localdomain (esdhcp04165.research.nokia.com [172.21.41.65])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7LBtMwC002927
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 14:55:22 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here are two patches adding support for OMAP2430 in McBSP driver and
adding support for 2430 and 34xx in ASoC OMAP McBSP DAI driver.

These are generated from top of currect l-o head but they apply also on
top of Hiroshi's virtual clock patches with some offsets.

If you have change to try them out on those CPUs, I would be happy to
hear. I've tested these only on N810. Second patch will naturally go
through the alsa-devel when we have necessary McBSP patches upstream.

-- 
Jarkko
