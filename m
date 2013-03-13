From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RFC 0/2] ARM: OMAP: dma.h cleanup
Date: Wed, 13 Mar 2013 22:15:47 +0200
Message-ID: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:55520 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456Ab3CMUQD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 16:16:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com

I don't know is this good or bad idea, thus RFC.

I got this idea after noticing that McBSP DMA channel definitions are no
longer used for OMAP2 and EAC DMA channel were never used in upstream.
Scripts here are used to remove all of those unused ones.

Build tested with omap1_defconfig and omap2plus_defconfig.

-- 
Jarkko
