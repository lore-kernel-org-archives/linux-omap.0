From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [htcherald] Add board support for UARTs, bluetooth
Date: Mon, 5 Jul 2010 16:23:30 +0300
Message-ID: <20100705132329.GA15951@atomide.com>
References: <1275431571-28547-1-git-send-email-darkstar6262@gmail.com>
 <1275431571-28547-4-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51754 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab0GENXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 09:23:34 -0400
Content-Disposition: inline
In-Reply-To: <1275431571-28547-4-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100602 01:27]:
> This change adds bluetooth and UART initialization support to the
> HTC Herald board driver.  This allows use of the serial bluetooth
> adapter attached to UART1 using hciattach.
> 
> The defconfig was updated to add in bluetooth core support, as well
> as to clean up some unneeded cruft.

This one needs to be updated to leave out the defconfig changes as
we won't be patching those any longer.

Regards,

Tony
