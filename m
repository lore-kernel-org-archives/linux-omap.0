From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
Date: Thu, 23 Feb 2012 09:26:13 -0500
Message-ID: <20120223142612.GA13407@beef>
References: <1329929103-28486-1-git-send-email-mporter@ti.com>
 <79CD15C6BA57404B839C016229A409A8317DA6CD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317DA6CD@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 23, 2012 at 12:08:34PM +0000, Hiremath, Vaibhav wrote:
> On Wed, Feb 22, 2012 at 22:15:03, Porter, Matt wrote:
> >  /*
> >   * Initialize smsc911x device connected to the GPMC. Note that we
> >   * assume that pin multiplexing is done in the board-*.c file,
> > @@ -51,10 +97,16 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
> >  {
> >  	struct platform_device *pdev;
> >  	unsigned long cs_mem_base;
> > -	int ret;
> > +	int ret, err;
> >  
> 
> Do you really need another variable here? Can't you use "ret" here?

No we don't, thanks for catching this. I posted a v3 that addresses it.

Tony: can you revert v2 for v3 that I just posted which addresses
Vaibhav's comment?

-Matt
