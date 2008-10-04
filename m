From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] ARM: OMAP: Fixes to omap_mcbsp_request function
Date: Sat, 4 Oct 2008 15:37:12 +0100
Message-ID: <20081004143712.GE16636@flint.arm.linux.org.uk>
References: <1222262955-13599-1-git-send-email-tony@atomide.com> <1222262955-13599-2-git-send-email-tony@atomide.com> <1222262955-13599-3-git-send-email-tony@atomide.com> <1222262955-13599-4-git-send-email-tony@atomide.com> <1222262955-13599-5-git-send-email-tony@atomide.com> <1222262955-13599-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40636 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbYJDOhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 10:37:23 -0400
Content-Disposition: inline
In-Reply-To: <1222262955-13599-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

On Wed, Sep 24, 2008 at 04:29:15PM +0300, Tony Lindgren wrote:
> From: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Bootloader may let McBSP logic running so make sure that block is idle
> before requesting IRQs. Also make sure that TX and RX waitqueues are
> initialized before request_irq.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Ok.
