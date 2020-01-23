From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] clk: ti: changes for 5.6
Date: Thu, 23 Jan 2020 08:57:54 -0800
Message-ID: <20200123165754.GA5885@atomide.com>
References: <71d3d7dd-115a-4584-e3d7-e13e7ea7934e@ti.com>
 <20200122002311.405E7217F4@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200122002311.405E7217F4@mail.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Stephen Boyd <sboyd@kernel.org> [200122 00:24]:
> Quoting Tero Kristo (2020-01-20 23:31:27)
> > Hi Stephen,
> > 
> > Please pull these TI clock changes towards v5.6. Tony, the same branch 
> > (for-5.6-ti-clk) can be considered immutable towards your DTS changes if 
> > you wish to sync them with this.
> 
> Thanks. Pulled into clk-next

OK. I've based the pending omap4 & 5 crypto accelerator changes on
Tero's branch and pushed out omap-for-v5.6/ti-sysc-omap45-rng. Might
be too late for v5.6, but we'll see.

Thanks,

Tony
