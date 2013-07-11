From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/4] MFD: Palmas: Check if irq is valid
Date: Thu, 11 Jul 2013 12:27:20 +0100
Message-ID: <20130711112720.GK25601@gmail.com>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
 <1371621470-22279-2-git-send-email-j-keerthy@ti.com>
 <20130711112531.GJ25601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130711112531.GJ25601@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Thu, 11 Jul 2013, Lee Jones wrote:

> On Wed, 19 Jun 2013, Keerthy wrote:
>=20
> > From: J Keerthy <j-keerthy@ti.com>
> >=20
> > Check if irq value obtained is valid. If it is not valid
> > then skip the irq request step and go ahead with the probe.
> >=20
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > ---
> >  drivers/mfd/palmas.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> Applied with Stephen and Mark's RB.

Scrap that, it appears to be applied already.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
