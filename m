From: Tony Lindgren <tony@atomide.com>
Subject: Re: clk: ti: Add support for dm814x ADPLL
Date: Wed, 2 Mar 2016 10:19:54 -0800
Message-ID: <20160302181954.GE4469@atomide.com>
References: <20160302111130.GA10965@mwanda>
 <20160302170502.GS21163@atomide.com>
 <20160302180912.GT5273@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160302180912.GT5273@mwanda>
Sender: linux-clk-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

* Dan Carpenter <dan.carpenter@oracle.com> [160302 10:09]:
> On Wed, Mar 02, 2016 at 09:05:03AM -0800, Tony Lindgren wrote:
> > >    910          err = ti_adpll_init_registers(d);
> > >    911          if (err)
> > >    912                  return err;
> > >    913  
> > >    914          err = ti_adpll_init_inputs(d);
> > >    915          if (err)
> > >    916                  return err;
> > >                         ^^^^^^^^^^
> > > This is the last direct return in the function, meaning that
> > > ti_adpll_init_inputs() must allocate something but I can't see what.
> > > It should match clkdev_drop() and ac->unregister()?  I don't understand.
> > 
> > Hmm I don't get this one. How did you get a warning here, is this a
> > warning from sparse also?
> 
> There isn't a warning here.  I'm just saying that when I'm reading this
> code I assume that ti_adpll_free_resources() is supposed to undo
> ti_adpll_init_inputs().
>
> I looked at Steven's patch and now I see what's going on here.  The
> error handling is fine when that's applied.  Thanks.

OK thanks for checking.

Regards,

Tony
