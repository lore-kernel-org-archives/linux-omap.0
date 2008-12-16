From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/12] i2c-omap: convert 'rev1' flag to generic 'rev' u8
Date: Tue, 16 Dec 2008 13:34:46 -0800
Message-ID: <20081216213443.GA6746@atomide.com>
References: <20081129013318.13428.88465.stgit@localhost> <20081129013457.13428.65279.stgit@localhost> <20081216215959.GE8032@fluff.org.uk> <20081216220700.GF8032@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53518 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbYLPWbn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 17:31:43 -0500
Content-Disposition: inline
In-Reply-To: <20081216220700.GF8032@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Ben Dooks <ben-linux@fluff.org> [081216 14:07]:
> On Tue, Dec 16, 2008 at 09:59:59PM +0000, Ben Dooks wrote:
> > On Fri, Nov 28, 2008 at 05:34:57PM -0800, Tony Lindgren wrote:
> > > From: Paul Walmsley <paul@pwsan.com>
> > > 
> > > i2c-omap discriminates only between "revision 1" or "greater than
> > > revision 1."  A following patch introduces code that must also
> > > discriminate between rev2.x, rev3.6, and rev3.12 controllers.  Support
> > > this by storing the full revision data from the I2C_REV register, rather
> > > than just a single bit.
> > > 
> > > The revision definitions may need to be extended for other ES levels
> > > that aren't currently available here.  rev3.6 is what's present on the
> > > 2430SDP here (unknown ES revision); rev3.12 is used on the 3430ES2
> > > here.
> > > 
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++---------
> > >  1 files changed, 16 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > > index 40a1e4b..3ac510d 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -38,6 +38,13 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/io.h>
> > >  
> > > +/* I2C controller revisions */
> > > +#define OMAP_I2C_REV_2			0x20
> > > +
> > > +/* I2C controller revisions present on specific hardware */
> > > +#define OMAP_I2C_REV_ON_2430		0x36
> > > +#define OMAP_I2C_REV_ON_3430		0x3C
> > > +
> > >  /* timeout waiting for the controller to respond */
> > >  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> > >  
> > > @@ -139,7 +146,7 @@ struct omap_i2c_dev {
> > >  						 * fifo_size==0 implies no fifo
> > >  						 * if set, should be trsh+1
> > >  						 */
> > > -	unsigned		rev1:1;
> > > +	u8			rev;
> > >  	unsigned		b_hw:1;		/* bad h/w fixes */
> > >  	unsigned		idle:1;
> > >  	u16			iestate;	/* Saved interrupt register */
> > > @@ -209,7 +216,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
> > >  
> > >  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> > >  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> > > -	if (dev->rev1) {
> > > +	if (dev->rev < OMAP_I2C_REV_2) {
> > >  		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
> > >  	} else {
> > >  		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
> > > @@ -231,7 +238,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> > >  	unsigned long timeout;
> > >  	unsigned long internal_clk = 0;
> > >  
> > > -	if (!dev->rev1) {
> > > +	if (dev->rev >= OMAP_I2C_REV_2) {
> > >  		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
> > >  		/* For some reason we need to set the EN bit before the
> > >  		 * reset done bit gets set. */
> > > @@ -710,6 +717,7 @@ omap_i2c_probe(struct platform_device *pdev)
> > >  	struct omap_i2c_dev	*dev;
> > >  	struct i2c_adapter	*adap;
> > >  	struct resource		*mem, *irq, *ioarea;
> > > +	void *isr;
> > 
> > There is a proper definition for the function type in
> > <linux/interrupt.h>
> 
> I'm feeling a bit of Christmas spirit finally, will pull these and
> add a fix myself for this.

Thanks, I'll owe you a holiday ale for that :)

Tony
