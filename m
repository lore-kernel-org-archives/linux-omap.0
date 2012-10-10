From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode
Date: Wed, 10 Oct 2012 10:35:01 -0400
Message-ID: <20121010143501.GC13724@beef>
References: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
 <20121010140027.GB13724@beef>
 <79CD15C6BA57404B839C016229A409A83EB3B573@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB3B573@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 10, 2012 at 02:19:40PM +0000, Vaibhav Hiremath wrote:
> On Wed, Oct 10, 2012 at 19:30:27, Porter, Matt wrote:
> > On Tue, Oct 09, 2012 at 02:27:20PM +0530, Vaibhav Hiremath wrote:
> > > With recent changes in omap gpmc driver code, in case of DT
> > > boot mode, where bootloader does not configure gpmc cs space
> > > will result into kernel BUG() inside gpmc_mem_init() function,
> > > as gpmc cs0 gpmc_config7[0].csvalid bit is set to '1' and
> > > gpmc_config7[0].baseaddress is set to '0' on reset.
> > > 
> > > This use-case is applicable for any board/EVM which doesn't have
> > > any peripheral connected to gpmc cs0, for example BeagleXM and
> > > BeagleBone, so DT boot mode fails.
> > > 
> > > This patch adds of_have_populated_dt() check before creating
> > > device, so that for DT boot mode, gpmc probe will not be called
> > > which is expected behavior, as gpmc is not supported yet from DT.
> > > 
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Afzal Mohammed <afzal@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc Paul Walmsley <paul@pwsan.com>
> > > ---
> > > This should go in for rc1, as this breaks AM33xx boot.
> > 
> > Fixes BeagleBone on mainline.
> > 
> > Tested-by: Matt Porter <mporter@ti.com>
> > 
> 
> Thanks Matt and Afzal,
> 
> Tony can this be picked up for rc1?? I know you have already sent pull 
> request for rc1, but by any chance you are planning to send another request?

I also found a separate problem with the mcasp clock data that's needed
for rc1. I just posted a patch for that as I need both this patch and the
clock data fix to boot from current mainline.

-Matt
