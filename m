From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: set the core dpll clk rate in its set_rate
 function.
Date: Fri, 13 May 2011 17:06:28 +0300
Message-ID: <20110513140625.GL5323@atomide.com>
References: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1105122015550.26192@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61846 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759327Ab1EMOGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 10:06:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105122015550.26192@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Avinash.H.M" <avinashhm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shweta Gulati <shweta.gulati@ti.com>, Rajendra Nayak <rnayak@ti.com>

* Paul Walmsley <paul@pwsan.com> [110513 05:13]:
> On Mon, 9 May 2011, Avinash.H.M wrote:
> 
> > The debug l3_ick/rate is not displaying the actual rate of the clock in
> > hardware. This is because, the core dpll set_rate function doesn't update the
> > clk.rate. After fixing, the l3_ick/rate is displaying proper values.
> > 
> > Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Wamsley <paul@pwsan.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks, let's see if we can get this into an -rc.

Might be out of time as we still should have this sit in
for-next too. Anyways, adding into devel-fixes.

Tony
