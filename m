From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix I/O chain clock line assertion timed out
 error
Date: Fri, 12 Sep 2014 13:39:41 -0500
Message-ID: <20140912183941.GA15272@kahuna>
References: <1410544222-25913-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbaILSkI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2014 14:40:08 -0400
Content-Disposition: inline
In-Reply-To: <1410544222-25913-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

On 10:50-20140912, Tony Lindgren wrote:
> We are getting "PRM: I/O chain clock line assertion timed out" errors
> on early omaps for device tree based booting. This is because we are
> unconditionally calling reconfigure_io_chain while legacy booting
> has omap3_has_io_chain_ctrl() checks in place in omap_hwmod.c.
> 
> For device tree based booting, we are calling reconfigure_io_chain
> unconditionally from pinctrl framework. So we need to add a check for
> omap3_has_io_chain_ctrl() to avoid the errors for trying to access
> a register that does not exist.
> 
> For es3.0, the documentation in "4.11.2 Device Off-Mode Configuration"
> just mentions PM_WKEN_WKUP[8] bit. For es3.1, there's a new chapter in
> documentation for "4.11.2.2 I/O Wake-Up Mechanism" that describes the
> PM_WKEN_WKUP[16] ST_IO_CHAIN bit. So PM_WKEN_WKUP[16] bit did not get
> added until in es3.1 probaly to fix issues with flakey wake-up events.
> 
> We are doing proper checks for ST_IO_CHAIN already in id.c and with
> omap3_has_io_chain_ctrl(). For more information, see also commit
> b02b917211d5 ("ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
> control detection").
> 
> Let's fix the issue by selecting the right function during init for
> reconfigure_io_chain depending on the omap revision. For es3.0 and
> earlier we need to just toggle EN_IO. By doing this, we can move the
> check for omap3_has_io_chain_ctrl() from omap_hwmod.c to the init code
> in prm_3xxx.c. And then we can unconditionally call reconfigure_io_chain.
> 
> Thanks to Paul Walmsley and Nishanth Menon for help with debugging the
> issue.
> 
> Fixes: 30a69ef785e8 ("ARM: OMAP: Move DT wake-up event handling over to use pinctrl-single-omap")
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
