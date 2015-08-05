From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: use *syscon* framework API to write
 to mailbox register
Date: Wed, 5 Aug 2015 19:37:01 +0530
Message-ID: <55C21885.6000902@ti.com>
References: <1438697169-32359-1-git-send-email-kishon@ti.com> <20150805080113.GV16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150805080113.GV16878-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 05 August 2015 01:31 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150804 07:11]:
>> Deprecate using phy-omap-control driver to write to the mailbox register
>> and start using *syscon* framework to do the same.
> ..
>> @@ -512,6 +558,40 @@ static const struct musb_platform_ops omap2430_ops = {
>>  
>>  static u64 omap2430_dmamask = DMA_BIT_MASK(32);
>>  
>> +static int omap2430_get_sys_ctrl(struct omap2430_glue *glue,
>> +				 struct device_node *np)
>> +{
>> +	struct device_node *control_node;
>> +	struct platform_device *control_pdev;
>> +
>> +	glue->syscon_otghs = syscon_regmap_lookup_by_phandle(np,
>> +							     "syscon-otghs");
>> +	if (IS_ERR(glue->syscon_otghs)) {
>> +		dev_dbg(glue->dev, "can't get syscon, using control device\n");
>> +		glue->syscon_otghs = NULL;
>> +
>> +		control_node = of_parse_phandle(np, "ctrl-module", 0);
>> +		if (control_node) {
>> +			control_pdev = of_find_device_by_node(control_node);
>> +			if (!control_pdev) {
>> +				dev_err(glue->dev,
>> +					"Failed to get control device\n");
>> +				return -EINVAL;
>> +			}
>> +			glue->control_otghs = &control_pdev->dev;
>> +		}
>> +	} else {
>> +		if (of_property_read_u32_index(np, "syscon-otghs", 1,
>> +					       &glue->otghs_reg)) {
>> +			dev_err(glue->dev,
>> +				"couldn't get otghs reg. offset\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> We don't have syscon-otghs and to me it seems we need a PHY driver
> as I pointed out at:

If *syscon-otghs* is not present, then it'll fall-back to using the *ctrl-module*.
> 
> https://lkml.org/lkml/2015/6/24/231

Maybe I should have explained this in the previous thread. The *otghs* register
that we are trying to access here does _not_ belong to the PHY. It acts as
mailbox register from MUSB glue (TI integration layer) to MUSB core. That's why
it's programmed in the TI glue layer (omap2430.c).

Even when we were using the older API [omap_control_usb_set_mode()], we first
call omap_musb_mailbox from the PHY drivers (phy-twl4030-usb.c,
phy-twl6030-usb.c) and then omap_musb_mailbox in the TI glue writes to the
control module instead of PHY drivers directly calling omap_control_usb_set_mode().
> 
> So let's sort that issue first. It also seems this just completely
> breaks the MUSB support?

Why do you think so? If *syscon-otghs* is not present in dt, then it'll
fall-back to using the *ctrl-module* and everything should work seamlessly.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
