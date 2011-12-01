From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Thu, 1 Dec 2011 11:07:18 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A80474FD@DBDE01.ent.ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
 <878vmxxjrv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57313 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab1LALHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 06:07:35 -0500
In-Reply-To: <878vmxxjrv.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, Russell King <rmk@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, December 01, 2011 5:09 AM
> To: Hiremath, Vaibhav; Russell King
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux-arm-
> kernel@lists.infradead.org; paul@pwsan.com
> Subject: Re: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
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
> OMAP3EVM.
> 
> After fixing the minor comment on patch 3/3, feel free to add:
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
Thanks Kevin, for the review.


> Also, I was surprised to discover that this booted on my (recently
> arrived) BeagleBone.  It seems that u-boot (from Angstrom) is passing
> the machine ID of the AM335x EVM[1], even though there is another
> machine ID for the BeagleBone[2].  Is that expected?
Kevin,

We can detect the board using on-board EEPROM, so same mach-id
should work for both EVM and Beagle. 
And also going forward with device tree approach we may
not need different id's, right?

But I am surprised to see that beaglebone is booting fine for you,
did you get Linux console?
Actually the board won't boot without some patches,
(I have published on arago), especially inside, gpmc_init,
omap_sram_init, omap3_pm_init and omap3_twl_init.

Thanks,
Vaibhav

> 
> I also see that the mach-types for this are in Russell's for-next
> branch.  In order for us to merge this into Tony's master branch, we'll
> need to see if Russell can pull the mach-types updates into
> devel-stable.  Russell?
> 
> Kevin
> 
> [1] http://www.arm.linux.org.uk/developer/machines/list.php?id=3589
> [2] http://www.arm.linux.org.uk/developer/machines/list.php?id=3808
