From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: Fix kernel BUG for DT boot mode
Date: Tue, 16 Oct 2012 10:43:19 -0700
Message-ID: <20121016174319.GU15569@atomide.com>
References: <1349773040-8204-1-git-send-email-hvaibhav@ti.com>
 <20121010140027.GB13724@beef>
 <79CD15C6BA57404B839C016229A409A83EB3B573@DBDE01.ent.ti.com>
 <20121010143501.GC13724@beef>
 <20121010143742.GE13724@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33727 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755404Ab2JPRnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 13:43:24 -0400
Content-Disposition: inline
In-Reply-To: <20121010143742.GE13724@beef>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Matt Porter <mporter@ti.com> [121010 07:38]:
> On Wed, Oct 10, 2012 at 10:35:01AM -0400, Matt Porter wrote:
> > On Wed, Oct 10, 2012 at 02:19:40PM +0000, Vaibhav Hiremath wrote:
> > > On Wed, Oct 10, 2012 at 19:30:27, Porter, Matt wrote:
> > > > On Tue, Oct 09, 2012 at 02:27:20PM +0530, Vaibhav Hiremath wrote:
> > > > > With recent changes in omap gpmc driver code, in case of DT
> > > > > boot mode, where bootloader does not configure gpmc cs space
> > > > > will result into kernel BUG() inside gpmc_mem_init() function,
> > > > > as gpmc cs0 gpmc_config7[0].csvalid bit is set to '1' and
> > > > > gpmc_config7[0].baseaddress is set to '0' on reset.
> > > > > 
> > > > > This use-case is applicable for any board/EVM which doesn't have
> > > > > any peripheral connected to gpmc cs0, for example BeagleXM and
> > > > > BeagleBone, so DT boot mode fails.
> > > > > 
> > > > > This patch adds of_have_populated_dt() check before creating
> > > > > device, so that for DT boot mode, gpmc probe will not be called
> > > > > which is expected behavior, as gpmc is not supported yet from DT.
> > > > > 
> > > > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > > Cc: Afzal Mohammed <afzal@ti.com>
> > > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > > Cc Paul Walmsley <paul@pwsan.com>
> > > > > ---
> > > > > This should go in for rc1, as this breaks AM33xx boot.
> > > > 
> > > > Fixes BeagleBone on mainline.
> > > > 
> > > > Tested-by: Matt Porter <mporter@ti.com>
> > > > 
> > > 
> > > Thanks Matt and Afzal,
> > > 
> > > Tony can this be picked up for rc1?? I know you have already sent pull 
> > > request for rc1, but by any chance you are planning to send another request?
> > 
> > I also found a separate problem with the mcasp clock data that's needed
> > for rc1. I just posted a patch for that as I need both this patch and the
> > clock data fix to boot from current mainline.
> 
> Disregard now that you got me pointed to the pull request with this :)

Thanks applying $Subject patch into omap-for-v3.7-rc1/fixes-part2 and
ignoring the comments about the mcasp clock as it sounds like the mcasp
is already fixed.

Regards,

Tony
