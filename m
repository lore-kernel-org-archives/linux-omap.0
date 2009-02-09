From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap_apollon_2420_defconfig
Date: Mon, 9 Feb 2009 12:53:20 -0800
Message-ID: <20090209205319.GH14200@atomide.com>
References: <20090209192614.GF19453@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51198 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZBIUxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 15:53:25 -0500
Content-Disposition: inline
In-Reply-To: <20090209192614.GF19453@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090209 11:27]:
> It would be nice to get the last OMAP defconfig in mainline working.
> It's broken since 2.6.29-rc2-git3 due to this persistent problem:
> 
> drivers/built-in.o: In function `omap_udc_probe':
> omap.c:(.init.text+0x30cc): undefined reference to `otg_get_transceiver'
> omap.c:(.init.text+0x38a4): undefined reference to `otg_put_transceiver'

Hmm, looks like 2bf5fa13fc8e34d7b86307b99f64a24cb7a83852 did not fix it.
Dave, do you already have a patch for this?

Regards,

Tony
