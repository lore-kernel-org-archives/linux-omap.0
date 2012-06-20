From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Wed, 20 Jun 2012 17:11:39 -0500
Message-ID: <4FE24A9B.6070203@ti.com>
References: <cover.1339828867.git.afzal@ti.com> <1414767dd444d4ab3998adf957e77ff4f3394f92.1339828867.git.afzal@ti.com> <4FDF50EA.4080506@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E99C502@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41900 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757667Ab2FTWLh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 18:11:37 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99C502@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/19/2012 12:57 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Mon, Jun 18, 2012 at 21:31:46, Hunter, Jon wrote:
> 
>>> @@ -95,10 +89,6 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
>>>  	if (err)
>>>  		return err;
>>>  
>>> -	/* Ensure sync read and sync write are disabled */
>>> -	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
>>> -	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
>>> -	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
>>
>> Sorry if I was not clear, but I was still thinking that we keep the
>> above instance of setting async mode.
> :
>>>  static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
>>>  {
>>>  	struct device *dev = &gpmc_onenand_device.dev;
>>> +	u32 reg;
>>> +
>>> +	/* Ensure sync read and sync write are disabled */
>>> +	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
>>> +	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
>>> +	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
>>
>> ... and here we should just call omap2_onenand_set_async_mode(), ...
> 
> If omap2_onenand_set_async_mode is called from gpmc_onenand_setup & removed
> from gpmc_onenand_init, when using new gpmc driver interface, i.e. using
> gpmc_onenand_update [1], we lost opportunity to provide gpmc driver with
> configuration details for async mode causing a big warning about each
> timings & configurations that was left by bootloader (which is meant only
> for cases where Kernel can't configure GPMC). Of course, we can put
> omap2_onenand_set_async_mode in gpmc_onenand_update too, but then
> unnecessarily, omap2_onenand_sey_async_mode would be called twice.
> 
> Please note that gpmc_onenand_setup is a callback by onenand driver.

Ok, I see your point. So today the _set_async_mode() is really doing two
things ...

1. It is calculating the timings
2. Programming the timings and setting async mode.

I think that it would be best if we were to make _set_async_mode() into
two functions, for example ...

1. omap2_onenand_get_async_timings()
2. omap2_onenand_set_async_timings()

Where the omap2_onenand_get_async_timings() calculates the timings and
can be used in both legacy mode and with the driver. Then
omap2_onenand_set_sync_timings() is just used in the legacy mode where
we don't have the driver to configure the chip-select.

Do you think that could work?

We could also do the same for omap2_onenand_set_sync_mode().

Cheers
Jon
