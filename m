From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 03/41] CLK: ti: add init support for clock IP blocks
Date: Tue, 17 Dec 2013 08:32:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170829290.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-4-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312170745360.14039@utopia.booyaka.com> <52B009A2.5000107@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53928 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3LQIcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 03:32:45 -0500
In-Reply-To: <52B009A2.5000107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 17 Dec 2013, Tero Kristo wrote:

> On 12/17/2013 10:14 AM, Paul Walmsley wrote:
> > On Tue, 26 Nov 2013, Tero Kristo wrote:
> > 
> > > ti_dt_clk_init_provider() can now be used to initialize the contents of
> > > a single clock IP block. This parses all the clocks under the IP block
> > > and calls the corresponding init function for them.
> > > 
> > > This patch also introduces a helper function for the TI clock drivers
> > > to get register info from DT and append the master IP info to this.
> > > 
> > > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
> > > index ef1a7cd..63f85e9 100644
> > > --- a/drivers/clk/ti/clk.c
> > > +++ b/drivers/clk/ti/clk.c
> > > @@ -19,10 +19,15 @@
> > >   #include <linux/clkdev.h>
> > >   #include <linux/clk/ti.h>
> > >   #include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/list.h>
> > > 
> > >   #undef pr_fmt
> > >   #define pr_fmt(fmt) "%s: " fmt, __func__
> > > 
> > > +extern struct of_device_id __clk_of_table[];
> > 
> > This results in a checkpatch.pl warning:
> > 
> > WARNING: externs should be avoided in .c files
> > #33: FILE: drivers/clk/ti/clk.c:28:
> > +extern struct of_device_id __clk_of_table[];
> 
> This extern is only needed from this single file, and this code is duplicated
> from drivers/clk/clk.c.

So the right thing to do here is to move it into a separate header file 
that both drivers/clk/clk.c and drivers/clk/ti/clk.c either already 
#include, or can add a new #include for.


- Paul
