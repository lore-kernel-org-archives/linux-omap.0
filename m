Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB63290C9
	for <linux-omap@vger.kernel.org>; Sun, 13 Sep 2026 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319221; cv=none; b=KbqNpH67qEBwS+Lp6IdXrD3dAwn3GnTeS4Vd1a+8PXqFsLRJ6eOh0HzOQ7gIwWYk5VT6y7cnQJy0uGVn9RtyqlR3L05sJ/gCUU9KEDRUVKwmgD8VUbR4hzfrVrXAKv99CNGZQlSSHozoCh1DE2qBmVsZLWl8RfbO+ZSN2qglsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319221; c=relaxed/simple;
	bh=55HOlgxv5Osy61VeA0QW3rB1klhKperyZUva8emw96E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inO5TyPsU4oEAFovUDfdkb7GOj15oen95jkqchG7P/qOUSRXcuO7mf/FUsdllXCfFLcokWZJbnyANgWx3ZjUo/4Ch620fuXtYnwX0WsdHv8+sjoWqtvV7IXuW54W/A22++2WvHaxk/3JM7Msmxyga4KCaecyKS+8S6nHbTI/NPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dekYmsWU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dekYmsWU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so7083245e9.1
        for <linux-omap@vger.kernel.org>; Sun, 13 Sep 2026 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789319217; x=1789924017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLfGELYFsfdMyOIjPBzlfKUMxy/FgAuN3WPbdQvjEjI=;
        b=dekYmsWUMA7orNWR6WnDt3hnCugYL9EL5TDQAiY5o7DHGi0kZ6P3aa+BKVulfH0MU2
         JR5PzjfyJALmC4niZdo2ziA6iK2Zhyyi7LUJj0RXuN54DkAcYuT7uEyaVGsGBiWabpQc
         v5LfckbHJotM4pgsQKpOWHeVVY04nArvmu3uI99e6aJ16K7bohTfkwRtCRpOpraIAGtT
         zQLvfTNhCKjdVy272vFGDiZPFm+DhLah/lQkiDtNp3VMiA15jWKAYqvGOqFcKcVpPyKZ
         D6FlgIU8PbWHBFOVrWc8ZuJf/udoIjz9PwxzwS5+TXfiWoq2bjSicAvqGmlQf9QpYKwi
         pBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789319217; x=1789924017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLfGELYFsfdMyOIjPBzlfKUMxy/FgAuN3WPbdQvjEjI=;
        b=K9+MuJcxNCL3Oeg8BKJBFssdrhakqM0qqtg87g6Odgm0Y6vhWazfBZYz/e9EKVNwvG
         KvUHvFCmbwduaNA9shDWWuvRuTJxIoNkLaAKPfkDA8rdOGfRHYN5PXkctu/cyRljikGY
         UIqwC9q//PbYhFHopleayJMLYs0ZTeCbfBLiC7N89c3GsSfF7+9HFiiLeWJbiOByCpjM
         4+ymbJMJ/VfxNYHQpmTwx3+xudwpErqjvi+tXDF4O9EF5LgDHPfrS5yGZbINVX/3N1o8
         P5Yo0pHZJSp6eQtBy7zVCtMYVEExxCHyfX3ozKReEckzg1f2rrIix7WrEV+VhF0QRdc8
         bPLg==
X-Forwarded-Encrypted: i=1; AKwUvBxKV1H+E/oWtRhOKoPfDPi+H3SZl4hcCMZRe7J9/8aySNF2cOQshT1ZuqXr/NIPHBqagDq4O6kEjGh8@vger.kernel.org
X-Gm-Message-State: AFuF++ljE2IoHHLyl314z/OSvmnHCqKKfcnNPxyNsR8gYP7eKeTJ4fvy
	IeOKHn92DBMUzmd5BT+SE9IFRt+UlTeustWg94Cz7j+dTP0fowHk7r0fqFEwAQ==
