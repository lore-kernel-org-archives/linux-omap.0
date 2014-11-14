From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7: fix DSS PLL clock mux registers
Date: Fri, 14 Nov 2014 10:29:43 -0800
Message-ID: <20141114182943.GX26481@atomide.com>
References: <1413190241-13527-1-git-send-email-tomi.valkeinen@ti.com>
 <20141112152401.GF26481@atomide.com>
 <20141112152549.GG26481@atomide.com>
 <54644B27.8010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27542 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750972AbaKNSaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2014 13:30:16 -0500
Content-Disposition: inline
In-Reply-To: <54644B27.8010701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, Somnath Mukherjee <somnath@ti.com>

* Tero Kristo <t-kristo@ti.com> [141112 22:11]:
> On 11/12/2014 05:25 PM, Tony Lindgren wrote:
> >* Tony Lindgren <tony@atomide.com> [141112 07:26]:
> >>* Tomi Valkeinen <tomi.valkeinen@ti.com> [141013 01:52]:
> >>>The clock nodes for DSS VIDEO1/2 and HDMI have wrong register addresses.
> >>>This patch fixes the addresses so that they point to
> >>>CM_CLKSEL_VIDEO1_PLL_SYS, CM_CLKSEL_VIDEO2_PLL_SYS and
> >>>CM_CLKSEL_HDMI_PLL_SYS.
> >>>
> >>>Reported-by: Somnath Mukherjee <somnath@ti.com>
> >>>Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>
> >>Applying into omap-for-v3.19/fixes-not-urgent thanks.
> >
> >Actually this one would be good to have an ack from Tero
> >as he may need to fix his scripts generating these entries.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Re-applying with Tero's ack thanks.

Tony
