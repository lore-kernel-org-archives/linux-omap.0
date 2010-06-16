From: Mathieu Poirier <mathieu.poirier@canonical.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Wed, 16 Jun 2010 16:12:56 -0600
Message-ID: <1276726376.3211.36.camel@black>
References: <1276613548.2824.46.camel@black>
	 <AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
	 <1276636633.2824.88.camel@black>
	 <AANLkTikJE7fNYmRqFYL9WB7z_o3GcfaDsTJ4-yZUk4od@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37913 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0FPWNA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 18:13:00 -0400
In-Reply-To: <AANLkTikJE7fNYmRqFYL9WB7z_o3GcfaDsTJ4-yZUk4od@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>, s-ghorai@ti.com
Cc: linux-omap@vger.kernel.org

On Wed, 2010-06-16 at 14:13 +0530, Venkatraman S wrote:
> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
> > On Tue, 2010-06-15 at 20:58 +0530, Venkatraman S wrote:
> >> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
> >> > HW: Beagleboard rev. C2 and C4
> >> > Processor: OMAP3
> >> > Kernel: 2.6.35-rc2
> >> > Driver: mmci-omap-hs
> >> >
> >> > I am faced with an SDHC card problem on a beagleboard.  Some cards
> >> > cannot be initialized on startup while others work perfectly.  I tracked
> >> > the issue down to one single kernel config: PREEMPT_VOLUNTARY.
> >> >
> >> > When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem goes away.
> >> >
> >> > When booting, a failing card (PREEMPT_VOLUNTARY) will output the
> >> > following:
> >> > [ 2.283355] mmc0: error -110 whilst initialising SD card
> >> >
> >> > I have also seen transfer errors such as this one:
> >> > [ 105.343780] mmcblk0: error -110 transferring data, sector 798431, nr
> >> > 26, card status 0xc00
> >> >
> >> > When working properly (PREEMPT_NONE), you get:
> >> > [   27.026519] mmc0: new high speed SDHC card at address 0007
> >> > [   27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB
> >> >
> >> > We seem to have a little timing problem - has anyone seen the same
> >> > issue ?  Can driver "mmci-omap-hs" actually work under
> >> > PREEMPT_VOLUNTARY ?
> >> >
> >> > Thanks, Mathieu.
> >> >
> >>
> >> I will check this out - not tested with PREEMPT_VOLUNTARY so far.
> >> If it's not too much trouble, can you provide a log with CONFIG_MMC_DEBUG ?
> >> Also, some details about the failing card would be helpful.
> >>
> >> Thanks,
> >> Venkat.
> >
> > Venkat,
> >
> > Unfortunately enabling CONFIG_MMC_DEBUG doesn't yield more information -
> > the error message is the same and no additional output shows on the
> > console.
> >
> > As for the cards, had failures with 3 different manufacturer:
> > - Patriot Memory, MicroSD card, 8GB, class 4, SDHC.
> > - Kinston, 4GB, class 6, SDHC.
> > - Sandisk, 4GB, Class 2, SDHC.
> >
> > I am more than willing to test kernels for you if need be.
> >
> > Thanks, Mathieu.
> >
> 
> For MMC/SD logs to be sent to the console, you need to
> a) "echo 8 > /proc/sys/kernel/printk" in the shell and
> b) insert the card
> 
> If you are booting from the card itself, then this won't work and
> DEBUG_LL has to be enabled (in addition to CONFIG_MMC_DEBUG)
> 
> Apologies - I should have explained this initially.
> 
> Regards,
> Venkat.

Venkat,

I am indeed booting from the card itself, making things more difficult.
DEBUG_LL has been configured since the very beginning and still not much
to look at on the console.  To see something I had to pass loglevel=8 on
the kernel command line.  At that point there is tones of stuff coming
out and the card is initialized properly, which points to a timing
issue. 

Since I couldn't reproduce the failure when debug messages are enabled,
I turned them back off and started to instrument the code on the hunt
for the failure. 

I have cornered the source of the problem in
"drivers/mmc/core/sd_ops.c", function "mmc_sd_switch".  When the kernel
is configured with PREEMPT_NONE, the value of "data.error" is set to "0"
after "mmc_wait_for_req" returns.  When PREEMPT_VOLUNTARY is configured,
"data.error" gets set to "-110" upon "mmc_wait_for_req" returning, which
prevent the remaining of the configuration to take place.

I am out of time for today but tomorrow I'll dive in "mmc_wait_for_req".
Send me a line if the above rings a bell or you find something.

Ghorai, please find an answer to your question in the above trail.

Thanks, Mathieu. 



