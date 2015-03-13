From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Fri, 13 Mar 2015 09:20:10 +0100
Message-ID: <20150313082010.GA1033@breakpoint.cc>
References: <54CFFBCF.90706@codeaurora.org>
 <20150202225036.421.43421@quantum>
 <54D0F179.1040906@gmail.com>
 <54D2AA9B.7010800@codeaurora.org>
 <54D3900A.9060200@gmail.com>
 <54D423C3.9030105@codeaurora.org>
 <54E3BA20.3080205@codeaurora.org>
 <20150312172006.GA18418@breakpoint.cc>
 <5501EC6C.5010100@codeaurora.org>
 <20150313032931.GO20455@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150313032931.GO20455@dragon>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Quentin Lambert <lambert.quentin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>, Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Shawn,

On Fri, Mar 13, 2015 at 11:29:32AM +0800, Shawn Guo wrote:

> We did not add a DT property for it, because there was already enough
> info (clock configuration) in DT for kernel to figure it out.
Correct. My understanding is whatever can be figured out without DT should
be done that way.

Is there a way to get this clock-select bit set without
enable_fec_anatop_clock() in u-boot? Because this one selects the clock and
frequency and also sets the proper bit in gpr1. My question is simply why do
we need to do this here as well.

> Shawn

Sebastian
