From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: RE: [PATCH 3/4] regulators: Add TPS659038 documentation under Palmas
Date: Thu, 27 Jun 2013 04:34:35 +0000
Message-ID: <DC88CAD03C0052499C1907B327FC63229F020C@DBDE04.ent.ti.com>
References: <1371726344-10115-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371726344-10115-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "ldewangan@nvidia.com" <ldewangan@nvidia.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello Grant,

> -----Original Message-----
> From: J, KEERTHY
> Sent: Thursday, June 20, 2013 4:36 PM
> To: linux-omap@vger.kernel.org; grant.likely@secretlab.ca
> Cc: broonie@kernel.org; J, KEERTHY; ldewangan@nvidia.com;
> sameo@linux.intel.com; swarren@nvidia.com; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org; devicetree-
> discuss@lists.ozlabs.org; gg@slimlogic.co.uk
> Subject: [PATCH 3/4] regulators: Add TPS659038 documentation under
> Palmas
> 
> Add TPS659038 documentation under Palmas.
> 

Could you please pull this one?

> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Acked-by: Mark Brown <broonie@linaro.org>
> ---
>  .../devicetree/bindings/regulator/palmas-pmic.txt  |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/palmas-
> pmic.txt b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
> index d5a3086..5115cd7 100644
> --- a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
> +++ b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
> @@ -7,6 +7,7 @@ Required properties:
>    ti,twl6037-pmic
>    ti,tps65913-pmic
>    ti,tps65914-pmic
> +  ti,tps659038-pmic
>  and also the generic series names
>    ti,palmas-pmic
>  - interrupt-parent : The parent interrupt controller which is palmas.
> --
> 1.7.5.4

Regards,
Keerthy
