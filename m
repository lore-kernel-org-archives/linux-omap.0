From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESUBMIT PATCH] ARM: OMAP2+: am33xx: Add low level debugging
 support
Date: Tue, 5 Jun 2012 00:50:41 -0700
Message-ID: <20120605075040.GG12766@atomide.com>
References: <1336639981-27194-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA39248@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50105 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2FEHup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 03:50:45 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA39248@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120528 23:17]:
> On Thu, May 10, 2012 at 14:23:01, Hiremath, Vaibhav wrote:
> > From: Afzal Mohammed <afzal@ti.com>
> > 
> > Add support for low level debugging on AM335X EVM (AM33XX family).
> > Currently only support for UART1 console, which is used on AM335X EVM
> > is added.
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> > This patch had been Reviewed and accepted earlier, but got
> > missed during last merge window. Resubmitting again, without
> > code-change.
> > 
> >  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++++++-
> >  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
> >  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
> >  3 files changed, 26 insertions(+), 1 deletions(-)
> > 
> 
> Tony,
> 
> Can this be merged now???

Yes applying into devel-am33xx branch.

Regards,

Tony
