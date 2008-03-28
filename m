From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] PLAT: OMAP: Add device configuration to support
	second HSMMC slot on OMAP 2430 and 3430 boards.
Date: Fri, 28 Mar 2008 12:31:39 +0200
Message-ID: <20080328103138.GU24896@atomide.com>
References: <47E273BD.9080705@indt.org.br> <20080321004401.GA8667@ubuntu-workstation> <20080324021045.GA19892@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65022 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbYC1Kbk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:31:40 -0400
Content-Disposition: inline
In-Reply-To: <20080324021045.GA19892@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>, linux-omap@vger.kernel.org

* Seth Forshee <seth.forshee@gmail.com> [080324 04:12]:
> On Thu, Mar 20, 2008 at 07:44:02PM -0500, Seth Forshee wrote:
> > Shouldn't you only register each device if enabled in the corresponding
> > configuration, i.e.:
> > 
> > 	if (mmc_conf->mmc[1].enabled)
> > 		(void) platform_device_register(&mmc_omap_device1);
> > 	if (mmc_conf->mmc[2].enabled)
> > 		(void) platform_device_register(&mmc_omap_device2);
> 
> Of course that should be 0 and 1, not 1 and 2.

This sounds like a valid comment to me, so not pushing.

Tony
