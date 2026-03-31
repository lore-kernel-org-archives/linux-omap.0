Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32E376BE4
	for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981195; cv=none; b=LO7AFBMLp8GmiO25TkFT9wpIi8oAutZiiyftgwUwguk8HJo/IQQzKThhTldMF1sOXisRfJwAHipKxGSHLF4r70UQFXuLNzTVQ8gQSU7ZpyHosAjeI3/e3y1bTR1k9x6J+SHo50rGQ183vWty6hixs68UvI33X/LFy6pV3z3/xB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981195; c=relaxed/simple;
	bh=kPInaKIlGBsI+UM/YJPnUqU8aR/XGjrY3x0/PI30Q6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj+VMFJWJ8cLdKqKTCi8RlOYFr1baz/cWQR3mVTyJ99x6aYC9Hx+6sF8COCCM3xg9LOPEh9ef+7VxF5ZM11Y8HewdksWUZ9QS286WcZX85uA+rcseBYT2g1+gkd10NDDcLmpucjZtXrGUJDm0O0gE3kUdk+gVMBnqcpuCYDyQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OIFnzwVF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OIFnzwVF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 688AA1A30C6;
	Tue, 31 Mar 2026 18:19:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C2876029D;
	Tue, 31 Mar 2026 18:19:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 110D71045043E;
	Tue, 31 Mar 2026 20:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774981189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pYrn3dZCQv0C3hAZrNijv8f5Lcb5/fHiy1jRqfMgcB8=;
	b=OIFnzwVFtnFf2XakMJHYVzAqyUyblauLulrlqMYnv2+6tSbH2aFNbadLB99PE3dYCfQgfk
	RtI/2O2p/GisCmJneoq0N8WRhpAJnIILNkJn47ji2DImdL4Q82BfEMCJ5HVMjEPXLzXCCG
	7LNmAsNXQ588jFVw9P933i5Z15RpYav0DbZOR3FF7zVxpkkaQjcjbV+i4VAaMji5TY9UbP
	4WMH6WycNn4i12szOWF6zfCw3cFin5XctVjngyXEIIqymU3vOfksuYiD2YuRni+FlARjnw
	UyOFcS2MIufITzaaJ+cdmiEdc4KxsZ0hXbRuUXWcZOua+1f6fG9C0OS3Iby+ew==
Message-ID: <da551b0f-97de-46b7-9ea0-f9ad818eb15b@bootlin.com>
Date: Tue, 31 Mar 2026 20:19:43 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] mfd: omap-usb-host: Add pbias regulator support
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
 <20260323-omap4-fix-usb-support-v1-7-b668132124ac@bootlin.com>
 <20260331165537.GJ3795166@google.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260331165537.GJ3795166@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Lee,

On 3/31/26 6:55 PM, Lee Jones wrote:
> On Mon, 23 Mar 2026, Thomas Richard wrote:
> 
>> Add pbias regulator support to enable SIM_VDDS supply and unlock USB I/O
>> cell. Previously, this was handled by the bootloader, now the kernel can
>> take responsibility for managing the PBIAS regulator, ensuring correct
>> operation regardless of the bootloader.
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  drivers/mfd/omap-usb-host.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index ac974285be341fa579ef198d1893b77af428b5f8..9e254e00183e940b775d5bde6e891f0d26af27b0 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -15,6 +15,9 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/of.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/string_choices.h>
>> +
> 
> ?
> 
>>  
>>  #include "omap-usb.h"
>>  
>> @@ -95,6 +98,8 @@ struct usbhs_hcd_omap {
>>  	struct usbhs_omap_platform_data	*pdata;
>>  
>>  	u32				usbhs_rev;
>> +
>> +	struct regulator		*pbias;
>>  };
>>  /*-------------------------------------------------------------------------*/
>>  
>> @@ -270,6 +275,25 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
>>  	}
>>  }
>>  
>> +static int omap_usbhs_set_pbias(struct device *dev, bool power_on)
>> +{
>> +	struct usbhs_hcd_omap *omap = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	if (!omap->pbias)
>> +		return 0;
>> +
>> +	if (power_on)
>> +		ret = regulator_enable(omap->pbias);
>> +	else
>> +		ret = regulator_disable(omap->pbias);
>> +
>> +	if (ret)
>> +		dev_err(dev, "pbias reg %s failed\n", str_enable_disable(power_on));
>> +
>> +	return ret;
>> +}
>> +
>>  static int usbhs_runtime_resume(struct device *dev)
>>  {
>>  	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
>> @@ -278,6 +302,10 @@ static int usbhs_runtime_resume(struct device *dev)
>>  
>>  	dev_dbg(dev, "usbhs_runtime_resume\n");
>>  
>> +	r = omap_usbhs_set_pbias(dev, true);
>> +	if (r)
>> +		return r;
>> +
>>  	omap_tll_enable(pdata);
>>  
>>  	if (!IS_ERR(omap->ehci_logic_fck))
>> @@ -355,7 +383,7 @@ static int usbhs_runtime_suspend(struct device *dev)
>>  
>>  	omap_tll_disable(pdata);
>>  
>> -	return 0;
>> +	return omap_usbhs_set_pbias(dev, false);
>>  }
>>  
>>  static unsigned omap_usbhs_rev1_hostconfig(struct usbhs_hcd_omap *omap,
>> @@ -564,6 +592,11 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  
>>  	omap->pdata = pdata;
>>  
>> +	omap->pbias = devm_regulator_get_optional(dev, "pbias");
>> +	if (IS_ERR(omap->pbias))
>> +		return dev_err_probe(dev, PTR_ERR(omap->pbias),
>> +				     "unable to get pbias regulator\n");
> 
> You need to check for '-ENODEV' here or you are ignoring the optional part.
> 
>> +
>>  	/* Initialize the TLL subsystem */
>>  	omap_tll_init(pdata);
>>  
>> @@ -759,6 +792,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  	}
>>  
>>  initialize:
>> +	ret = omap_usbhs_set_pbias(dev, true);
>> +	if (ret)
>> +		goto err_mem;
> 
> Since this regulator is also managed by 'usbhs_runtime_resume' and
> 'usbhs_runtime_suspend', could manually enabling it here in probe and
> disabling it in remove interfere with the reference counting during runtime
> PM transitions? Should we consider relying entirely on runtime PM to manage
> its state?
> 

Thanks a lot for the review. I already sent a v2, do not spend your time
on this version. This comment is also valid for v2 (and the headers
one), but I fixed -ENODEV in v2.

Best Regards,
Thomas

