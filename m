From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource framework
 functions
Date: Wed, 28 Oct 2009 12:38:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com> <87iqejktan.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37542 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbZJ1SiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 14:38:18 -0400
In-Reply-To: <87iqejktan.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Dasgupta\\, Romit" <romit@ti.com>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 13 Oct 2009, Kevin Hilman wrote:

> "Dasgupta, Romit" <romit@ti.com> writes:
> 
> > (Tested on Zoom2).
> >
> > 'omap_pm_dsp_set_min_opp' & 'omap_pm_cpu_set_freq' were using their own
> > struct device *. This is a problem because invoking these functions from
> > different clients would result in setting of the resource level as requested by
> > the last caller. Fixes this by introducing a struct device * to the parameter
> > list for these functions.
> > Signed-off-by: Romit Dasgupta <romit@ti.com>
> 
> 
> This looks like the right fix to me.
> 
> Paul, any comments?


Wait a minute, I am retracting my ack.


Romit, the only caller of omap_pm_dsp_set_min_opp() should be DSPBridge 
and the only caller of omap_pm_cpu_set_freq() should be CPUFreq.  So the 
struct device * pointer is not necessary, unless I am missing something.  
Can you please explain what you're trying to do?



- Paul
