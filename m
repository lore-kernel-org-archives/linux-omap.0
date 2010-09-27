From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 08/10] TWL IRQ: Fix fucntion declaration warnings
Date: Mon, 27 Sep 2010 18:40:08 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8CCE@dbde02.ent.ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
 <1285063280-4057-9-git-send-email-manjugk@ti.com>
 <20100927111609.GF2560@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35201 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759150Ab0I0NKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 09:10:20 -0400
In-Reply-To: <20100927111609.GF2560@sortiz-mobl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>


Hi Samuel,

> -----Original Message-----
> From: Samuel Ortiz [mailto:sameo@linux.intel.com] 
> Sent: Monday, September 27, 2010 4:46 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Tony Lindgren; Menon, Nishanth
> Subject: Re: [PATCH v2 08/10] TWL IRQ: Fix fucntion 
> declaration warnings
> 
> Hi Manjunath,
> 
> On Tue, Sep 21, 2010 at 03:31:18PM +0530, G, Manjunath Kondaiah wrote:
> > Fixes following sparse warnings for twl4030 and twl6030 irq files.
> > 
> > drivers/mfd/twl4030-irq.c:783:5: warning: symbol 
> 'twl4030_init_irq' was not declared. Should it be static?
> > drivers/mfd/twl4030-irq.c:863:5: warning: symbol 
> 'twl4030_exit_irq' was not declared. Should it be static?
> > drivers/mfd/twl4030-irq.c:873:5: warning: symbol 
> 'twl4030_init_chip_irq' was not declared. Should it be static?
> > 
> > drivers/mfd/twl6030-irq.c:226:5: warning: symbol 
> 'twl6030_init_irq' was not declared. Should it be static?
> > drivers/mfd/twl6030-irq.c:290:5: warning: symbol 
> 'twl6030_exit_irq' was not declared. Should it be static?
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > ---
> >  include/linux/i2c/twl.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/i2c/twl.h 
> b/include/linux/i2c/twl.h index 
> > 6de90bf..c61e90a 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -172,6 +172,11 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, 
> > unsigned num_bytes);
> >  
> >  int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);  int 
> > twl6030_interrupt_mask(u8 bit_mask, u8 offset);
> > +int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned 
> > +irq_end); int twl6030_exit_irq(void); int twl4030_init_irq(int 
> > +irq_num, unsigned irq_base, unsigned irq_end); int 
> > +twl4030_exit_irq(void); int twl4030_init_chip_irq(const 
> char *chip);
> No, we don't want to export those. Try defining them as 
> extern from twl*-irq.c.

Having extern in .c file will generate checkpatch warning as:
WARNING: externs should be avoided in .c files

-Manjunath