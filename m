From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 CPUidle patches - fixes
Date: Tue, 5 Aug 2008 11:33:49 +0300
Message-ID: <20080805083348.GB7193@atomide.com>
References: <20080804143316.GM8885@atomide.com> <02fd01c8f6bc$fbe96280$74f6180a@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58632 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759AbYHEIdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 04:33:52 -0400
Content-Disposition: inline
In-Reply-To: <02fd01c8f6bc$fbe96280$74f6180a@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [080805 08:35]:
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Monday, August 04, 2008 8:03 PM
> > To: Rajendra Nayak
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP3 CPUidle patches - fixes
> > 
> > * Rajendra Nayak <rnayak@ti.com> [080703 14:55]:
> > > This patch fixes few of the comments posted on the patch 
> > set till now. 
> > > 
> > > One major fix is the moving of uart clock enable/disable 
> > out of the context save path as pointed out by Jouni. 
> > > This would leave the UART clcoks disabled in case a CORE 
> > OFF was attempted and not achieved.
> > 
> > What kernel or patch series this is against? If it's for some 
> > patch series that's not applied yet to linux-omap tree, let's 
> > merge the fix to the original patch.
> 
> I sent another patch set later to the list (dated 18/07/2008) 
> "[PATCH 00/11] OMAP3 CPUidle patches - ver 2" 
> which is the final patch set for CPUidle which can be merged. 
> This patch and all the previous patches on CPUidle can be ignored. 

Can you please integrate all the fixes to CPUidle and repost the
whole series one more time?

Thanks,

Tony
