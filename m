From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap4: pandaboard: turn on PHY reference clock at
 init
Date: Mon, 10 Jan 2011 11:12:01 -0800
Message-ID: <20110110191201.GG4957@atomide.com>
References: <1294670535-9059-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.1101101152040.5731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101101152040.5731@utopia.booyaka.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Felipe Balbi <balbi@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [110110 10:51]:
> On Mon, 10 Jan 2011, Anand Gadiyar wrote:
> 
> > The SMSC 3320 USB PHY on the OMAP4 Pandaboard needs a 19.2 MHz
> > reference clock. This clock is provided from the OMAP4's fref_clk3
> > pad.
> > 
> > Recent changes to clock44xx_data.c made the clock framework aware
> > of the existence of these fref_clk[i] lines. If the option
> > CONFIG_OMAP_RESET_CLOCKS is enabled in the kernel, then the
> > clock framework will turn these clocks off during bootup.
> > 
> > Explicitly request and keep this clock enabled at init for the
> > Pandaboard, so that the PHY receives this clock at all times.
> > 
> > Reported-by: Ming Lei <tom.leiming@gmail.com>
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>

Will queue as a fix.

Tony
