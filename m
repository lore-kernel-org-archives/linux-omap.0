From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH v3 2/7] mfd: retu: Add OF device ID table
Date: Mon, 3 Apr 2017 18:24:39 -0400
Message-ID: <a852be9e-e1f0-0975-abd0-a4a61f3a9750@osg.samsung.com>
References: <20170401071854.23198-1-javier@osg.samsung.com>
 <20170401071854.23198-3-javier@osg.samsung.com>
 <20170403111502.lotjpd746vkhekkg@dell>
 <2147b8c9-02ee-1b9c-a74e-119b0b73d1d7@osg.samsung.com>
 <20170403222010.xgbf7imyieyfroqr@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170403222010.xgbf7imyieyfroqr@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

[adding OMAP folks to cc list]

Hello Rob,

On 04/03/2017 06:20 PM, Rob Herring wrote:
> On Mon, Apr 03, 2017 at 11:45:14AM -0400, Javier Martinez Canillas wrote:
>> Hello Lee,
>>
>> On 04/03/2017 07:15 AM, Lee Jones wrote:
>>
>> [snip]
>>
>>>>  
>>>> +static const struct of_device_id retu_of_match[] = {
>>>> +	{ .compatible = "nokia,retu-mfd" },
>>>> +	{ .compatible = "nokia,tahvo-mfd" },
>>>
>>> Please drop the "-mfd".
>>>
>>
>> Yes, I also didn't like it but I didn't want to change it since that would
>> mean that backward compatiblity and bisect-ability will be broken by this
>> change.
>>
>> In other words, just adding a vendor prefix won't cause an issue if patches
>> are merged independently since if DTS patches are merged before, the driver
>> will still lookup using the I2C device ID table. And if the drivers patches
>> are picked before, the DTS will match using the OF device ID table.
>>
>> But changing to "nokia,retu" and "nokia,tahvo" means that you will need to
>> pick all patches and also that the DTS and drivers changes will have to be
>> done in the same patch. If you are OK with that, then I can change in the
>> next version.
> 
> tahvo is not documented nor used in any dts (in the kernel at least). 
> retu is used by 1 board and happened to work, but was never documented. 
> So I think it is okay to change unless the N800 folks object.
>

I'm fine with changing it (in fact I just want to fix the I2C of modalias
reporting). Does this mean that backward compatibility and bisect-ability
should be preserved? Or it's OK to split the changes in different patches?
 
> Rob
> 

Best regards,
--- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
