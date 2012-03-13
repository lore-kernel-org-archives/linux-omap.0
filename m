From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/12] ARM: OMAP2+: board-omap4-*: Do not use anymore
 TWL6030_IRQ_BASE in board files
Date: Tue, 13 Mar 2012 10:07:57 -0700
Message-ID: <20120313170756.GK12083@atomide.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-13-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53030 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757564Ab2CMRIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 13:08:01 -0400
Content-Disposition: inline
In-Reply-To: <1330707024-23730-13-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: sameo@linux.intel.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [120302 08:19]:
> With the introduction of dynamically allocated IRQ in the twl6030 driver,
> the board files can no longer rely of static IRQ defines like before.
> 
> Retrieve the value dynamically allocated from the mmc -> twl6030 init
> callback.
> 
> Note: The Panda board does not seems to use the card detect IRQ.

Looks like this one is safe to merge via MFD and does not seem to
cause any merge conflicts.

This one should be folded into patch 08/12 to avoid boot issues
for between patches 08 and 12 in this series. Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
