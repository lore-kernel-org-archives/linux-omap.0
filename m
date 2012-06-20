From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH v2 03/11] mfd: omap: control: core system control
 driver
Date: Wed, 20 Jun 2012 18:13:54 +0400
Message-ID: <4FE1DAA2.1000502@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <4FDF11C3.4010701@dev.rtsoft.ru> <20120620102224.GZ12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:54735 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756399Ab2FTON4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 10:13:56 -0400
In-Reply-To: <20120620102224.GZ12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>, J Keerthy <j-keerthy@ti.com>

  Hi, Tony.

On 06/20/2012 02:22 PM, Tony Lindgren wrote:
> * Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
>> This patch introduces a MFD core device driver for
>> OMAP system control module.
>>
>> The control module allows software control of
>> various static modes supported by the device. It is
>> composed of two control submodules: general control
>> module and device (padconfiguration) control
>> module.
>> +++ linux-2.6/drivers/mfd/omap-control-core.c
> ...
>
>
>> +u32 omap_control_readl(u16 offset)
>> +{
>> +	return __raw_readl(omap_control_base + (offset));
>> +}
>> +
>> +void omap_control_writel(u32 val, u16 offset)
>> +{
>> +	__raw_writel(val, omap_control_base + (offset));
>> +}
> There should not be any need to have the individual drivers use
> these. Please instead just set up something where individual drivers
> register with the control module core, and get their own iobase
> returned so they can use readl/writel and behave like normal device
> drivers.
IIUC one of the reasons drivers/mfd/omap-control-core.c introduction is replacement of arch/arm/mach-omap2/control.c. control.c provides omap_ctrl_readl/omap_ctrl_writel API which are heavily used in arch/arm/mach-omap2/:
arch/arm/mach-omap2/hsmmc.c
arch/arm/mach-omap2/usb-fs.c
arch/arm/mach-omap2/sr_device.c
arch/arm/mach-omap2/id.c
...

So,the same API set (omap_control_readl/omap_control_writel) was added to omap-control-core.c.

If omap-control-core.c should only service users from driver/ directory, than I agree - we can remove
omap_control_readl/omap_control_writel from omap-control-core.c.
  But IIUC you are agree to "switch" arch/arm/mach-omap2/id.c from control.c to omap-control-core.c. If arch/arm/mach-omap2/id.c is switched to control.c, then I guess all arch/arm/mach-omap2/*.c should be "switched" to omap-control-core.c as well. But this means that omap-control-core.c should provide omap_control_readl/omap_control_writel API.

  BR,
    Konstantin Baydarov.

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

