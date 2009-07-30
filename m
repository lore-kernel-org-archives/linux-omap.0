From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH V2 13/32] omap_hsmmc: context save/restore support
Date: Thu, 30 Jul 2009 22:33:25 +0300
Message-ID: <4A71F585.7090201@nokia.com>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop> <20090728104011.2371.89249.sendpatchset@ahunter-laptop> <00ad01ca10b9$82a5d260$544ff780@am.dhcp.ti.com> <4A714E59.7080902@nokia.com> <00c501ca1149$affb7ea0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62641 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZG3TdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 15:33:11 -0400
In-Reply-To: <00c501ca1149$affb7ea0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, 'linux-omap Mailing List' <linux-omap@vger.kernel.org>, 'Pierre Ossman' <pierre@ossman.eu>, "Karpov Denis.2 (EXT-Teleca/Helsinki)" <ext-denis.2.karpov@nokia.com>, 'Matt Fleming' <matt@console-pimps.org>, 'lkml' <linux-kernel@vger.kernel.org>

ext Madhusudhan wrote:
> 
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
>> Sent: Thursday, July 30, 2009 2:40 AM
>> To: Madhusudhan
>> Cc: 'Andrew Morton'; Lavinen Jarkko (Nokia-D/Helsinki); 'linux-omap
>> Mailing List'; 'Pierre Ossman'; Karpov Denis.2 (EXT-Teleca/Helsinki);
>> 'Matt Fleming'; 'lkml'
>> Subject: Re: [PATCH V2 13/32] omap_hsmmc: context save/restore support
>>
>> Madhusudhan wrote:
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>>>> Sent: Tuesday, July 28, 2009 5:40 AM
>>>> To: Andrew Morton
>>>> Cc: Jarkko Lavinen; Adrian Hunter; linux-omap Mailing List; Pierre
>> Ossman;
>>>> Denis Karpov; Matt Fleming; lkml
>>>> Subject: [PATCH V2 13/32] omap_hsmmc: context save/restore support
>>>>
>>>> From 43e9fa346d7e386328876a8535dc8619bd1f47ae Mon Sep 17 00:00:00 2001
>>>> From: Denis Karpov <ext-denis.2.karpov@nokia.com>
>>>> Date: Wed, 22 Apr 2009 16:04:25 +0200
>>>> Subject: [PATCH] omap_hsmmc: context save/restore support
>>>>
>>>> Keep the context over PM dynamic OFF states.
>>>>
>>>> Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>>>> ---
>>>>  drivers/mmc/host/omap_hsmmc.c |  194
>>>> ++++++++++++++++++++++++++++++++++++++--
>>>>  1 files changed, 184 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>> b/drivers/mmc/host/omap_hsmmc.c
>>>> index c28d055..ac1a3bf 100644
>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>> @@ -37,6 +37,7 @@
>>>>
>>>>  /* OMAP HSMMC Host Controller Registers */
>>>>  #define OMAP_HSMMC_SYSCONFIG	0x0010
>>>> +#define OMAP_HSMMC_SYSSTATUS	0x0014
>>>>  #define OMAP_HSMMC_CON		0x002C
>>>>  #define OMAP_HSMMC_BLK		0x0104
>>>>  #define OMAP_HSMMC_ARG		0x0108
>>>> @@ -94,6 +95,8 @@
>>>>  #define DUAL_VOLT_OCR_BIT	7
>>>>  #define SRC			(1 << 25)
>>>>  #define SRD			(1 << 26)
>>>> +#define SOFTRESET		(1 << 1)
>>>> +#define RESETDONE		(1 << 0)
>>>>
>>>>  /*
>>>>   * FIXME: Most likely all the data using these _DEVID defines should
>> come
>>>> @@ -152,6 +155,8 @@ struct mmc_omap_host {
>>>>  	int			slot_id;
>>>>  	int			dbclk_enabled;
>>>>  	int			response_busy;
>>>> +	int			context_loss;
>>>> +
>>>>  	struct	omap_mmc_platform_data	*pdata;
>>>>  };
>>>>
>>>> @@ -166,6 +171,166 @@ static void omap_mmc_stop_clock(struct
>> mmc_omap_host
>>>> *host)
>>>>  		dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped\n");
>>>>  }
>>>>
>>>> +#ifdef CONFIG_PM
>>>> +
>>>> +/*
>>>> + * Restore the MMC host context, if it was lost as result of a
>>>> + * power state change.
>>>> + */
>>>> +static int omap_mmc_restore_ctx(struct mmc_omap_host *host)
>>>> +{
>>>> +	struct mmc_ios *ios = &host->mmc->ios;
>>>> +	struct omap_mmc_platform_data *pdata = host->pdata;
>>>> +	int context_loss = 0;
>>>> +	u32 hctl, capa, con;
>>>> +	u16 dsor = 0;
>>>> +	unsigned long timeout;
>>>> +
>>>> +	if (pdata->get_context_loss_count) {
>>>> +		context_loss = pdata->get_context_loss_count(host->dev);
>>>> +		if (context_loss < 0)
>>>> +			return 1;
>>>> +	}
>>> This seems to restore the context always. The context should be restored
>>> only if the card was powered OFF, Right?
>> Not exactly. The "context" is just the host controller registers, which
>> get
>> lost if power management decides to power off the host controller, which
>> it
>> will if it decides it is not doing anything.  For us, switching off the
>> functional clock lets PM power off the host controller.  The card can be
>> in
>> any power state: on, off, card/regulator sleep.
>>
>> The context is restored only when it has been lost - see the following
>> lines.  But this is done from the "enable" method, so this is only called
>> if someone is trying to access the card.
>>
>> +	dev_dbg(mmc_dev(host->mmc), "context was %slost\n",
>> +		context_loss == host->context_loss ? "not " : "");
>> +	if (host->context_loss == context_loss)
>> +		return 1;
>>
>> And then further down, we skip some things if the card is off:
>>
>> +	/* Do not initialize card-specific things if the power is off */
>> +	if (host->power_mode == MMC_POWER_OFF)
>> +		goto out;
>>
>>
>>> The context could also be lost if the CORE transitions to OFF. I assume
>> that
>>> case gets handled here without anything extra required if "power_saving"
>> is
>>> set to true. Am I right?
>> Yes, "power_saving" is not related to "Power Management".  "power_saving"
>> is about controlling the power regulators, which the host controller does
>> itself without any support from PM.
>>
>> To put it another way, "power_saving" and CONFIG_PM can be set
>> independently
>> of one another.
> 
> But the "omap_hsmmc_context_save" and " omap_hsmmc_context_restore" are
> under CONFIG_PM. They are empty functions if CONFIG_PM is not set. Does this
> mean that if CONFIG_PM is not set the host regulators are not turned OFF
> even if there is no activity on MMC?

No.  Context save/restore *is* a part of Power Management.  It is needed
to support Dynamic Power Switching (DPS).

The voltage regulators are controlled via the enable/disable methods
even when CONFIG_PM is not defined.

Note that the voltage regulators to which I refer, power the cards not
the host controllers.

So the power to the host controller is under the control of Power Management
and is supported by context save/restore.

The power to the cards is controlled by the driver (omap_hsmmc) using the
enable/disable methods.


