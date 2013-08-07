From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 7 Aug 2013 13:12:37 -0500
Message-ID: <52028E15.7080207@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-9-git-send-email-d-gerlach@ti.com> <52027439.7080206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38643 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651Ab3HGSNG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Aug 2013 14:13:06 -0400
In-Reply-To: <52027439.7080206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

Nishanth,
The issue here is that during a low-power transition the peripheral 
power domain loses context so the MSTANDBY config gets lost which is why 
the custom handling is needed on every cycle if there is no driver to 
handle it. I was unable to come up with a more generic way to handle 
this but I am certainly open for suggestions.

Regards,
Dave

On 08/07/2013 11:22 AM, Nishanth Menon wrote:
> On 08/06/2013 12:49 PM, Dave Gerlach wrote:
> [...]
>
>> +
>> +struct forced_standby_module am33xx_mod[] = {
>> +    {.oh_name = "usb_otg_hs"},
>> +    {.oh_name = "tptc0"},
>> +    {.oh_name = "tptc1"},
>> +    {.oh_name = "tptc2"},
>> +    {.oh_name = "cpgmac0"},
>> +};
>> +
> [...]
>> +
>> +static int am33xx_pm_suspend(void)
>> +{
>> +    int i, j, ret = 0;
>> +
>> +    int status = 0;
>> +    struct platform_device *pdev;
>> +    struct omap_device *od;
>> +
>> +    /*
>> +     * By default the following IPs do not have MSTANDBY asserted
>> +     * which is necessary for PER domain transition. If the drivers
>> +     * are not compiled into the kernel HWMOD code will not change the
>> +     * state of the IPs if the IP was not never enabled. To ensure
>> +     * that there no issues with or without the drivers being compiled
>> +     * in the kernel, we forcefully put these IPs to idle.
>> +     */
>> +    for (i = 0; i < ARRAY_SIZE(am33xx_mod); i++) {
>> +        pdev = to_platform_device(am33xx_mod[i].dev);
>> +        od = to_omap_device(pdev);
>> +        if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
>> +            omap_device_enable_hwmods(od);
>> +            omap_device_idle_hwmods(od);
>> +        }
>> +    }
>
> Sorry, I dont like this one bit. this is the job of the suspend / resume
> handler dealing with the specific device. I recollect having a similar
> issue on OMAP5 where without USB driver, USB wont idle, hence we cant
> suspend either. is the solution to do a custom handling for specific
> nodes as above? is it even necessary - considering that in multiple
> suspend-resume iterations, do we need to "enable and idle" multiple
> times? Cant we do it just in hwmod/omap_device level where unbound
> devices are disabled? Is there absolutely no possible way to do this in
> a generic manner?
>
