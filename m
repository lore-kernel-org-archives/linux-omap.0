From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Wed, 7 Dec 2011 13:10:29 -0800
Message-ID: <20111207211029.GL31337@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-1-git-send-email-hvaibhav@ti.com>
 <87y5up44bf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38587 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab1LGVKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 16:10:31 -0500
Content-Disposition: inline
In-Reply-To: <87y5up44bf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

* Kevin Hilman <khilman@ti.com> [111206 15:52]:
> <hvaibhav@ti.com> writes:
> 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > This patch set adds support for AM335x device having
> > Cortex-A8 MPU.
> >
> > Official website - http://www.ti.com/product/am3359
> >
> > AM335X is treated as another OMAP3 variant, where,
> > along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> > and the respective type is AM335X, which is newly added device in
> > the family.
> > This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> > cpu_is_am335x() checks return success for AM335X.
> >
> > Also, I have validated OMAP3 boot test with this patch-series on
> > OMAP3EVM.
> 
> Tony, this series looks good to me.
> 
> I've also tested it on a BeagleBone, so feel free to also add:
> 
> Tested-by: Kevin Hilman <khilman@ti.com>

Thanks looks good to me. We still need the machine_id update to
apply patches 2 and 3 in this series, so applying only the first
patch into soc branch for now.

Tony
