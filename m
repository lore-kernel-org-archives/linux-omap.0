From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH 1/9] omap3isp: Add ISP main driver and register definitions
Date: Thu, 05 Mar 2009 13:34:59 +0200
Message-ID: <49AFB8E3.9070909@maxwell.research.nokia.com>
References: <49AD0128.5090503@maxwell.research.nokia.com>	 <1236074816-30018-1-git-send-email-sakari.ailus@maxwell.research.nokia.com> <1236081373.10927.15.camel@tux.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1236081373.10927.15.camel@tux.localhost>
Sender: linux-media-owner@vger.kernel.org
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, saaguirre@ti.com, tuukka.o.toivonen@nokia.com, dongsoo.kim@gmail.com
List-Id: linux-omap@vger.kernel.org

Thanks for the comments, Alexey!

Alexey Klimov wrote:
>> +static int isp_probe(struct platform_device *pdev)
>> +{
>> +	struct isp_device *isp;
>> +	int ret_err = 0;
>> +	int i;
>> +
>> +	isp = kzalloc(sizeof(*isp), GFP_KERNEL);
>> +	if (!isp) {
>> +		dev_err(&pdev->dev, "could not allocate memory\n");
>> +		return -ENODEV;
> 
> return -ENOMEM; ?

Done.

>> +	}
>> +
>> +	platform_set_drvdata(pdev, isp);
>> +
>> +	isp->dev = &pdev->dev;
>> +
>> +	for (i = 0; i <= OMAP3_ISP_IOMEM_CSI2PHY; i++) {
>> +		struct resource *mem;
>> +		/* request the mem region for the camera registers */
>> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, i);
>> +		if (!mem) {
>> +			dev_err(isp->dev, "no mem resource?\n");
>> +			return -ENODEV;
> 
> Maybe ENODEV is not apropriate here too..

What else it could be? ENOENT comes to mind but I'm not sure it's 
significantly better.

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
