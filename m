From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Thu, 8 Dec 2011 09:18:54 -0800
Message-ID: <20111208171854.GB31337@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-1-git-send-email-hvaibhav@ti.com>
 <87y5up44bf.fsf@ti.com>
 <20111207211029.GL31337@atomide.com>
 <79CD15C6BA57404B839C016229A409A8050F6D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15475 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1LHRS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 12:18:57 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8050F6D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>

Russell,

* Hiremath, Vaibhav <hvaibhav@ti.com> [111208 05:14]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > * Kevin Hilman <khilman@ti.com> [111206 15:52]:
> > >
> > > I've also tested it on a BeagleBone, so feel free to also add:
> > >
> > > Tested-by: Kevin Hilman <khilman@ti.com>
> > 
> > Thanks looks good to me. We still need the machine_id update to
> > apply patches 2 and 3 in this series, so applying only the first
> > patch into soc branch for now.
> 
> Tony,
> 
> Should I ping Russell for this? The machine-id patch is already registered
> and present at
> 
> http://www.arm.linux.org.uk/developer/machines/download.php

Care to push the machine_id updates into devel-stable?

Regards,

Tony
