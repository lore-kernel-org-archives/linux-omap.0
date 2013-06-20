From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH v3 1/4] MFD: Palmas: Check if irq is valid
Date: Thu, 20 Jun 2013 04:16:32 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229ECBBF@DBDE04.ent.ti.com>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
 <1371621470-22279-2-git-send-email-j-keerthy@ti.com>
 <20130619164254.GA1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130619164254.GA1403@sirena.org.uk>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, June 19, 2013 10:13 PM
> To: J, KEERTHY
> Cc: linux-omap@vger.kernel.org; ldewangan@nvidia.com;
> sameo@linux.intel.com; grant.likely@secretlab.ca; swarren@nvidia.com;
> linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org; devicetree-
> discuss@lists.ozlabs.org; gg@slimlogic.co.uk
> Subject: Re: [PATCH v3 1/4] MFD: Palmas: Check if irq is valid
> 
> On Wed, Jun 19, 2013 at 11:27:47AM +0530, Keerthy wrote:
> > From: J Keerthy <j-keerthy@ti.com>
> >
> > Check if irq value obtained is valid. If it is not valid then skip
> the
> > irq request step and go ahead with the probe.
> >
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> 
> Reviewed-by: Mark Brown <broonie@linaro.org>

Thanks Mark.
