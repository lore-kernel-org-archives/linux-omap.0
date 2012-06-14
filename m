From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 03/11] arm: omap: device: create a device for system
 control module
Date: Thu, 14 Jun 2012 17:50:19 +0400
Message-ID: <4FD9EC1B.6010506@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-4-git-send-email-eduardo.valentin@ti.com> <4FBF7B74.4020302@ti.com> <20120529094400.GA3505@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:38712 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755610Ab2FNNuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 09:50:22 -0400
In-Reply-To: <20120529094400.GA3505@besouro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: "Cousson, Benoit" <b-cousson@ti.com>, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

  Hi.

On 05/29/2012 01:44 PM, Eduardo Valentin wrote:
> On Fri, May 25, 2012 at 02:30:44PM +0200, Cousson Benoit wrote:
>> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
>>> From: Kishon Vijay Abraham I<kishon@ti.com>
>>>
>>> Extracts the device data from hwmod database and create a platform device
>>> using omap device build.
>>>
>>> The device build is done during postcore_initcall.
>> Do you still need that since you are supporting only DT?
>> The device will be built automatically in the DT case.
> In fact this is not needed for DT only probing. Dropping this one.
Yes, platform device(struct platform_device) will be built automatically, but omap device(struct omap_device) will not be built.
Also when omap device is allocated(omap_device_alloc) hwmod_clocks are registered, but in case of ctrl_module_core device - no new clock are registered.
So, is it fine to drop omap device and skip omap_device_build() call?

  BR,
    Konstantin Baydarov.

>
>> Regards,
>> Benoit
>>
>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/devices.c |   26 ++++++++++++++++++++++++++
>>>  1 files changed, 26 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>>> index 152c266..9332673 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -40,6 +40,32 @@
>>>  #define L3_MODULES_MAX_LEN 12
>>>  #define L3_MODULES 3
>>>
>>> +static int omap_init_control(void)
>>> +{
>>> +	struct omap_hwmod		*oh;
>>> +	struct platform_device		*pdev;
>>> +	const char			*oh_name, *name;
>>> +
>>> +	oh_name = "ctrl_module_core";
>>> +	name = "omap-control-core";
>>> +
>>> +	oh = omap_hwmod_lookup(oh_name);
>>> +	if (!oh) {
>>> +		pr_err("Could not lookup hwmod for %s\n", oh_name);
>>> +		return PTR_ERR(oh);
>>> +	}
>>> +
>>> +	pdev = omap_device_build(name, -1, oh, NULL, 0, NULL, 0, true);
>>> +	if (IS_ERR(pdev)) {
>>> +		pr_err("Could not build omap_device for %s %s\n",
>>> +		       name, oh_name);
>>> +		return PTR_ERR(pdev);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +postcore_initcall(omap_init_control);
>>> +
>>>  static int __init omap3_l3_init(void)
>>>  {
>>>  	struct omap_hwmod *oh;

