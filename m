From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v3 0/4] MFD: Palmas: Add TPS659038 PMIC support on Palmas
Date: Thu, 20 Jun 2013 08:41:39 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229ECD8E@DBDE04.ent.ti.com>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
 <20130620083913.GC15667@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130620083913.GC15667@zurbaran>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

> -----Original Message-----
> From: Samuel Ortiz [mailto:sameo@linux.intel.com]
> Sent: Thursday, June 20, 2013 2:09 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; broonie@kernel.org;
> ldewangan@nvidia.com; grant.likely@secretlab.ca; swarren@nvidia.com;
> linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org; devicetree-
> discuss@lists.ozlabs.org; gg@slimlogic.co.uk
> Subject: Re: [PATCH v3 0/4] MFD: Palmas: Add TPS659038 PMIC support on
> Palmas
> 
> Hi,
> 
> On Wed, Jun 19, 2013 at 11:27:46AM +0530, Keerthy wrote:
> > From: J Keerthy <j-keerthy@ti.com>
> >
> > The Patch series adds TPS659038 PMIC support in the palmas MFD and
> > Regulator drivers. The TPS659038 has almost the same registers as of
> > the earlier supported variants of PALMAS family such as the TWL6035.
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
> > The patch series is based on the patch:
> >
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90598.html
> >
> > V3:
> >
> > Implements Interrupts check using i2c->irq variable instead of DT
> > "interrupts" property.
> >
> > Cleans ups in assiging the features variable in patch 2.
> >
> > V2:
> >
> > Implements Interrupts checking via DT instead of creating flags and
> > checking based on chip ID.
> >
> > J Keerthy (4):
> >   MFD: Palmas: Check if irq is valid
> >   MFD: Palmas: Add SMPS10_BOOST feature
> >   mfd: Palmas: Add TPS659038 PMIC support
> >   regulator: Palmas: Add TPS659038 support
> I took the first 2 patches, but patch #3 does not apply.
> 

Thanks. I will split 3 and 4 separating Documentation files.
The Documentation was taken by Grant. So I will split the
Patches 3 and 4 and send a separate series. Thanks again for pulling
1 and 2.

> Cheers,
> Samuel.
> 
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/

Regards,
Keerthy
