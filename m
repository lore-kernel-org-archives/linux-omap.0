From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] DMA clean-up for multi-boot
Date: Wed, 30 Apr 2008 10:13:58 -0700
Message-ID: <1209575641-25613-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54206 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262AbYD3ROD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 13:14:03 -0400
In-Reply-To: omap-dma-2008-04-30
References: omap-dma-2008-04-30
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi all,

Here are three patches to clean DMA code to support multi-boot
better. I have made quick testing on 24xx and 34xx only so far,
and things seem to work.

I will also do more testing, but I would appreciate if people would
give them a quick spin and see if anything breaks. Functionality
should be same as earlier.

I've removed direct DMA register access in few places such as
omap-hw.c, usb-udc.c, and various audio drivers. So especially
those areas should be tested carefully.

Regards,

Tony

