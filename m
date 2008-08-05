From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3 CPUidle patches - fixes
Date: Tue, 5 Aug 2008 14:05:47 +0530
Message-ID: <033a01c8f6d6$452b9ee0$74f6180a@wipultra1382>
References: <20080805083348.GB7193@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:57477 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759310AbYHEIgB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Aug 2008 04:36:01 -0400
In-Reply-To: <20080805083348.GB7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Tuesday, August 05, 2008 2:04 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3 CPUidle patches - fixes
> 
> * Rajendra Nayak <rnayak@ti.com> [080805 08:35]:
> > 
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Monday, August 04, 2008 8:03 PM
> > > To: Rajendra Nayak
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH] OMAP3 CPUidle patches - fixes
> > > 
> > > * Rajendra Nayak <rnayak@ti.com> [080703 14:55]:
> > > > This patch fixes few of the comments posted on the patch
> > > set till now. 
> > > > 
> > > > One major fix is the moving of uart clock enable/disable
> > > out of the context save path as pointed out by Jouni. 
> > > > This would leave the UART clcoks disabled in case a CORE
> > > OFF was attempted and not achieved.
> > > 
> > > What kernel or patch series this is against? If it's for 
> some patch 
> > > series that's not applied yet to linux-omap tree, let's merge the 
> > > fix to the original patch.
> > 
> > I sent another patch set later to the list (dated 
> 18/07/2008) "[PATCH 
> > 00/11] OMAP3 CPUidle patches - ver 2"
> > which is the final patch set for CPUidle which can be merged. 
> > This patch and all the previous patches on CPUidle can be ignored. 
> 
> Can you please integrate all the fixes to CPUidle and repost 
> the whole series one more time?

Ok. Will repost it today.

> 
> Thanks,
> 
> Tony
> 

