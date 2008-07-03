From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Thu, 3 Jul 2008 15:44:46 +0300
Message-ID: <20080703124446.GB4512@codecarver.research.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com> <20080702131127.GA4404@codecarver.research.nokia.com> <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com> <20080702154253.GC4404@codecarver.research.nokia.com> <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46344 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbYGCMqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:46:09 -0400
Content-Disposition: inline
In-Reply-To: <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jul 03, 2008 at 02:09:42PM +0530, ext Rajendra Nayak wrote:
> > -----Original Message-----
> > From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com] 
> > Sent: Wednesday, July 02, 2008 9:13 PM
> > To: ext Rajendra Nayak
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
> > 
> > Hi Rajendra,
> > 
> > > 
> > > Not sure, but you can try with my .config while I try with yours. 
> > > I was doing some more testing today, and I saw a hang after 
> > a while of
> > > idle activity with OFF being attempted multiple times.
> > > Using lauterbach showed me it being stuck up in 
> > prcm_interrupt_handler trying 
> > > to clear MPU_IRQSTATUS.
> > > Looks like in the PRCM interrupt handler somehow 
> > PM_WKST1_CORE is not cleared
> > > (I see it set to 0x2000) and hence MPU_IRQSTATUS fails to clear.
> > > 
> > 
> > Ok. I disabled OneNAND support and now I get off mode on VDD2 as well.
> > Consumption on VDD1 is 4uA and 32uA on VDD2. Unfortunately after the
> > first wakeup, off mode is never reached again.
> 
> Do you see a hang? or OFF is never achieved?

No hang, but OFF is never achieved after the first UART wakeup.

> Can you try with the latest fixes that I posted.
> 

Doesn't change anything.

Cheers,

Peter.
-- 
goa is a state of mind
