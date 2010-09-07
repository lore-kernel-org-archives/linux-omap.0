From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Tue, 7 Sep 2010 17:18:06 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A95@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402781CE908@dbde02.ent.ti.com>
 <87eidatpbm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47995 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab0IGLsN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:48:13 -0400
In-Reply-To: <87eidatpbm.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Sawant, Anand" <sawant@ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, September 04, 2010 4:20 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, 
> Santosh; Sawant, Anand
> Subject: Re: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as 
> platform driver
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > If there are no further comments, can you please stage this patch
> > series on hwmods-omap4 branch?
> 
> Reviewed.  Still a long ways to go..., also  I didn't see you address
> the typo pointed out by Mika Westerberg on PATCH 03/11.
Sorry. I fixed it in my internal version and forgot to take that change.
Thanks for pointing this.

> 
> Also, testing on omap3430/n900, I noticed an interesting 
> failure during
> boot.  During boot (in the middle of omap3_pm_init(), a DMA interrupt
> fires and the SPI RX callback is called which faults when 
> accessing it's
> registers.

Not sure about n900, I will check if I get N900.

> 
> I did not debug this further, but is something that needs 
> investigation.
> 
> Also, in the next version, please report how it was tested on the
> various OMAPs.  In particular, what peripherals using DMA were tested.
> Just a boot test is not sufficient when making major 
> functional changes
> like this.  Drivers using DMA need to be tested as well.

This patch series has been tested with various use cases like:
1. Memory to Memory DMA test cases from test code:
http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=shortlog;h=refs/heads/master

2. SD/MMC test cases(on zoom3, omap4 SDP and beagle)
3. Ethernet testing (on omap4 SDP with McSPI interface for both Rx and Tx - Also used
   NFS file system)

I will provide these details in next version patches.

-Manjunath
