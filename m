From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: DSS hwmods: Add OCPIF_SWSUP_IDLE to all
 DSS L3 slave interfaces
Date: Fri, 4 May 2012 00:39:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205040038510.20926@utopia.booyaka.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com> <1334304116-18872-3-git-send-email-archit@ti.com> <4F87E72A.2050104@ti.com> <4F87E924.5040601@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43403 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2EDGjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 02:39:13 -0400
In-Reply-To: <4F87E924.5040601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Archit,

On Fri, 13 Apr 2012, Archit Taneja wrote:

> On Friday 13 April 2012 02:13 PM, Cousson, Benoit wrote:
> > On 4/13/2012 10:01 AM, Archit Taneja wrote:
> > > The clock for all DSS L3 slave interfaces had been recently changed to
> > > "dss_fck" from "l3_div_ck". "dss_fck" is an optional clock in DSS
> > > clock domain
> > > which can't autoidle when enabled.
> > > 
> > > Add OCPIF_SWSUP_IDLE flag to all the L3 slave interfaces used by DSS
> > > hwmods so
> > > that clock is explicitly enabled and disabled by software. Without this,
> > > "dss_fck" would be left as enabled and the OMAP4 device won't idle
> > > even when
> > > DSS is not in use.
> > 
> > Yeah, that was done on purpose with Tomi knowning well that limitation.
> > 
> > The issue was mainly due to the lack of proper parent / child
> > relationship between the DSS (the whole subsystem) and the DSS children
> > at that time.
> > 
> > I think that Tomi posted a series to fix that for 3.4. So if we ensure
> > that every DSS IPs are children of the DSS, then pm_runtime will always
> > ensure that the DSS will be enabled each time a submodule is used.
> > 
> > So the right fix is to put back the proper iclk (l3_div) to the DSS
> > instead of the dss_fck.
> 
> Ok, I get it now. Tomi's patch series ensured the parent-child 
> dependency, but they didn't switch the iclks back to l3_div, I guess 
> that should be a part of the series too.

Just checking on this one.  Does this patch need to be updated ?


- Paul