X-Gm-Gg: AYBFou1Y3vY8Nb1N6PfIwa/1Y0Ke6omP9gYejGlGUNQvIgG7L5Uh2S6xuMXqtD+yvM7
	YYOqn7Hv1P9GxycX3yVEBnvxl66Bsbej186syc4LlA2XUdW9M9Gwo9EH+70CTe2QScrefyFmHnh
	K1yXQujLEUzXmW+tV9C7uwxdASWzcfXj0UGB9dHLT9hvSqCATmGkPjnkSmaUwtbDYSg/wOa5jRj
	dyt1hlW1NQB/Tr0YXRhGFr0iAlE52jIwJkty+TpNMieJiNFn8DK7NtjoVo1RdDSxRHVZNVusrgK
	fLnkOADbZTKtHu/alPnLJVAzJ2vejkC4za07JRuEOLHZEo3ZUADzL3X8OT0WTr5rQbKRcdRxqGA
	cRUAaEwBkjT4mQXt7xQmw6hhSLO7+AP4jkA04o0pw/0hv6t2STQHNZWOMImwOkuh5UCL4D2MyTY
	g4kbZtRfjC9dB8McEshLRztwLUYqj//SpUNiOvybtELnyZAmNKh3LpXZ7FZFAgpYHQlf2nmdzqi
	ZSSRJYSAyRK3+eqT30Jvg==
X-Received: by 2002:a05:600d:4443:20b0:49d:257c:a735 with SMTP id 5b1f17b1804b1-49e76065da4mr22473745e9.11.1789319216429;
        Sun, 13 Sep 2026 10:06:56 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e6aac22bbsm116205845e9.0.2026.09.13.10.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 10:06:54 -0700 (PDT)
Message-ID: <7dfe251c-7c1f-46c9-a3e4-fb7388ddae49@gmail.com>
Date: Sun, 13 Sep 2026 20:06:52 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] phy: cpcap-usb: add DCP detection and make UART
 idle mode optional
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-5-ivo.g.dimitrov.75@gmail.com>
 <oheoylzdj3arrnfdm6747cuubllkdmg4gx7vm3zhs3owuooj4v@zdbytrztbdp4>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <oheoylzdj3arrnfdm6747cuubllkdmg4gx7vm3zhs3owuooj4v@zdbytrztbdp4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9.09.26 г. 19:07 ч., Manivannan Sadhasivam wrote:
> On Sat, Jul 11, 2026 at 11:42:07PM +0300, Ivaylo Dimitrov wrote:
>> Handle DCP separately from USB host connections using CPCAP charger
>> detection status.
>>
>> Make the existing idle UART mode optional via the "enable_uart" module
>> parameter. When disabled (default), the PHY remains in its USB/charger
>> detection configuration while idle.
>>
>> Also initialize the PHY into the baseline configuration required for
>> reliable charger detection during probe.
>>
>> Use the optional "safe" pinctrl state before switching between modes to
>> avoid glitches on USB or UART lines.
>>
> 
> Looks like this change is doing multiple things at once. Please split the
> changes logically to separate patches.
> 
will spliting in two:

patch1: enable_uart + safe pinctrl
patch2: DCP detection + init on probe

be ok or you want me to split even more? To me it makes sense as 
enable_uart will be few lines only if sent as a separate patch and I 
don't think splitting DCP detection + init on probe makes sense.

>> Note: Enabling UART idle mode increases idle power consumption (by 25mW
>> on droid4).
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>
>> # Conflicts:
>> #	drivers/phy/motorola/phy-cpcap-usb.c
> 
> What is this conflict?

an artefact from nth local rebase/merge before submission :) .

