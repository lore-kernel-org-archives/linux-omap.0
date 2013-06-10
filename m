From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] ARM: dts: add dtsi for palmas
Date: Mon, 10 Jun 2013 09:04:20 +0100
Message-ID: <20130610080420.GC24958@gmail.com>
References: <1370604504-32310-1-git-send-email-j-keerthy@ti.com>
 <51B23AD5.8060006@wwwdotorg.org>
 <DC88CAD03C0052499C1907B327FC63229EAA39@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229EAA39@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "swarren@nvidia.com" <swarren@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

> Totally agree to all the above concerns. So can we have a custom .dts=
i file
> for a board+pmic combination? Or have only the required properties ov=
er ridden
> in the board file?

The common approach is to only apply nodes and node properties to the
=2Edtsi files which are appropriate for _all_ platforms which include
them. Anything that is only relevant to a sub-set of boards should be
in a higher ranking .dtsi file and finally, any settings which are
board specific should be in the board's .dts file.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
