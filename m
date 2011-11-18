From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Help with clk API
Date: Fri, 18 Nov 2011 15:20:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111181457390.23193@utopia.booyaka.com>
References: <20111111113159.GK19090@legolas.emea.dhcp.ti.com> <alpine.DEB.2.00.1111150610330.19654@utopia.booyaka.com> <20111116105228.GB27980@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33666 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1KRWUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 17:20:52 -0500
In-Reply-To: <20111116105228.GB27980@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, r-woodruff@ti.com, mturquette@ti.com

Hi

On Wed, 16 Nov 2011, Felipe Balbi wrote:

> ok, so if I understood correctly, xclk60mhsp1_ck is the external clock
> for port 1 and init_60m_clk is the internal optional 60MHz clock, right?

Yes.

> So the final workaround would be something like:
> 
> clk = uhh->utmi_p1_fck;

Since the struct clk representing the clock gate is currently defined to 
be downstream of the struct clk representing the clock mux, rather than 
upstream, you'll need to work with at least two different struct clks 
here:

1. the struct clk representing the gate: usb_host_hs_utmi_p1_clk.
   Maybe call this 'clk_gate' or something.

2. the struct clk representing the mux: utmi_p1_gfclk.
   Maybe call this 'clk_mux'.

Also you haven't explicitly defined 'parent'.

So the above would instead be something like:

clk_gate = uhh->usb_host_hs_utmi_p1_clk;
clk_mux = uhh->utmi_p1_fck; /* assuming this is utmi_p1_gfclk */
parent = uhh->init_60m_fclk;

> /* ensure optional clock is disabled */
> clk_disable(clk);

clk_disable(clk_gate);

And just to be explicit, it's only safe to disable it if the driver has 
enabled it already.

> ret = clk_set_parent(clk, parent);

ret = clk_set_parent(clk_mux, parent);

> if (ret) {
> 	dev_err(uhh->dev, "can't change %s's parent to %s\n",
> 		clk->name, parent->name);
> 	return;

Probably return some error code here.

> }
> 
> ret = clk_enable(clk);

ret = clk_enable(clk_gate);

> if (ret) {
> 	dev_err(uhh->dev, "failed to enable %s\n", clk->name);
> 	return;

Probably return some error code here.

> }
> 
> /* wait 1ms */
> msleep(1);

I'd suggest using usleep_range().  See 
Documentation/timers/timers-howto.txt

> parent = uhh->xclk60mhsp1_ck;
> clk_disable(clk);

clk_disable(clk_gate);

> ret = clk_set_parent(clk, parent);

ret = clk_set_parent(clk_mux, parent);

> if (ret) {
> 	dev_err(uhh->dev, "can't change %s's parent to %s\n",
> 		clk->name, parent->name);
> 	return;

error code

> }
> 
> ret = clk_enable(clk);

ret = clk_enable(clk_gate);

> if (ret) {
> dev_err(uhh->dev, "failed to enable %s\n", clk->name);

return some error code

> }
> 
> and similarly for port 2, but :%s/p1/p2/g
> 
> right ?

yep ;-)


- Paul
