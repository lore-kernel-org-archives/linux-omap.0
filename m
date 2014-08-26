From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap54xx-clocks: Fix the l3 and l4 clock rates
Date: Tue, 26 Aug 2014 13:54:51 -0700
Message-ID: <20140826205451.GA16006@atomide.com>
References: <1409043098-12510-1-git-send-email-t-kristo@ti.com>
 <53FC57AA.5040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41449 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbaHZUy4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2014 16:54:56 -0400
Content-Disposition: inline
In-Reply-To: <53FC57AA.5040906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140826 02:48]:
> On 26/08/14 11:51, Tero Kristo wrote:
> > Similarly to DRA7, OMAP5 has l3 and l4 clock rates incorrectly calculated.
> > Fixed by using proper divider clock types for the clock nodes.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  arch/arm/boot/dts/omap54xx-clocks.dtsi |   16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks applying into omap-for-v3.17/fixes-v2.

Tony
