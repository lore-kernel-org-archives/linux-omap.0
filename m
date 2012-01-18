From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Wed, 18 Jan 2012 08:47:06 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A958F@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-1-git-send-email-hvaibhav@ti.com> <87y5up44bf.fsf@ti.com>
 <20111207211029.GL31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153Ab2ARIrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 03:47:15 -0500
In-Reply-To: <20111207211029.GL31337@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>

On Thu, Dec 08, 2011 at 02:40:29, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [111206 15:52]:
> > <hvaibhav@ti.com> writes:
> > 
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > This patch set adds support for AM335x device having
> > > Cortex-A8 MPU.
> > >
> > > Official website - http://www.ti.com/product/am3359
> > >
> > > AM335X is treated as another OMAP3 variant, where,
> > > along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> > > and the respective type is AM335X, which is newly added device in
> > > the family.
> > > This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> > > cpu_is_am335x() checks return success for AM335X.
> > >
> > > Also, I have validated OMAP3 boot test with this patch-series on
> > > OMAP3EVM.
> > 
> > Tony, this series looks good to me.
> > 
> > I've also tested it on a BeagleBone, so feel free to also add:
> > 
> > Tested-by: Kevin Hilman <khilman@ti.com>
> 
> Thanks looks good to me. We still need the machine_id update to
> apply patches 2 and 3 in this series, so applying only the first
> patch into soc branch for now.
> 
Tony,

Can you also merge this patch, as machine_id for am335x-evm is already
updated in linus/master?

Thanks,
Vaibhav

> Tony
> 

