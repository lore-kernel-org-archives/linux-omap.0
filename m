From: David Cohen <david.cohen@nokia.com>
Subject: Re: [PATCH v2 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 15:17:16 +0300
Message-ID: <20101001121716.GB12614@esdhcp036161.research.nokia.com>
References: <1285931095-21053-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285931095-21053-3-git-send-email-peter.ujfalusi@nokia.com>
 <20101001115037.GA12614@esdhcp036161.research.nokia.com>
 <201010011516.54190.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46868 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab0JAM1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 08:27:16 -0400
Content-Disposition: inline
In-Reply-To: <201010011516.54190.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Nishanth Menon <nm@ti.com>

On Fri, Oct 01, 2010 at 02:16:53PM +0200, Peter Ujfalusi wrote:
> On Friday 01 October 2010 14:50:37 David Cohen wrote:
> > 
> > > +		l = sys_cf = dma_read(OCP_SYSCONFIG);
> > 
> > Shouldn't it be avoided?
> 
> I'm restoring the OCP_SYSCONFIG register later on, and reusing 'l' here to avoid 
> confusing expression when moving the sDMA to NoStandby.
> I could as well introduce other variable for this...

No problem with those two variables, but you're doing multiple
assignments in one line. You could do something like this:

l = dma_read(OCP_SYSCONFIG);
sys_cf = l;

Regards,

David
