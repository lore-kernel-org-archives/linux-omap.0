From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP2420: mailbox: fix IVA vs DSP IRQ numbering
Date: Mon, 14 Feb 2011 13:20:07 -0800
Message-ID: <20110214212007.GM20795@atomide.com>
References: <1297454203-28298-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28914 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab1BNVUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 16:20:13 -0500
Content-Disposition: inline
In-Reply-To: <1297454203-28298-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110211 11:55]:
> The IRQ numbering for the IVA and DSP mailboxes was switched due
> to the wrong ordering in the OMAP2 mbox list.  Switch the ordering
> so DSP is first and matches all the other SoCs.
> 
> Tested on OMAP2420/n810.

I'll queue both as fixes for the -rc cycle.

Tony
