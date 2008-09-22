From: Tony Lindgren <tony@atomide.com>
Subject: Clock and domain patches pushed to l-o, queue to be prepared for
	RMK
Date: Mon, 22 Sep 2008 18:05:34 +0300
Message-ID: <20080922150532.GB8171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58402 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYIVPFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 11:05:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>

Hi all,

I've pushed a pile of patches from Paul to l-o tree:

[PATCH v2 0/7] OMAP2/3 clock: revise DPLL bypass handling in clock tree
[PATCH v2 00/11] OMAP2/3 clock: encode prcm_mod for each struct clk
[PATCH 0/5] OMAP2/3 clock: revise module idlest handling

Paul, could you please take all the pending clock and domain
patches and post them to LAKML so we can queue them for Russell?

You should be able to compress some add-fix-fix cycles out of them
into just add cycles :)

I'll leave out all the clock and domain patches from the pending
omap2-upstream series so they're independent patch sets. I'll post a
refreshed omap2-upstream at some point soonish to LAKML.

Regards,

Tony
