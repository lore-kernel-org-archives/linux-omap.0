From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH-V2 0/4] Introducing TI's New SoC/board AM335XEVM
Date: Thu, 15 Sep 2011 12:43:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC810B62@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1314621976-25750-1-git-send-email-hvaibhav@ti.com>
 <20110915003210.GC30941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36734 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab1IOHNp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 03:13:45 -0400
In-Reply-To: <20110915003210.GC30941@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, September 15, 2011 6:02 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin; paul@pwsan.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [RFC PATCH-V2 0/4] Introducing TI's New SoC/board AM335XEVM
> 
> * hvaibhav@ti.com <hvaibhav@ti.com> [110829 05:52]:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > This patch set adds support for AM335x device having
> > Cortex-A8 MPU.
> >
> > AM335X is treated as another OMAP3 variant, where,
> > along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> > and the respective type is AM335X, which is newly added device in the
> family.
> > This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> > cpu_is_am335x() checks return success for AM335X.
> >
> > Currently submitting this patch series as a RFC (V2), to initiate the
> > discussion on the approach we have chosen for AM335x device support.
> > Based on the feedback, will submit the final version of patch series
> > immediately.
> 
> Can you please rebase these on Paul's CHIP_IS removal series?
> 
> Those patches are available at:
> 
> git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2
> 
[Hiremath, Vaibhav] Thanks Tony for your comments, 

Yeah, I will rebase and submit it again ASAP.


Thanks,
Vaibhav
> Regards,
> 
> Tony
