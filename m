From: Mike Turquette <mturquette@linaro.org>
Subject: Re: RE: RE: [PATCH v2 1/2] clk: divider: prepare for minimum divider
Date: Fri, 25 Jan 2013 14:35:24 -0800
Message-ID: <20130125223524.10623.29375@quantum>
References: <6dc1c48cac5b2646a55da3079afb72f88e40c3bc.1358937138.git.afzal@ti.com>
 <20130123214053.9205.49804@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA92ABC@DBDE01.ent.ti.com>
 <20130124170630.10623.78749@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA93851@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA93851@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Quoting Mohammed, Afzal (2013-01-25 04:06:41)
> Hi Mike,
> 
> On Thu, Jan 24, 2013 at 22:36:30, Mike Turquette wrote:
> > Quoting Mohammed, Afzal (2013-01-24 03:29:15)
> 
> > > It is a functional constraint: divider has 8 bits and it can have
> > > all possible values (0 to 255) and divider value corresponds to
> > > value set in the 8 bits. But depending on the modes the minimum
> > > value that can be configured (to get display working) varies.
> > > Eg. For raster mode (which the driver is presently supporting), it
> > > can take a minimum value of 2, while in LIDD (LCD interface display
> > > driver) mode it can take a min value of 1.
> > > 
> > > Here min rate is not a constraint w.r.t divider in LCDC IP, but
> > > rather min divider.
> 
> > Just so I understand correctly... you are saying that the functional
> > constraint is not caused by the clock rate, but instead by the divider
> > value?  For the different modes (raster vs LIDD) is the clock rate the
> > same, or is the clock rate different?
> 
> > What is the clock output rate of the divider in raster mode?  What is
> > the clock output rate of the divider in LIDD mode?
> 
> Yes, functional constraint in caused by divider value.
> 
> clock output rate can defined for both modes as follows,
> 
> p_clk (clock output rate) = lcd_clk (input clock rate) / div,
> 
> to configure "div", we have r/w 8 bits, so div values can
> range from 0-255,
> 
> And IP spec says value "0" and "1" should not be written, in
> raster mode. Further it says if in LIDD mode it can have values
> from 0-255, but effect of writing "0" is same as "1".
> 

Afzal,

Thank you for the information.  In short, the way you program your clock
depend on the configuration of your lcdc device.

As such I am not sure the basic divider is the right choice for you.
You might be better off creating a clock for your IP which takes into
account these details.  Luckily it is possible to inherit from the basic
clock types and create a new type.

An example of this is the MXS divider.  It uses the basic divider as a
"parent class" and adds a busy bit.  This is a better approach than
putting every feature into the basic divider type.  You can see how it
was done in drivers/clk/mxs/clk-div.c

Let me know what you think.

Regards,
Mike

> Effect of divider value on output rate is in the same way for
> both modes as per above expression (except for writing "0" in
> LIDD mode).
> 
> The driver supports only raster mode.
> 
> Regards
> Afzal
> 
> Note: link to trm has been mentioned in the earlier reply.
