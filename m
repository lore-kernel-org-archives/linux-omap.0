From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 6/7] dmaengine: cppi41: init_sched(): Get number of
 channels from DT
Date: Tue, 17 Jan 2017 18:30:16 +0100
Message-ID: <4d68d966-b3d5-b7f6-becb-400f1b434a0f@baylibre.com>
References: <20170117134540.9988-1-abailon@baylibre.com>
 <20170117134540.9988-7-abailon@baylibre.com>
 <36cd39fc-c14b-f117-e25e-f0489d465cc5@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <36cd39fc-c14b-f117-e25e-f0489d465cc5-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/17/2017 06:09 PM, Sergei Shtylyov wrote:
> On 01/17/2017 04:45 PM, Alexandre Bailon wrote:
> 
>> Despite the driver is already using DT to get the number of channels,
>> init_sched() is using an hardcoded value to get it.
>> Use DT to get the number of channels.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/dma/cppi41.c | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>> index 3b2f57f..303ccee 100644
>> --- a/drivers/dma/cppi41.c
>> +++ b/drivers/dma/cppi41.c
> [...]
>> @@ -832,7 +829,7 @@ static int init_descs(struct device *dev, struct
>> cppi41_dd *cdd)
>>      return 0;
>>  }
>>
>> -static void init_sched(struct cppi41_dd *cdd)
>> +static int init_sched(struct device *dev, struct cppi41_dd *cdd)
>>  {
>>      unsigned ch;
>>      unsigned word;
> [...]
>> @@ -850,9 +847,11 @@ static void init_sched(struct cppi41_dd *cdd)
>>          cppi_writel(reg, cdd->sched_mem + DMA_SCHED_WORD(word));
>>          word++;
>>      }
>> -    reg = 15 * 2 * 2 - 1;
>> +    reg = cdd->n_chans * 2 - 1;
>>      reg |= DMA_SCHED_CTRL_EN;
>>      cppi_writel(reg, cdd->sched_mem + DMA_SCHED_CTRL);
>> +
>> +    return 0;
>>  }
>>
>>  static int init_cppi41(struct device *dev, struct cppi41_dd *cdd)
>> @@ -871,12 +870,14 @@ static int init_cppi41(struct device *dev,
>> struct cppi41_dd *cdd)
>>
>>      ret = init_descs(dev, cdd);
>>      if (ret)
>> -        goto err_td;
>> +        goto deinit;
>>
>>      cppi_writel(cdd->td_queue.submit, cdd->ctrl_mem + DMA_TDFDQ);
>> -    init_sched(cdd);
>> +    ret = init_sched(dev, cdd);
>> +    if (ret)
> 
>   What's the point if init_sched() always returns 0?
In older version of this patch, I was able to return non zero
in case of error.
I will fix it.

Best Regards,
Alexandre
> 
> [...]
> 
> MBR, Sergei
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
