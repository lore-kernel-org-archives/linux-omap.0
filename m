From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: OMAP2+: Add PMU nodes
Date: Fri, 11 Jan 2013 09:59:40 -0800
Message-ID: <20130111175939.GL14149@atomide.com>
References: <1355766548-5702-1-git-send-email-jon-hunter@ti.com>
 <1355766548-5702-3-git-send-email-jon-hunter@ti.com>
 <50F01256.7030701@ti.com>
 <50F01AAD.8020003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26364 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754562Ab3AKR7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 12:59:45 -0500
Content-Disposition: inline
In-Reply-To: <50F01AAD.8020003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Jon Hunter <jon-hunter@ti.com> [130111 06:02]:
> Hi Benoit,
> 
> On 01/11/2013 07:23 AM, Benoit Cousson wrote:
> > Hi Jon,
> > 
> > On 12/17/2012 06:49 PM, Jon Hunter wrote:
> >> Add PMU nodes for OMAP2, OMAP3 and OMAP4460 devices.
> >>
> >> Please note that the node for OMAP4460 has been placed in a separate
> >> header file for OMAP4460, because the node is not compatible with
> >> OMAP4430. The node for OMAP4430 is not included because PMU is not
> >> currently supported on OMAP4430 due to the absence of a cross-trigger
> >> interface driver.
> >>
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> > 
> > I've just applied this patch in my for_3.9/dts branch.
> > 
> > I'm wondering if there is any dependency with the previous patch? If
> > Tony ack it I can take it as well.
> 
> I have been thinking about the best way to handle that. May be best for
> you to take both if Tony can ack the first.

Sounds good to me, I've acked it now.

Tony
