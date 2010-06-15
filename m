From: Mathieu Poirier <mathieu.poirier@canonical.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Tue, 15 Jun 2010 15:17:13 -0600
Message-ID: <1276636633.2824.88.camel@black>
References: <1276613548.2824.46.camel@black>
	 <AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39075 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab0FOVRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 17:17:05 -0400
In-Reply-To: <AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2010-06-15 at 20:58 +0530, Venkatraman S wrote:
> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
> > HW: Beagleboard rev. C2 and C4
> > Processor: OMAP3
> > Kernel: 2.6.35-rc2
> > Driver: mmci-omap-hs
> >
> > I am faced with an SDHC card problem on a beagleboard.  Some cards
> > cannot be initialized on startup while others work perfectly.  I tracked
> > the issue down to one single kernel config: PREEMPT_VOLUNTARY.
> >
> > When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem goes away.
> >
> > When booting, a failing card (PREEMPT_VOLUNTARY) will output the
> > following:
> > [ 2.283355] mmc0: error -110 whilst initialising SD card
> >
> > I have also seen transfer errors such as this one:
> > [ 105.343780] mmcblk0: error -110 transferring data, sector 798431, nr
> > 26, card status 0xc00
> >
> > When working properly (PREEMPT_NONE), you get:
> > [   27.026519] mmc0: new high speed SDHC card at address 0007
> > [   27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB
> >
> > We seem to have a little timing problem - has anyone seen the same
> > issue ?  Can driver "mmci-omap-hs" actually work under
> > PREEMPT_VOLUNTARY ?
> >
> > Thanks, Mathieu.
> >
> 
> I will check this out - not tested with PREEMPT_VOLUNTARY so far.
> If it's not too much trouble, can you provide a log with CONFIG_MMC_DEBUG ?
> Also, some details about the failing card would be helpful.
> 
> Thanks,
> Venkat.

Venkat,

Unfortunately enabling CONFIG_MMC_DEBUG doesn't yield more information -
the error message is the same and no additional output shows on the
console.

As for the cards, had failures with 3 different manufacturer:
- Patriot Memory, MicroSD card, 8GB, class 4, SDHC.  
- Kinston, 4GB, class 6, SDHC.
- Sandisk, 4GB, Class 2, SDHC.

I am more than willing to test kernels for you if need be.

Thanks, Mathieu.

