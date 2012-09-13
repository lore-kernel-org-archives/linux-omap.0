From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: introduce i2c-cbus driver
Date: Thu, 13 Sep 2012 17:51:05 +0300
Message-ID: <20120913145104.GA8849@blackmetal.musicnaut.iki.fi>
References: <1346703805-31598-1-git-send-email-aaro.koskinen@iki.fi>
 <1346703805-31598-2-git-send-email-aaro.koskinen@iki.fi>
 <20120913105309.GF14237@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120913105309.GF14237-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 13, 2012 at 12:53:09PM +0200, Wolfram Sang wrote:
> On Mon, Sep 03, 2012 at 11:23:22PM +0300, Aaro Koskinen wrote:
> > Add i2c driver to enable access to devices behind CBUS on Nokia Internet
> > Tablets.
> > 
> > The patch also adds CBUS I2C configuration for N8x0 which is one of the
> > users of this driver.
> > 
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> 
> My main question is: what is CBUS? It doesn't look like an I2C/SMBUS
> host controller, but some bit-banging protocol? As such, it shouldn't go
> to i2c/busses/. And the protocol doesn't look much like I2C, neither.
> There is no ACK/NACK/START/STOP, so I wonder if it should be in i2c
> after all...

It's some legacy 3-wire bus protocol. Not much info is available,
there's some references to CBUS in i2c spec, so I thought it wouldn't
be a completly wrong place for it...

A.
