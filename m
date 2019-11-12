From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 03/17] remoteproc/omap: Add device tree support
Date: Tue, 12 Nov 2019 10:14:55 +0200
Message-ID: <0698f722-c56f-005a-cd9f-51199d73bd12@ti.com>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-4-t-kristo@ti.com> <20191111231650.GE3108315@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111231650.GE3108315@builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 12/11/2019 01:16, Bjorn Andersson wrote:
> On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
>> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> [..]
>> +static int omap_rproc_get_boot_data(struct platform_device *pdev,
>> +				    struct rproc *rproc)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct omap_rproc *oproc = rproc->priv;
>> +	int ret;
>> +
>> +	if (!of_device_is_compatible(np, "ti,omap4-dsp") &&
>> +	    !of_device_is_compatible(np, "ti,omap5-dsp"))
>> +		return 0;
> 
> I think it would be cleaner if you added a "has_bootreg" bool to your
> omap_rproc_dev_data, do of_device_get_match_data() in omap_rproc_probe()
> and pass that here.

Hmm you are right. There seem to be couple of other similar checks 
around the code, let me try to address those as well.

> 
>> +
>> +	oproc->boot_data = devm_kzalloc(&pdev->dev, sizeof(*oproc->boot_data),
>> +					GFP_KERNEL);
>> +	if (!oproc->boot_data)
>> +		return -ENOMEM;
>> +
>> +	if (!of_property_read_bool(np, "syscon-bootreg")) {
>> +		dev_err(&pdev->dev, "syscon-bootreg property is missing\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	oproc->boot_data->syscon =
>> +			syscon_regmap_lookup_by_phandle(np, "syscon-bootreg");
> 
> You updated the dt binding document, but this needs to be updated as
> well.

Yeah, was waiting for comments before updating the actual code.

-Tero

> 
> Regards,
> Bjorn
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
