From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
Date: Tue, 11 Jun 2013 15:51:05 +0300
Message-ID: <51B71D39.6080202@ti.com>
References: <20130607203936.16513.57494.stgit@localhost> <20130607205044.16513.27675.stgit@localhost> <688FBEF7C8277944BE5AED9A41FB1EBC1AB12D0F@DNCE05.ent.ti.com> <20130610152109.GI8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50596 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab3FKMvg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 08:51:36 -0400
In-Reply-To: <20130610152109.GI8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/10/2013 06:21 PM, Tony Lindgren wrote:
> * Quadros, Roger <rogerq@ti.com> [130610 03:09]:
>> +
>> +static int __init pcs_omap_init(void)
>> +{
>> +       platform_driver_register(&pcs_omap_soc_driver);
>> +       platform_driver_register(&pcs_omap_driver);
>> +
>> +       return 0;
>> +}
>> +module_init(pcs_omap_init);
>>
>> It seems this has to be moved to an earlier place (e.g. subsys_initcall)
>> else the pinctrl core fails to find the pinctrl device at the device creation
>> time and bails out with -EPROBE_DEFER. Also, that device is never
>> created again, so -EPROBE_DEFER doesn't seem to work there.
> 
> Ah here, found your other comment :)
> 
> That's not needed, the real fix is to make twl-core.c and friends to
> be regular module_init. There are already patches queued for that.

OK. I was testing with USB host driver and it seems to be loaded as fs_initcall() which
is the root of the problem. I will fix up the usb host driver to be loaded as module_init()

cheers,
-roger
