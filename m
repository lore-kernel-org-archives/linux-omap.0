From: kishon <kishon@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Mon, 22 Oct 2012 14:55:38 +0530
Message-ID: <50851112.8020002@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com> <1350552010-28760-9-git-send-email-t-kristo@ti.com> <20121018103334.GA1449@arwen.pp.htv.fi> <1350562684.2143.52.camel@sokoban> <20121018135352.GC2739@arwen.pp.htv.fi> <1350571199.2143.53.camel@sokoban> <508509C6.10708@ti.com> <20121022090723.GE14033@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56184 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab2JVJZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 05:25:49 -0400
In-Reply-To: <20121022090723.GE14033@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi,

On Monday 22 October 2012 02:37 PM, Felipe Balbi wrote:
> On Mon, Oct 22, 2012 at 02:24:30PM +0530, kishon wrote:
>> Hi,
>>
>> On Thursday 18 October 2012 08:09 PM, Tero Kristo wrote:
>>> On Thu, 2012-10-18 at 16:53 +0300, Felipe Balbi wrote:
>>>> hi,
>>>>
>>>> On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
>>>>>>> +static int __init omap4430_phy_power_down(void)
>>>>>>> +{
>>>>>>> +	void __iomem *ctrl_base;
>>>>>>> +
>>>>>>> +	if (!cpu_is_omap44xx())
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>> +	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>>>>>>> +	if (!ctrl_base) {
>>>>>>> +		pr_err("control module ioremap failed\n");
>>>>>>> +		return -ENOMEM;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	/* Power down the phy */
>>>>>>> +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>>>>>>> +
>>>>>>> +	iounmap(ctrl_base);
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +early_initcall(omap4430_phy_power_down);
>>>>>>> +#endif
>>>>>>
>>>>>> I think you could do it even if the driver is enabled.
>>>>>
>>>>> Actually not at least now, it looks like the driver is not controlling
>>>>> this bit at all, so the driver would fail if we do this.
>>>>
>>>> then we can consider that a bug in the driver. Kishon, I thought you had
>>>> added SCM address space to PHY driver for this particular reason until
>>>> we get SCM driver, wasn't it ??
>>>
>>> Yes, I would say its a bug in the driver.
>>
>> No. It's done in the driver (omap_usb_phy_power() in
>> drivers/usb/phy/omap-usb2.c). We explicitly power off the phy during
>> probe in the driver.
>
> so you also handle enabling the IP later when you need ? That's great,
> it means we can do the above unconditionally, driver enabled or not.

yes.

Thanks
Kishon
