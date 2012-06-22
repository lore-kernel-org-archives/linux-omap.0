From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add one-register-per-pin type device tree based
 pinctrl driver
Date: Fri, 22 Jun 2012 11:32:48 -0600
Message-ID: <4FE4AC40.8080400@wwwdotorg.org>
References: <20120611135826.GB12766@atomide.com> <4FDA6FCD.1020605@wwwdotorg.org> <20120615094938.GQ12766@atomide.com> <4FDB6000.5080703@wwwdotorg.org> <20120618055036.GU12766@atomide.com> <20120619135600.GX12766@atomide.com> <4FE39C86.5070901@wwwdotorg.org> <20120622083955.GZ12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120622083955.GZ12766@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-omap@vger.kernel.org

On 06/22/2012 02:39 AM, Tony Lindgren wrote:
> Hi,
> 
> * Stephen Warren <swarren@wwwdotorg.org> [120621 15:17]:
>> On 06/19/2012 07:56 AM, Tony Lindgren wrote:
>>> +
>>> +- pinctrl-single,pinconf-mask : mask of allowed pinconf bits in the
>>> +  pinmux register; this gets combined with pinconf mask but is a separate
>>> +  mask to allow the option of setting pinconf separatately from the
>>> +  function
>>
>> Given that this binding doesn't allow describing pin configuration at
>> present, I would simply remove all mention of that property in the
>> binding documentation. It can be added back if/when that feature is
>> added. Any future driver using this binding can refuse to allow pin
>> configuration if that property is missing.
> 
> It might be better to just add support for pin_config_get/set to avoid
> changing the binding later:
> 
>  static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
>                                 unsigned pin, unsigned long *config)
>  {
> -	return -ENOTSUPP;
> +	struct pcs_device *pcs;
> +	void __iomem *reg;
> +	int res;
> +
> +	pcs = pinctrl_dev_get_drvdata(pctldev);
> +	res = pcs_pin_to_reg(pcs, pin, &reg);
> +	if (res)
> +		return res;
> +
> +	return pcs->read(reg) & pcs->cmask;
>  }
> 
> A have not done that yet as currently the pcs_pin_to_reg() would need to be
> sorted out in somewhat clean manner.

Yes, implementing pinconf in the driver and binding would be a fine
alternative; I just assumed you'd want to defer that. How would pinconf
be represented in DT; just extra bits set in the value portion of the
pins property? Thinking quickly, I guess that would work fine, since the
binding's assumption is presumably that there's a 1:1 mapping between
the set of pins that functions can be mux'd onto and the set of pins
that can have pinconf applied, and the register to do both muxing and
pinconf is the same.
