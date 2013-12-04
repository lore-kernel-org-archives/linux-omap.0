From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH 3/4] Regulators: TPS65218: Add Regulator driver for
 TPS65218 PMIC
Date: Wed, 4 Dec 2013 13:09:20 +0530
Message-ID: <CAKDJKT6TMHEboET4=iVEM2qbi6Bz7kCyyjutLfym2pwrwtEGVg@mail.gmail.com>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
	<1386053006-6480-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386053006-6480-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, ijc+devicetree@hellion.org.uk, Rob Landley <rob@landley.net>, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Keerthy,

> +       rdev = regulator_register(&regulators[id], &config);

Can you make use of "devm_regulator_register" instead?

> +       if (IS_ERR(rdev)) {
> +               dev_err(tps->dev, "failed to register %s regulator\n",
> +                       pdev->name);
> +               return PTR_ERR(rdev);
> +       }
> +
> +       /* Save regulator */
> +       tps->rdev[id] = rdev;
> +
> +       return 0;
> +}


Best Regards
Manish Badarkhe
