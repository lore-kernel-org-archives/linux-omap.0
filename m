From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches
Date: Thu, 3 Jul 2008 14:09:42 +0530
Message-ID: <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com> <20080702131127.GA4404@codecarver.research.nokia.com> <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com> <20080702154253.GC4404@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:36634 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbYGCLzA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2008 07:55:00 -0400
In-Reply-To: <20080702154253.GC4404@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com] 
> Sent: Wednesday, July 02, 2008 9:13 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
> 
> Hi Rajendra,
> 
> > 
> > Not sure, but you can try with my .config while I try with yours. 
> > I was doing some more testing today, and I saw a hang after 
> a while of
> > idle activity with OFF being attempted multiple times.
> > Using lauterbach showed me it being stuck up in 
> prcm_interrupt_handler trying 
> > to clear MPU_IRQSTATUS.
> > Looks like in the PRCM interrupt handler somehow 
> PM_WKST1_CORE is not cleared
> > (I see it set to 0x2000) and hence MPU_IRQSTATUS fails to clear.
> > 
> 
> Ok. I disabled OneNAND support and now I get off mode on VDD2 as well.
> Consumption on VDD1 is 4uA and 32uA on VDD2. Unfortunately after the
> first wakeup, off mode is never reached again.

Do you see a hang? or OFF is never achieved?
Can you try with the latest fixes that I posted.

> 
> Cheers,
> 
> Peter.
> 

