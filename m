From: Tony Lindgren <tony@atomide.com>
Subject: Re: clk: ti: Add support for dm814x ADPLL
Date: Wed, 2 Mar 2016 09:05:03 -0800
Message-ID: <20160302170502.GS21163@atomide.com>
References: <20160302111130.GA10965@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160302111130.GA10965@mwanda>
Sender: linux-clk-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Hi

* Dan Carpenter <dan.carpenter@oracle.com> [160302 03:12]:
> Hello Tony Lindgren,
> 
> The patch e6ab1637c643: "clk: ti: Add support for dm814x ADPLL" from
> Feb 26, 2016, leads to the following static checker warnings:
> 
> 	drivers/clk/ti/adpll.c:465 ti_adpll_recalc_rate()
> 	warn: should '__readw(d->regs + 20) << 18' be a 64 bit type?
> 
> 	drivers/clk/ti/adpll.c:945 ti_adpll_probe()
> 	error: we previously assumed 'd->clocks' could be null (see line 921)

Stephen already patched most of this with "clk: ti: Fix some errors
found by static checkers", some mysteries remain below though.

> This should probably be:
> 		rate = (u64)readw_relaxed(d->regs + ADPLL_MN2DIV_OFFSET) << 18;

Already fixed by Stephen.

>    773  static void ti_adpll_free_resources(struct ti_adpll_data *d)
>    774  {
>    775          int i;
>    776  
>    777          for (i = TI_ADPLL_M3; i >= 0; i--) {
>    778                  struct ti_adpll_clock *ac = &d->clocks[i];
>    779  
>    780                  if (!ac || IS_ERR_OR_NULL(ac->clk))
> 
> ac can't possibly be NULL here.

Yeah looks like we can remove ac check here.

>    910          err = ti_adpll_init_registers(d);
>    911          if (err)
>    912                  return err;
>    913  
>    914          err = ti_adpll_init_inputs(d);
>    915          if (err)
>    916                  return err;
>                         ^^^^^^^^^^
> This is the last direct return in the function, meaning that
> ti_adpll_init_inputs() must allocate something but I can't see what.
> It should match clkdev_drop() and ac->unregister()?  I don't understand.

Hmm I don't get this one. How did you get a warning here, is this a
warning from sparse also?

>    917  
>    918          d->clocks = devm_kzalloc(d->dev, sizeof(struct ti_adpll_clock) *
>    919                                   TI_ADPLL_NR_CLOCKS,
>    920                                   GFP_KERNEL);
>    921          if (!d->clocks)
>    922                  goto free;
> 
> We don't set the error code here.

Fixed by Stephen.

>    924          err = ti_adpll_init_dco(d);
>    925          if (err) {
>    926                  dev_err(dev, "could not register dco: %i\n", err);
>    927                  goto free;
>    928          }
>    929  
>    930          err = ti_adpll_init_children_adpll_s(d);
>    931          if (err)
>    932                  goto free;
>    933          err = ti_adpll_init_children_adpll_lj(d);
>    934          if (err)
>    935                  goto free;
>    936  
>    937          err = of_clk_add_provider(d->np, of_clk_src_onecell_get, &d->outputs);
>    938          if (err)
>    939                  goto free;
>    940  
>    941          return 0;
>    942  
>    943  free:
>    944          WARN_ON(1);
>    945          ti_adpll_free_resources(d);
> 
> This is a classic one err bug, where we have a single exit point but
> it's too complicated and subtle to handle all errors so we mess up.  The
> label doesn't indicate what we are freeing.

Well there's really not much to free with devm.. We could rename
the label to unregister to avoid confusion?

> Ideally, the allocate and the free functions mirror each other but I
> don't see a ti_adpll_(alloc|register|whatever)_resources().  Possibly
> this is a mirror of ti_adpll_init_dco() so it could be called
> ti_adpll_free_dco()?  I'm not sure.

Or it could be just be renamed to ti_adpll_unregister() as
we're not freeing any memory there.

Regards,

Tony
