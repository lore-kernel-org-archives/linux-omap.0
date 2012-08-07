From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] spi: omap2-mcspi: In case of dma errors fall back to
 pio
Date: Tue, 7 Aug 2012 05:02:27 -0700
Message-ID: <20120807120227.GA11011@atomide.com>
References: <1343197229-15188-1-git-send-email-shubhrajyoti@ti.com>
 <20120807074740.GR11011@atomide.com>
 <5020FA2C.2020707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5020FA2C.2020707@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Shubhrajyoti <shubhrajyoti@ti.com> [120807 04:21]:
> On Tuesday 07 August 2012 01:17 PM, Tony Lindgren wrote:
> >>  };
> > Don't you need to check separately for rx and tx dma? There's a slight
> > chance that you get a channel for one but not for the other..
> In that case I treat it as non usable and fall back to pio.

OK that should work too.
 
> Are you suggesting that let one channel be dma and only the failed one pio?

I guess both are doable. For reduced CPU load using DMA where possible
of course is the best way to go.

Tony
