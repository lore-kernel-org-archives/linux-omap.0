From: Thomas Weber <weber@corscience.de>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Fri, 18 Feb 2011 13:57:25 +0100
Message-ID: <4D5E6CB5.8080500@corscience.de>
References: <1276613548.2824.46.camel@black>	<AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>	<1276636633.2824.88.camel@black>	<AANLkTikJE7fNYmRqFYL9WB7z_o3GcfaDsTJ4-yZUk4od@mail.gmail.com>	<1276726376.3211.36.camel@black> <AANLkTimiNPC-1PuI3D3sGs-c4FCq6UtJqZ_a6iVY_3Ci@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50143 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1BRM6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 07:58:43 -0500
In-Reply-To: <AANLkTimiNPC-1PuI3D3sGs-c4FCq6UtJqZ_a6iVY_3Ci@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Mathieu Poirier <mathieu.poirier@canonical.com>, s-ghorai@ti.com, linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

Hello Mathieu, hello Venkat,

I hope it is not too old and you remember this:

Am 17.06.2010 16:33, schrieb Venkatraman S:
>  Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
>> On Wed, 2010-06-16 at 14:13 +0530, Venkatraman S wrote:
>>> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
>>>> On Tue, 2010-06-15 at 20:58 +0530, Venkatraman S wrote:
>>>>> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
>>>>>> HW: Beagleboard rev. C2 and C4
>>>>>> Processor: OMAP3
>>>>>> Kernel: 2.6.35-rc2
>>>>>> Driver: mmci-omap-hs
>>>>>>
>>>>>> I am faced with an SDHC card problem on a beagleboard.  Some cards
>>>>>> cannot be initialized on startup while others work perfectly.  I tracked
>>>>>> the issue down to one single kernel config: PREEMPT_VOLUNTARY.
>>>>>>
>>>>>> When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem goes away.
>>>>>>
>>>>>> When booting, a failing card (PREEMPT_VOLUNTARY) will output the
>>>>>> following:
>>>>>> [ 2.283355] mmc0: error -110 whilst initialising SD card
>>>>>>
>>>>>> I have also seen transfer errors such as this one:
>>>>>> [ 105.343780] mmcblk0: error -110 transferring data, sector 798431, nr
>>>>>> 26, card status 0xc00
>>>>>>
>>>>>> When working properly (PREEMPT_NONE), you get:
>>>>>> [   27.026519] mmc0: new high speed SDHC card at address 0007
>>>>>> [   27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB
>>>>>>
>>>>>> We seem to have a little timing problem - has anyone seen the same
>>>>>> issue ?  Can driver "mmci-omap-hs" actually work under
>>>>>> PREEMPT_VOLUNTARY ?
>>>>>>
>>>>>> Thanks, Mathieu.
>>>>>>
>>>>>
>>>>> I will check this out - not tested with PREEMPT_VOLUNTARY so far.
>>>>> If it's not too much trouble, can you provide a log with CONFIG_MMC_DEBUG ?
>>>>> Also, some details about the failing card would be helpful.
>>>>>
>>>>> Thanks,
>>>>> Venkat.
>>>>
>>>> Venkat,
>>>>
>>>> Unfortunately enabling CONFIG_MMC_DEBUG doesn't yield more information -
>>>> the error message is the same and no additional output shows on the
>>>> console.
>>>>
>>>> As for the cards, had failures with 3 different manufacturer:
>>>> - Patriot Memory, MicroSD card, 8GB, class 4, SDHC.
>>>> - Kinston, 4GB, class 6, SDHC.
>>>> - Sandisk, 4GB, Class 2, SDHC.
>>>>
>>>> I am more than willing to test kernels for you if need be.
>>>>
>>>> Thanks, Mathieu.
>>>>
>>>
>>> For MMC/SD logs to be sent to the console, you need to
>>> a) "echo 8 > /proc/sys/kernel/printk" in the shell and
>>> b) insert the card
>>>
>>> If you are booting from the card itself, then this won't work and
>>> DEBUG_LL has to be enabled (in addition to CONFIG_MMC_DEBUG)
>>>
>>> Apologies - I should have explained this initially.
>>>
>>> Regards,
>>> Venkat.
>>
>> Venkat,
>>
>> I am indeed booting from the card itself, making things more difficult.
>> DEBUG_LL has been configured since the very beginning and still not much
>> to look at on the console.  To see something I had to pass loglevel=8 on
>> the kernel command line.  At that point there is tones of stuff coming
>> out and the card is initialized properly, which points to a timing
>> issue.
>>
>> Since I couldn't reproduce the failure when debug messages are enabled,
>> I turned them back off and started to instrument the code on the hunt
>> for the failure.
>>
>> I have cornered the source of the problem in
>> "drivers/mmc/core/sd_ops.c", function "mmc_sd_switch".  When the kernel
>> is configured with PREEMPT_NONE, the value of "data.error" is set to "0"
>> after "mmc_wait_for_req" returns.  When PREEMPT_VOLUNTARY is configured,
>> "data.error" gets set to "-110" upon "mmc_wait_for_req" returning, which
>> prevent the remaining of the configuration to take place.
>>
> 
> -110 = -ETIMEDOUT.
> The error is set from omap_hsmmc.c line 1029, when the controller
> returns a DATA_TIMEOUT error.
> This can happen for any mmc_wait_for_req() call, not just in mmc_sd_switch().
> 
> A simple workaround is to increase the timeout value, as below. Could
> you please try with this patch ?
> Yes, it's a debugging hack and not the right solution.
> [I have so far not reproduced the problem with my setup. Still trying..]
> 
> ----
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b032828..9ca399e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1413,7 +1413,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host
> *host, struct mmc_request *req)
> 
>         OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
>                                         | (req->data->blocks << 16));
> -       set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
> +       set_data_timeout(host, 100000000U, 0);
> 
>         if (host->use_dma) {
>                 ret = omap_hsmmc_start_dma_transfer(host, req);
> ----
> 
>   This provides a good 100ms window for delays due to scheduling variations.
> I have to still find out which section is sensitive to it.
> Regards,
> Venkat.
> --

We have a custom omap3 board and use kernel 2.6.37-rc8.  We have the
problem that we sometimes cannot mount our rootfs from sd-card. This
happens only when CONFIG_PREEMPT=y. When using CONFIG_PREEMPT_NONE or
enabling CONFIG_MMC_DEBUG everything works fine.

The "100 ms patch" doesn't work for us. Do you found other solution(s)?

Regards,
Thomas
