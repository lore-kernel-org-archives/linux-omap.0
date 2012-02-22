From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
Date: Wed, 22 Feb 2012 11:29:01 -0500
Message-ID: <20120222162901.GB20411@beef>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
 <20120214110836.GE15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120214110836.GE15338@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 14, 2012 at 11:08:36AM +0000, Russell King - ARM Linux wrote:
> Two more points:
> 
> On Mon, Feb 13, 2012 at 11:43:42AM -0500, Matt Porter wrote:
> > This fixes smsc911x support on platforms using gpmc_smsc911x_init().
> > Commit c7e963f6888816f04d1f5da0e07bec4e0092f227 added the requirement
> 
> Always include the commit summary as well here, so:
> 
> Commit c7e963f6888816 (net/smsc911x: Add regulator support) added the ...

Ok. Addressed in v2.

> > @@ -55,6 +94,11 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
> >  
> >  	gpmc_cfg = board_data;
> >  
> > +	if (platform_device_register(&gpmc_smsc911x_regulator) < 0) {
> > +		pr_err("Unable to register smsc911x regulators\n");
> > +		return;
> > +	}
> 
> It's always a good idea to indicate why something failed:
> 
> 	err = platform_device_register(&gpmc_smsc911x_regulator);
> 	if (err < 0) {
> 		pr_err("Unable to register smsc911x regulators: %d\n", err);
> 		return;
> 	}
> 
> so that people can see not only what failed, but also why it failed.

Looks much better, also addressed in v2.

-Matt
