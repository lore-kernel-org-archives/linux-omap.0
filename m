From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Date: Wed, 19 Dec 2018 16:48:52 +0100
Message-ID: <6ebcd7a6-6c85-0312-0651-fb4fbfc25e55@lechnology.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com> <5C191770.9090804@ti.com>
 <20181219123812.GC8130@sirena.org.uk> <5C1A670E.9020904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C1A670E.9020904@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Mark Brown <broonie@kernel.org>
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/19/18 4:43 PM, Roger Quadros wrote:
> On 19/12/18 14:38, Mark Brown wrote:
>> On Tue, Dec 18, 2018 at 05:51:12PM +0200, Roger Quadros wrote:
>>
>>> We could combine control and debug into one iomap and use
>>> 2 regmap ranges. But this is really working around the
>>> regmap_mmio limitation of not being able to use more than one ioremaps.
>>
>>> Mark, any suggestions?
>>
>> If they're separate regions why not create separate regmaps for them?
>>
> 
> I tried that but only the first regmap shows up in debugfs.
> 
> e.g.
> 
> +
> +       pru->ctrl_regmap = devm_regmap_init_mmio(dev, pru->iomem_regions[PRU_IOMEM_CTRL].va,
> +                                                &pru_regmap_config);
> +       if (IS_ERR(pru->ctrl_regmap)) {
> +               ret = PTR_ERR(pru->ctrl_regmap);
> +               dev_err(dev, "CTRL regmap init failed: %d\n", ret);
> +               goto free_rproc;
> +       }
> +
> +
> +       pru->debug_regmap = devm_regmap_init_mmio(dev, pru->iomem_regions[PRU_IOMEM_DEBUG].va,
> +                                                 &pru_debug_regmap_config);
> +       if (IS_ERR(pru->debug_regmap)) {
> +               ret = PTR_ERR(pru->debug_regmap);
> +               dev_err(dev, "DEBUG regmap init failed: %d\n", ret);
> +               goto free_rproc;
>          }
> 
> 
> Did I do something wrong or we just need to enhance regmap_debugfs.c?

Do you assign the name field in pru_regmap_config and 
pru_debug_regmap_config?
