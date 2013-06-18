From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH 1/4] MFD: Palmas: Add Interrupt feature
Date: Tue, 18 Jun 2013 09:01:32 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EC360@DBDE04.ent.ti.com>
References: <1371470954-9124-1-git-send-email-j-keerthy@ti.com>
 <1371470954-9124-2-git-send-email-j-keerthy@ti.com>
 <20130617161615.GH1403@sirena.org.uk>
 <DC88CAD03C0052499C1907B327FC63229EC277@DBDE04.ent.ti.com>
 <20130618085825.GL1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130618085825.GL1403@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Mark,


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, June 18, 2013 2:28 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; ldewangan@nvidia.com;
> sameo@linux.intel.com; grant.likely@secretlab.ca; swarren@nvidia.com;
> linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org;
> gg@slimlogic.co.uk
> Subject: Re: [PATCH 1/4] MFD: Palmas: Add Interrupt feature
> 
> On Tue, Jun 18, 2013 at 05:15:03AM +0000, J, KEERTHY wrote:
> 
> > I understand your point. The IRQ is passed from device tree node.
> > Say if the chip for some reason is not connected to any valid IRQ
> line
> > the driver might end up requesting for a wrong IRQ line.
> 
> > So should I be validating the irq entry populated from  device tree?
> 
> Yes, you should be checking that there's actually an interrupt there -
> the number will be zero if there isn't.
> 
> > Explicitly checking on chip ID helps to avoid wrongly populated
> Device
> > tree data.
> 
> Right, but on the other hand it ought to be possible to handle chips
> that could but aren't configured to do interrupts and if the driver can
> do that then this becomes redundant.

I understood. I am now implementing this in the driver making use
Of the of_parse_phandle and check if the interrupts property is
Populated and only then request for irq else skip that. Hope this
Approach is fine. I will send v2 in a while.

Regards,
Keerthy
