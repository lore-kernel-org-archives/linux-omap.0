From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
Date: Wed, 20 May 2015 10:46:49 -0700
Message-ID: <20150520174648.GC10274@atomide.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-3-git-send-email-t-kristo@ti.com>
 <20150520012053.GC31054@codeaurora.org>
 <555CC7CA.2090104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52493 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbbETRqw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 13:46:52 -0400
Content-Disposition: inline
In-Reply-To: <555CC7CA.2090104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, mturquette@linaro.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150520 10:45]:
> On 05/20/2015 04:20 AM, Stephen Boyd wrote:
> >On 05/11, Tero Kristo wrote:
> >>With the legacy clock data now gone, we can start moving OMAP clock
> >>type implementations under clock driver. Start this with moving the
> >>generic OMAP DPLL clock type under TI clock driver.
> >>
> >>Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>---
> >
> >How much of the code is the same from the original copy? Can you
> >generate these patches with -M -C so that we can see?
> 
> Looks like for the move patches the range is from 85%...95% exact copy.
> Shall I repost the patches in this format? Good hint for the -M -C btw, I
> wonder why those are not default options for git-format-patch.

While tweaking your scripts.. Can you also check why the cover
letter for your patches is missing the whole series diffstat?

The diffstat is automatically created with:

$ git format-patch --cover-letter -o /tmp/outgoing v4.1-rc1..

Regards,

Tony
