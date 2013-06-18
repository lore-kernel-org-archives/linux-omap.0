From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v2 1/4] MFD: Palmas: Check if interrupts property exists
 and then only request irq
Date: Tue, 18 Jun 2013 16:54:28 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EC563@DBDE04.ent.ti.com>
References: <1371549692-7361-1-git-send-email-j-keerthy@ti.com>
 <1371549692-7361-2-git-send-email-j-keerthy@ti.com>
 <51C0820B.4020404@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C0820B.4020404@wwwdotorg.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

> -----Original Message-----
> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> Sent: Tuesday, June 18, 2013 9:22 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; broonie@kernel.org;
> ldewangan@nvidia.com; sameo@linux.intel.com; grant.likely@secretlab.ca;
> swarren@nvidia.com; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org; gg@slimlogic.co.uk
> Subject: Re: [PATCH v2 1/4] MFD: Palmas: Check if interrupts property
> exists and then only request irq
> 
> On 06/18/2013 04:01 AM, J Keerthy wrote:
> > Check if interrupts property exists and then only request irq.
> > On some boards INT line might not be connected to a valid irq line on
> > the application processor. Hence keeping a check before requesting
> > irq.
> 
> When there is no interrupts property, surely i2c->irq == 0, which is an
> invalid IRQ, and hence there's no need to check this before copying the
> value?

The intent here is NOT to request irq with 0 or Invalid IRQ. The board
File will not populate the interrupts entry if the INT line is not
Connected. Hence the patch checks for the 'interrupts' property.

This is essential since I do not want the probe to return error
Just because the i2c->irq == 0. The explicit check for the property
Ensures that the board does not have the INT line connected to
A valid interrupt line on the other side.

> 
> In other words, I think this whole patch could just be:
> 
> + 	palmas->irq = i2c->irq;
> 
> right?

Just this will cause a probe failure. That is not what is needed.
Instead the probe should continue skipping irq part.

Regards,
Keerthy
