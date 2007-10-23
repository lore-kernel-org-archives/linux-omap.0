From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 04/14] MMC: OMAP: Power functions modified to
 MMC	multislot support
Date: Tue, 23 Oct 2007 11:24:09 -0400
Message-ID: <471E1219.2060007@indt.org.br>
References: <46F28BB7.7050203@indt.org.br> <20071009152914.GC7784@atomide.com>
	<470BBEC8.2010906@indt.org.br> <4714E35F.3090106@indt.org.br>
	<20071021234917.GB6984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071021234917.GB6984@atomide.com>
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

ext Tony Lindgren wrote:
> Hi,
>
> * Carlos Aguiar <carlos.aguiar@indt.org.br> [071016 09:17]:
>   
>> From: Juha Yrjola <juha.yrjola@solidboot.com>
>>
>> Modifications at power functions to MMC multislot support. This patch
>> also move board-specific code out of MMC OMAP driver.
>>     
>
> <snip>
>
>   
>> @@ -1090,23 +1063,30 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	int i, dsor;
>>  
>>  	dsor = mmc_omap_calc_divisor(mmc, ios);
>> -	host->bus_mode = ios->bus_mode;
>> -	host->hw_bus_mode = host->bus_mode;
>> +
>> +	mmc_omap_select_slot(slot, 0);
>> +
>> +	if (ios->vdd != slot->vdd)
>> +		slot->vdd = ios->vdd;
>>  
>>  	switch (ios->power_mode) {
>>  	case MMC_POWER_OFF:
>> -		mmc_omap_power(host, 0);
>> +		mmc_omap_set_power(slot, 0, ios->vdd);
>>  		break;
>>  	case MMC_POWER_UP:
>>  		/* Cannot touch dsor yet, just power up MMC */
>> -		mmc_omap_power(host, 1);
>> -		return;
>> +		mmc_omap_set_power(slot, 1, ios->vdd);
>>  	case MMC_POWER_ON:
>>  		dsor |= 1 << 11;
>>  		break;
>>  	}
>>  
>> -	clk_enable(host->fclk);
>> +	if (slot->bus_mode != ios->bus_mode) {
>> +		if (slot->pdata->set_bus_mode != NULL)
>> +			slot->pdata->set_bus_mode(mmc_dev(mmc), slot->id,
>> +						  ios->bus_mode);
>> +		slot->bus_mode = ios->bus_mode;
>> +	}
>>  
>>  	/* On insanely high arm_per frequencies something sometimes
>>  	 * goes somehow out of sync, and the POW bit is not being set,
>>     
>
>   
Hi Tony,

Sorry for my late response. In fact, I'm in sick leave.


> The above still changes behaviour, you've left out return after
> MMC_POWER_UP. That is not supposed to do anything except power
> up the slot and return as mentioned in the comment.
>   
Well, the first option I tried was of course return after MMC_POWER_UP. But, unexpectedly, such return is broken on N800. 

I'm working and investigating this today.

BR,

Carlos.

> Tony
>
>   


-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
