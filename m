From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Wed, 2 Jul 2008 18:42:53 +0300
Message-ID: <20080702154253.GC4404@codecarver.research.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com> <20080702131127.GA4404@codecarver.research.nokia.com> <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64454 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYGBPqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 11:46:00 -0400
Content-Disposition: inline
In-Reply-To: <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Rajendra,

> 
> Not sure, but you can try with my .config while I try with yours. 
> I was doing some more testing today, and I saw a hang after a while of
> idle activity with OFF being attempted multiple times.
> Using lauterbach showed me it being stuck up in prcm_interrupt_handler trying 
> to clear MPU_IRQSTATUS.
> Looks like in the PRCM interrupt handler somehow PM_WKST1_CORE is not cleared
> (I see it set to 0x2000) and hence MPU_IRQSTATUS fails to clear.
> 

Ok. I disabled OneNAND support and now I get off mode on VDD2 as well.
Consumption on VDD1 is 4uA and 32uA on VDD2. Unfortunately after the
first wakeup, off mode is never reached again.

Cheers,

Peter.
