From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/6] OMAP4: PRCM: OMAP4460 specific PRM and CM register
 bitshifts
Date: Fri, 8 Jul 2011 01:34:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080133470.24181@utopia.booyaka.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com> <1309573826-10615-2-git-send-email-rnayak@ti.com> <1309573826-10615-3-git-send-email-rnayak@ti.com> <1309573826-10615-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1107080029550.24181@utopia.booyaka.com>
 <4E16AB3C.7020007@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42353 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab1GHHei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 03:34:38 -0400
In-Reply-To: <4E16AB3C.7020007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On Fri, 8 Jul 2011, Rajendra Nayak wrote:

> Hi Paul,
> 
> On 7/7/2011 11:30 PM, Paul Walmsley wrote:
> > Hi Rajendra
> > 
> > On Sat, 2 Jul 2011, Rajendra Nayak wrote:
> > 
> > > This patch adds additional register bitshifts for
> > > registers added in OMAP4460 platform.
> > > 
> > > Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> > > Signed-off-by: Nishanth Menon<nm@ti.com>
> > > Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> > > Reviewed-by: Kevin Hilman<khilman@ti.com>
> > 
> > Does this data come from the autogenerator scripts?
> 
> Yes, it does. But the patch is created by manually
> diffing the 4430 and 4460 autogen script outputs.
> That's because the autogen scripts cannot generate
> data for multiple SoC's at once.

Okay.  So then, 

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
