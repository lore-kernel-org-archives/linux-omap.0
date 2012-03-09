From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Fri, 9 Mar 2012 10:00:28 -0800
Message-ID: <20120309180027.GF12083@atomide.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
 <4F5A258F.8050704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16128 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab2CISAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 13:00:32 -0500
Content-Disposition: inline
In-Reply-To: <4F5A258F.8050704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120309 07:47]:
> Hi Paul, Tony,
> 
> On 03/06/2012 10:55 AM, Peter Ujfalusi wrote:
> > CLKS signal for McBSP ports can be selected from internal (PRCM) or external
> > (ABE_CLKS pin) source.
> > To be able to use existing code we need to create clock aliases consistent
> > among OMAP2/3/4.
> 
> Would you be able to take a look at this patch?

To me this looks safe to merge via ASoC tree, assuming Paul
acks it too, and it does not cause merge conflicts with
Paul's changes:

Acked-by: Tony Lindgren <tony@atomide.com>
