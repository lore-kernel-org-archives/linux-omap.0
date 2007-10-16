From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 04/14] MMC: OMAP: Power functions modified to
 MMC	multislot support
Date: Tue, 16 Oct 2007 12:13:28 -0400
Message-ID: <4714E328.8060204@indt.org.br>
References: <46F28BB7.7050203@indt.org.br> <20071009152914.GC7784@atomide.com>
	<470BBEC8.2010906@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <470BBEC8.2010906@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

ext Carlos Aguiar wrote:
> ext Tony Lindgren wrote:
>   
>> Hi,
>>
>> * Carlos Aguiar <carlos.aguiar@indt.org.br> [070920 08:05]:
>>   
>>     
>>> From: Juha Yrjola <juha.yrjola@solidboot.com>
>>>
>>> Modifications at power functions to MMC multislot support. This patch
>>> also move board-specific code out of MMC OMAP driver.
>>>
>>> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
>>> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>>> ---
>>>  drivers/mmc/host/omap.c |   88 ++++++++++++++++++-----------------------------
>>>  1 files changed, 34 insertions(+), 54 deletions(-)
>>>
>>> @@ -1090,23 +1063,29 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  	int i, dsor;
>>>  
>>>  	dsor = mmc_omap_calc_divisor(mmc, ios);
>>> -	host->bus_mode = ios->bus_mode;
>>> -	host->hw_bus_mode = host->bus_mode;
>>> +
>>> +	mmc_omap_select_slot(slot, 0);
>>> +
>>> +	if (ios->vdd != slot->vdd)
>>> +		slot->vdd = ios->vdd;
>>>  
>>>  	switch (ios->power_mode) {
>>>  	case MMC_POWER_OFF:
>>> -		mmc_omap_power(host, 0);
>>> +		mmc_omap_set_power(slot, 0, ios->vdd);
>>>  		break;
>>>  	case MMC_POWER_UP:
>>> -		/* Cannot touch dsor yet, just power up MMC */
>>> -		mmc_omap_power(host, 1);
>>> -		return;
>>>  	case MMC_POWER_ON:
>>> +		mmc_omap_set_power(slot, 1, ios->vdd);
>>>  		dsor |= 1 << 11;
>>>  		break;
>>>  	}
>>>  
>>>     
>>>       
>>   
>>     
> Hi Tony,
>
> First of all, thanks for the comment...
>   
>> This part breaks the MMC_POWER_UP vs MMC_POWER_ON again.
>>
>> This is third time I comment on the same issue I believe. Please
>> do not revert changes made in linux-omap with your patches.
>>   
>>     
> Well, I thought the solution proposed here was the best one. As I
> mentioned, it worked fine.
>   
>> You must power up MMC with MMC_POWER_UP, and then just set the
>> divisor in MMC_POWER_ON.
>>   
>>     
> Ok, anyway I will follow your comment. After test it, I will resend this
> patch.
>
> BR,
>
> Carlos.
>   
>> Regards,
>>
>> Tony
>>
>>
>>   
>>     
>
>
>   
Hi Tony,

I'm resendig the patch. As you said, I'd powered up MMC with MMC_POWER_UP and then set the
divisor in MMC_POWER_ON.

Tested with N800, H2 and H3 and works fine.

BR,

Carlos.

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
