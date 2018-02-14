From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: clock: Fix debugfs_create_*() usage
Date: Wed, 14 Feb 2018 08:22:10 -0800
Message-ID: <20180214162210.GG6364@atomide.com>
References: <1514906735-8977-1-git-send-email-geert+renesas@glider.be>
 <20180109173734.tplddyd4d3akrzjr@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109173734.tplddyd4d3akrzjr@darkstar.musicnaut.iki.fi>
Sender: linux-clk-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [180109 17:40]:
> Hi,
> 
> On Tue, Jan 02, 2018 at 04:25:35PM +0100, Geert Uytterhoeven wrote:
> > When exposing data access through debugfs, the correct
> > debugfs_create_*() functions must be used, depending on data type.
> > 
> > Remove all casts from data pointers passed to debugfs_create_*()
> > functions, as such casts prevent the compiler from flagging bugs.
> > 
> > Correct all wrong usage:
> >   - clk.rate is unsigned long, not u32,
> >   - clk.flags is u8, not u32, which exposed the successive
> >     clk.rate_offset and clk.src_offset fields.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v4.16/fixes thanks.

Tony
