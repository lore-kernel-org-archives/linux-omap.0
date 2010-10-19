From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next - multi-omap image fails to boot on omap3/4
Date: Tue, 19 Oct 2010 11:21:50 -0700
Message-ID: <20101019182149.GC3038@atomide.com>
References: <4CBDAFFF.2030409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58756 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab0JSSVx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 14:21:53 -0400
Content-Disposition: inline
In-Reply-To: <4CBDAFFF.2030409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

* Anand Gadiyar <gadiyar@ti.com> [101019 07:41]:
> Hi all,
> 
> linux-next, as of 20101019, built with the omap2plus_defconfig fails
> to boot on omap3 and omap4. (I've disabled CONFIG_ARCH_OMAP2 or
> CONFIG_SWP_EMULATE to get the image to build). Building with only
> ARCH_OMAP3 allows the resultant image to boot up on OMAP3. Likewise,
> an image built with only ARCH_OMAP4 boots up on OMAP4 boards.
> 
> earlyprintk does not provide any additional prints after
> "Uncompressing Linux... done, booting the kernel."
> 
> Any ideas where to look?

Hmm I did a quick test merge of linux-omap master and rmk/devel
branches and that boots just fine.

So it's probably something that already got fixed in rmk/devel
but is not yet in next, or something that came from elsewhere,
or something that we have in omap-testing branch that's not in
for-next for some reason.

Regards,

Tony
