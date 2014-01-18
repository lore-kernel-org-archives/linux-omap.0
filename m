From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Sat, 18 Jan 2014 10:07:21 -0800
Message-ID: <20140118180721.GG7235@atomide.com>
References: <20140115031632.4167.2698@quantum>
 <20140115035011.4167.96678@quantum>
 <20140115171323.GA22739@atomide.com>
 <20140115192340.4167.87685@quantum>
 <20140115193547.GF7993@atomide.com>
 <20140116213954.4167.37071@quantum>
 <87r486mrh5.fsf@linaro.org>
 <20140117175312.GH7993@atomide.com>
 <52D9723A.6000700@ti.com>
 <20140117205832.4167.95162@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44659 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751064AbaARSH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Jan 2014 13:07:28 -0500
Content-Disposition: inline
In-Reply-To: <20140117205832.4167.95162@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, balbi@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

* Mike Turquette <mturquette@linaro.org> [140117 13:00]:
> Quoting Tero Kristo (2014-01-17 10:11:06)
> > On 01/17/2014 07:53 PM, Tony Lindgren wrote:
> > > * Kevin Hilman <khilman@linaro.org> [140117 09:48]:
> > >> Mike Turquette <mturquette@linaro.org> writes:
> > >>
> > >> [...]
> > >>
> > >>> I took Tony's advice and fast-forwarded clk-next to -rc7 and applied
> > >>> Tero's series. This includes the AM3517 bits now. I've pushed this
> > >>> branch to clk-next-omap (force update) on my Linaro mirror. Can you do a
> > >>> final sanity test before I merge this into clk-next?
> > 
> > I think you accidentally merged wrong branch to clk-next-omap with the 
> > latest refresh. This is one is missing the build-fixes now, when it 
> > earlier had those in.
> > 
> > The correct branch to merge was 3.13-rc7-dt-clks-v13-build-fixes.
> > 
> > This also causes the build failure below for omap1.
> 
> You are right. I broke the OMAPs. I force updated clk-next-omap (and
> clk-next) with the correct branch this time.

OK works for me now, thanks.

Tony
