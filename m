From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/14] Big clean-up for multi-omap
Date: Tue, 27 May 2008 21:20:04 -0700
Message-ID: <1211948418-16455-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64496 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbYE1EUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:20 -0400
In-Reply-To: multi-omap-2008-05-27-212014
References: multi-omap-2008-05-27-212014
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi all,

Following patches clean up blockers for getting multi-omap closer
to working for omap2 like we have for omap1:

- Remove __REG macros, use omap_read/write() instead

- Split omap24xx sram code so no register rewriting is needed

- Introduce struct omap_globals to allow early cpu detection to
  work

- Make PRM and CM registers work for multi-omap

The __REG patches were posted earlier, but had some issues. They
should be fixed now.

The first patch is to test primitive omap type detection with
DEBUG_LL. Could somebody please try it out on 15xx and make sure
you get output from DEBUG_LL?

Once the DEBU_LL patch works on all omaps, we can use the similar
detection for multi-omap non-optimized get_irq_nr_and_base too :)

These patches are against current linux-omap tree, I pushed few
fixes there so you pull before trying out these patches.

Regards,

Tony

