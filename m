From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: git pull request for minimal omap3 support one more time
Date: Wed, 15 Oct 2008 09:02:50 +0300
Message-ID: <20081015090250.d32cf7f7.jarkko.nikula@nokia.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
	<dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com>
	<20081004070534.GB30190@muru.com>
	<20081009145436.GI435@flint.arm.linux.org.uk>
	<20081009151724.GK26230@atomide.com>
	<20081010073251.GN435@flint.arm.linux.org.uk>
	<20081010091557.GI3044@atomide.com>
	<20081010092520.GK3044@atomide.com>
	<20081010113533.GU3044@atomide.com>
	<20081013133256.GA3510@flint.arm.linux.org.uk>
	<20081014171907.GD8150@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57718 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbYJOGDs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 02:03:48 -0400
In-Reply-To: <20081014171907.GD8150@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, 14 Oct 2008 10:19:08 -0700
"ext Tony Lindgren" <tony@atomide.com> wrote:

> > Please take a look and resolve ASAP.  Thanks.
> 
> Sorry for the delay, I was sitting in an airplane again.
> 
> Here's the fix, looks like the missing McBSP irqs should have been
> merged into the recent McBSP patches.
> 
> This patch is also in your patch system as 5301/1.
> 
Tony,

If my patch below from linux-omap was forgotten from original pull
request, please note that it's required to add those rx/tx irqs into
omap_mcbsp_platform_data structs in arch/arm/mach-omap2/mcbsp.c as
well. Otherwise arch/arm/plat-omap/mcbsp.c: omap_mcbsp_request will
fail when requesting zero defined irqs.

Sorry, not noting this before.


Jarkko

commit c29cfcead32c8dcb9738a085d498aebe6ab160af
Author: Jarkko Nikula <jarkko.nikula@nokia.com>
Date:   Tue Sep 16 15:56:53 2008 +0300

    ARM: OMAP: Add RX/TX interrupts for 2430 and 34xx McBSP ports 3-5
    
    Without RX and TX interrupt definitions, the omap_mcbsp_request will
    fail on OMAP2430 and OMAP34xx for ports 3-5 since default io_type is
    OMAP_MCBSP_IRQ_IO.
