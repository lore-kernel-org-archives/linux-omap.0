From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 1/8] usb: phy: omap-control: Get rid of platform data
Date: Wed, 21 Aug 2013 09:46:29 +0300
Message-ID: <52146245.6020904@ti.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com> <1377010577-19355-2-git-send-email-rogerq@ti.com> <593AEF6C47F46446852B067021A273D6D982D30B@MUCSE039.lantiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57190 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab3HUGrH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Aug 2013 02:47:07 -0400
In-Reply-To: <593AEF6C47F46446852B067021A273D6D982D30B@MUCSE039.lantiq.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: thomas.langer@lantiq.com
Cc: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, george.cherian@ti.com, kishon@ti.com, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Thomas,

On 08/20/2013 06:04 PM, thomas.langer@lantiq.com wrote:
> Hello Roger,
> 
> this will not work!
> 
> Roger Quadros wrote on 2013-08-20:
> 
>> -	struct omap_control_usb_platform_data *pdata =
>> -			dev_get_platdata(&pdev->dev);
>> +
>> +	if (np) {
>> +		of_property_read_u32(np, "ti,type", &control_usb->type);
> 
> here you are dereferencing control_usb
> 
>> +	} else {
>> +		/* We only support DT boot */
>> +		return -EINVAL;
>> +	}
>>
>>  	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
>>  		GFP_KERNEL);
> 
> and here it is allocated!

Good catch :).
The problem is eliminated by other patches in this series, so tests ran fine.
But I'll fix this one.

cheers,
-roger
