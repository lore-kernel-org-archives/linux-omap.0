From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH 2/4] MFD: Palmas: Add TPS659038 PMIC support
Date: Mon, 24 Jun 2013 16:21:34 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229EF57C@DBDE04.ent.ti.com>
References: <1371726316-10078-1-git-send-email-j-keerthy@ti.com>
 <20130624114322.GB30838@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130624114322.GB30838@zurbaran>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Samuel Ortiz [mailto:sameo@linux.intel.com]
> Sent: Monday, June 24, 2013 5:13 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; broonie@kernel.org;
> ldewangan@nvidia.com; grant.likely@secretlab.ca; swarren@nvidia.com;
> linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org; devicetree-
> discuss@lists.ozlabs.org; gg@slimlogic.co.uk
> Subject: Re: [PATCH 2/4] MFD: Palmas: Add TPS659038 PMIC support
> 
> Hi,
> 
> On Thu, Jun 20, 2013 at 04:35:16PM +0530, J Keerthy wrote:
> > The Patch adds TPS659038 PMIC support in the palmas mfd driver.
> > The TPS659038 has almost the same registers as of the earlier
> > supported variants of PALMAS family such as the TWL6035.
> >
> > The critical differences between TPS659038 and TWL6035 being:
> >
> > 1) TPS659038 has nothing related to battery charging and back up
> battery stuff.
> > 2) TPS659038 does not have does not have SMPS10(Boost) step up
> convertor.
> > 3) TPS659038 does not have Battery detection and anything related to
> battery.
> > 4) SD card detection, Battery presence detection, Vibrator, USB OTG
> are missing
> >    when compared to TWL6035.
> >
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >  drivers/mfd/palmas.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> Applied, thanks.

Thanks Samuel.

> 
> Cheers,
> Samuel.
> 
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