> 
>> ---
>>   drivers/phy/motorola/phy-cpcap-usb.c | 301 +++++++++++++++++++++------
>>   1 file changed, 238 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
>> index 741145c89e5b..2d770ff19e93 100644
>> --- a/drivers/phy/motorola/phy-cpcap-usb.c
>> +++ b/drivers/phy/motorola/phy-cpcap-usb.c
>> @@ -110,6 +110,15 @@ enum cpcap_gpio_mode {
>>   	CPCAP_OTG_DM_DP,
>>   };
>>   
>> +enum cpcap_mode {
>> +	CPCAP_UNKNOWN,
>> +	CPCAP_IDLE,
>> +	CPCAP_CHARGER,
>> +	CPCAP_USB,
>> +	CPCAP_USB_HOST,
>> +	CPCAP_DOCK,
>> +};
>> +
>>   struct cpcap_phy_ddata {
>>   	struct regmap *reg;
>>   	struct device *dev;
>> @@ -119,15 +128,19 @@ struct cpcap_phy_ddata {
>>   	struct pinctrl_state *pins_ulpi;
>>   	struct pinctrl_state *pins_utmi;
>>   	struct pinctrl_state *pins_uart;
>> +	struct pinctrl_state *pins_safe;
>>   	struct gpio_desc *gpio[2];
>>   	struct iio_channel *vbus;
>>   	struct iio_channel *id;
>>   	struct regulator *vusb;
>>   	atomic_t active;
>> -	unsigned int vbus_provider:1;
>> -	unsigned int docked:1;
>> +	enum cpcap_mode mode;
>>   };
>>   
>> +static bool cpcap_enable_uart;
>> +module_param_named(enable_uart, cpcap_enable_uart, bool, 0644);
>> +MODULE_PARM_DESC(enable_uart,
>> +		 "Enable UART on the USB connector while idle (increases power consumption)");
> 
> Use of module params is discouraged these days. Also, you are disabling it by
> default, which could cause surprises to users who have boards wired up for debug
> console. But considering that it consumes a lot of power, I think it is OK to
> disable it this way. I can't think of another way to add this knob.
> 

Me neither, that's why I came up with a module parameter. Yes, I 
understand disabling it by default may cause regression for some 
(presumably knowledgeable) users, however, I think stripping ~25% from 
idle power usage for the others worths it.

>>   static bool cpcap_usb_vbus_valid(struct cpcap_phy_ddata *ddata)
>>   {
>>   	int error, value = 0;
>> @@ -196,8 +209,9 @@ static int cpcap_phy_get_ints_state(struct cpcap_phy_ddata *ddata,
>>   	return 0;
>>   }
>>   
> 
> [...]
> 
>> @@ -473,21 +559,10 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
>>   {
>>   	int error;
>>   
>> -	/* Disable lines to prevent glitches from waking up mdm6600 */
>> -	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_UNKNOWN_DISABLED);
>> +	error = cpcap_usb_set_safe_mode(ddata);
>>   	if (error)
>>   		return error;
>>   
>> -	if (ddata->pins_utmi) {
>> -		error = pinctrl_select_state(ddata->pins, ddata->pins_utmi);
>> -		if (error) {
>> -			dev_err(ddata->dev, "could not set usb mode: %i\n",
>> -				error);
>> -
>> -			return error;
>> -		}
>> -	}
>> -
>>   	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC1,
>>   				   CPCAP_BIT_VBUSPD, 0);
>>   	if (error)
>> @@ -503,11 +578,23 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
>>   		goto out_err;
>>   
>>   	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
>> -				   CPCAP_BIT_USBXCVREN,
>> +				   CPCAP_BIT_USBXCVREN |
>> +				   CPCAP_BIT_UARTMUX0 |
>> +				   CPCAP_BIT_EMUMODE0,
> 
> As Sashiko noted, you are not clearing CPCAP_BIT_USBSUSPEND bit set in
> cpcap_usb_set_idle_mode().
> 

Vendor kernel does not do it and we are using the patch with 
CPCAP_BIT_USBSUSPEND not cleared for few months with no issues 
whatsoever, so I am not convinced this is needed. However, tests on the 
device didn't show any difference if I clear the bit so OK, will do.

>>   				   CPCAP_BIT_USBXCVREN);
>>   	if (error)
>>   		goto out_err;
>>   
>> +	if (ddata->pins_utmi) {
>> +		error = pinctrl_select_state(ddata->pins, ddata->pins_utmi);
>> +		if (error) {
>> +			dev_err(ddata->dev, "could not set usb mode: %i\n",
>> +				error);
>> +
>> +			return error;
>> +		}
>> +	}
>> +
>>   	/* Enable USB mode */
>>   	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_OTG_DM_DP);
>>   	if (error)
>> @@ -521,6 +608,38 @@ static int cpcap_usb_set_usb_mode(struct cpcap_phy_ddata *ddata)
>>   	return error;
>>   }
>>   
>> +static int cpcap_usb_set_dcp_mode(struct cpcap_phy_ddata *ddata)
>> +{
>> +	int error;
>> +
>> +	error = cpcap_usb_set_safe_mode(ddata);
>> +	if (error)
>> +		return error;
>> +
>> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC2,
>> +				   CPCAP_BIT_USBXCVREN |
>> +				   CPCAP_BIT_UARTMUX0 |
>> +				   CPCAP_BIT_EMUMODE0, 0);
>> +	if (error)
>> +		goto out_err;
>> +
>> +	error = regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
>> +				   CPCAP_BIT_SUSPEND_SPI, 0);
>> +	if (error)
>> +		goto out_err;
>> +
>> +	error = cpcap_usb_gpio_set_mode(ddata, CPCAP_DM_DP);
>> +	if (error)
>> +		goto out_err;
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
> 
> Don't print function names in the error log.
> 

Ok.

Will send new series, just LMK if you want the patch split in 2 or more 
patches.

Thanks,
Ivo
