From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add support for OMAP3Stalker boards
Date: Mon, 10 May 2010 09:42:10 -0700
Message-ID: <20100510164210.GB16460@atomide.com>
References: <000501cabadc$711651a0$5342f4e0$@com>
 <20100504225952.GQ29604@atomide.com>
 <00ce01caecc1$c2431560$46c94020$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62036 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab0EJQmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:42:11 -0400
Content-Disposition: inline
In-Reply-To: <00ce01caecc1$c2431560$46c94020$@com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason <lzg@ema-tech.com>
Cc: linux-omap@vger.kernel.org

* Jason <lzg@ema-tech.com> [100505 19:09]:
> 
> A question about board version. Is it good to do a hardware check to find
> out hardware version?
>  Like function static void __init omap3_evm_get_revision(void) in
> board-omap3evm.c

Sure, that's the best option.

Some boards are also using the system_rev, which contains the
ATAG_REVISION passed from the bootloader. But then you depend on
the bootloader to pass it.. So hardare detection early on is
the most flexible way of doing this.

Regards,

Tony
