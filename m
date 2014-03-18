From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4 SDP regression...
Date: Mon, 17 Mar 2014 18:35:07 -0700
Message-ID: <20140318013507.GD30471@atomide.com>
References: <20140317233229.GP21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65417 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbaCRBfM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 21:35:12 -0400
Content-Disposition: inline
In-Reply-To: <20140317233229.GP21483@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@linaro.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140317 16:35]:
> There's been a couple of regressions on OMAP4430 SDP I've only recently
> noticed:
> 
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=1597
> 
> Configuring network interfaces... udhcpc (v1.9.1) started
> Sending discover...
> Sending discover...
> Sending discover...
> No lease, failing
> done.
> 
> No link lights come up either.  The hardware is fine because uboot manages
> to successfully tftp the kernel.
> 
> It looks like it was working in -rc4+armsoc and -rc5+armsoc, but not
> -rc6+armsoc.
> 
> From what I can see, nothing has changed in drivers/net/ethernet/micrel/
> since rc5.
> 
> I've been through the delta from 3.14-rc5, and I don't see anything
> obvious.  Any ideas?  Known problem?

Seems like plain v3.14-rc6 fails for me while -rc5 works. Bisecting
points to:

66fda75f regulator: core: Replace direct ops->disable usage

Also verified that v3.14-rc6 with 66fda75f reverted also works.

Markus & Mark, any ideas?

Regards,

Tony
