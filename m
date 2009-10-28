From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] omap-pm: Fixes behaviour of some shared resource framework functions
Date: Wed, 28 Oct 2009 17:08:14 -0500
Message-ID: <003201ca581b$256863c0$544ff780@am.dhcp.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com> <87iqejktan.fsf@deeprootsystems.com> <alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49661 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbZJ1WIO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 18:08:14 -0400
In-Reply-To: <alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: "'Dasgupta\\, Romit'" <romit@ti.com>, "'linux-omap\\@vger.kernel.org'" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Wednesday, October 28, 2009 1:38 PM
> To: Kevin Hilman
> Cc: Dasgupta\, Romit; linux-omap\@vger.kernel.org
> Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource
> framework functions
> 
> On Tue, 13 Oct 2009, Kevin Hilman wrote:
> 
> > "Dasgupta, Romit" <romit@ti.com> writes:
> >
> > > (Tested on Zoom2).
> > >
> > > 'omap_pm_dsp_set_min_opp' & 'omap_pm_cpu_set_freq' were using their
> own
> > > struct device *. This is a problem because invoking these functions
> from
> > > different clients would result in setting of the resource level as
> requested by
> > > the last caller. Fixes this by introducing a struct device * to the
> parameter
> > > list for these functions.
> > > Signed-off-by: Romit Dasgupta <romit@ti.com>
> >
> >
> > This looks like the right fix to me.
> >
> > Paul, any comments?
> 
> 
> Wait a minute, I am retracting my ack.
> 
> 
> Romit, the only caller of omap_pm_dsp_set_min_opp() should be DSPBridge
> and the only caller of omap_pm_cpu_set_freq() should be CPUFreq.  So the
> struct device * pointer is not necessary, unless I am missing something.
> Can you please explain what you're trying to do?
> 
I believe that omap_pm_cpu_set_freq() can be called by drivers to setup the
optimal vdd1 opp, right? For example MMC works at opp1 but the performance
is certainly better at opp3.When ondemand is enabled drivers need to put
certain constraints on vdd1 opp otherwise performance will be hurt. So, if
the API takes care of device level calls then drivers can call this fn.

Regards,
Madhu
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


