From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v2 1/4] MFD: Palmas: Check if interrupts property exists
 and then only request irq
Date: Tue, 18 Jun 2013 17:19:14 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EC5B4@DBDE04.ent.ti.com>
References: <1371549692-7361-1-git-send-email-j-keerthy@ti.com>
 <1371549692-7361-2-git-send-email-j-keerthy@ti.com>
 <51C0820B.4020404@wwwdotorg.org>
 <DC88CAD03C0052499C1907B327FC63229EC563@DBDE04.ent.ti.com>
 <51C093FF.6000204@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40324 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933106Ab3FRRTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 13:19:37 -0400
In-Reply-To: <51C093FF.6000204@wwwdotorg.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>



> -----Original Message-----
> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> Sent: Tuesday, June 18, 2013 10:38 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; broonie@kernel.org;
> ldewangan@nvidia.com; sameo@linux.intel.com; grant.likely@secretlab.ca;
> swarren@nvidia.com; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org; gg@slimlogic.co.uk
> Subject: Re: [PATCH v2 1/4] MFD: Palmas: Check if interrupts property
> exists and then only request irq
> 
> On 06/18/2013 10:54 AM, J, KEERTHY wrote:
> > Hi Stephen,
> >
> >> -----Original Message-----
> >> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> >> Sent: Tuesday, June 18, 2013 9:22 PM
> >> To: J, KEERTHY
> >> Cc: linux-omap@vger.kernel.org; broonie@kernel.org;
> >> ldewangan@nvidia.com; sameo@linux.intel.com;
> >> grant.likely@secretlab.ca; swarren@nvidia.com;
> >> linux-kernel@vger.kernel.org; linux- doc@vger.kernel.org;
> >> gg@slimlogic.co.uk
> >> Subject: Re: [PATCH v2 1/4] MFD: Palmas: Check if interrupts
> property
> >> exists and then only request irq
> >>
> >> On 06/18/2013 04:01 AM, J Keerthy wrote:
> >>> Check if interrupts property exists and then only request irq.
> >>> On some boards INT line might not be connected to a valid irq line
> >>> on the application processor. Hence keeping a check before
> >>> requesting irq.
> >>
> >> When there is no interrupts property, surely i2c->irq == 0, which is
> >> an invalid IRQ, and hence there's no need to check this before
> >> copying the value?
> >
> > The intent here is NOT to request irq with 0 or Invalid IRQ.
> 
> Sure.
> 
> > The board File will not populate the interrupts entry if the INT line
> > is not Connected.
> 
> Do you mean the interrupts DT property won't be present if there is no
> interrupt. If so, sure.

Yes.

> 
> > Hence the patch checks for the 'interrupts' property.
> 
> That shouldn't be necessary; IIRC, the I2C core has already parsed the
> interrupts property if there was one, and if there wasn't, it has set
> i2c->irq to some invalid value already.
> 
> So, you simply need to check the value in i2c->irq, and don't need to
> look at the DT at all.

Instead of checking the Invalid irq value which most likely can be 0.
I am not sure.
I am explicitly checking if the interrupts property exists or not.

If not present then It throws out a warning. Either there is no
Valid INT line connection or the DeviceTree was not populated fully.

This additional piece of information is good to have in the driver
IMHO. Let me know if this is rational enough to have in the driver.

Regards,
Keerthy
