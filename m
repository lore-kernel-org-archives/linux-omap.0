From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Re: [PATCH]: Fixing blksz_bits calling inside drivers/mmc/mmc.c and
 drivers/mmc/omap.c
Date: Fri, 27 Oct 2006 12:20:52 -0400
Message-ID: <454231E4.3020007@nokia.com>
References: <45422209.3090602@nokia.com> <45422DA7.4060900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45422DA7.4060900@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>, Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

ext Dirk Behme wrote:
> Felipe Balbi wrote:
>> This small patch solves the problem ;-)
>>
>> Here's the error dump:
>> drivers/mmc/omap.c: In function 'mmc_omap_prepare_dma':
>> drivers/mmc/omap.c:636: error: 'struct mmc_data' has no member named 
>> 'blksz_bits'
>> drivers/mmc/omap.c:639: error: 'struct mmc_data' has no member named 
>> 'blksz_bits'
>> drivers/mmc/omap.c: In function 'mmc_omap_prepare_data':
>> drivers/mmc/omap.c:828: error: 'struct mmc_data' has no member named 
>> 'blksz_bits'
>>
>> Obs: The same occurs for drivers/mmc/mmc.c file
>>
>>
>> ------------------------------------------------------------------------
>>
>> Index: linux-omap/drivers/mmc/omap.c
>> ===================================================================
>> --- linux-omap.orig/drivers/mmc/omap.c    2006-10-27 
>> 09:18:34.000000000 -0400
>> +++ linux-omap/drivers/mmc/omap.c    2006-10-27 11:03:14.000000000 -0400
>> @@ -633,10 +633,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
>>      int sync_dev = 0;
>>  
>>      data_addr = host->phys_base + OMAP_MMC_REG_DATA;
>> -    frame = 1 << data->blksz_bits;
>> +    frame = 1 << data->blksz;
>>      count = sg_dma_len(sg);
>>  
>> -    if ((data->blocks == 1) && (count > (1 << data->blksz_bits)))
>> +    if ((data->blocks == 1) && (count > (1 << data->blksz)))
>>          count = frame;
>>  
>>      host->dma_len = count;
>> @@ -825,7 +825,7 @@ mmc_omap_prepare_data(struct mmc_omap_ho
>>      }
>>  
>>  
>> -    block_size = 1 << data->blksz_bits;
>> +    block_size = 1 << data->blksz;
>>  
>>      OMAP_MMC_WRITE(host, NBLK, data->blocks - 1);
>>      OMAP_MMC_WRITE(host, BLEN, block_size - 1);
>>
>> --- linux-omap/drivers/mmc/mmc.c    2006-10-26 06:42:31.000000000 -0400
>> +++ linux-omap-dev/drivers/mmc/mmc.c    2006-10-26 09:53:24.000000000 
>> -0400
>> @@ -996,7 +996,7 @@
>>  
>>          mmc_set_data_timeout(&data, card, 0);
>>  
>> -        data.blksz = 1 << 3;
>> +        data.blksz_bits = 1 << 3;
>>          data.blocks = 1;
>>          data.flags = MMC_DATA_READ;
>>          data.sg = &sg;
>
> This doesn't look correct to me (and compilation still
> fails). Why do you add data.blksz_bits in mmc.c again? It
> was removed by RMK at
>
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blobdiff;h=5b9caa7978d34311839840243e38921255f6da4b;hp=74eaaee66de0e59532ba5655fddac5aaeea5ba08;hb=132919ba80ad207755fe271277bfefff865a54fe;f=drivers/mmc/mmc.c 
>
>
> Whats about the attachment instead? It additionally
> removes warning
>
> drivers/mmc/omap.c:587: warning: 'mmc_omap_switch_callback'
> defined but not used
>
> too.
>
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> ------------------------------------------------------------------------
>
> Index: linux-osk/drivers/mmc/omap.c
> ===================================================================
> --- linux-osk.orig/drivers/mmc/omap.c
> +++ linux-osk/drivers/mmc/omap.c
> @@ -581,12 +581,6 @@ static void mmc_omap_switch_timer(unsign
>  	schedule_work(&host->switch_work);
>  }
>  
> -/* FIXME: Handle card insertion and removal properly. Maybe use a mask
> - * for MMC state? */
> -static void mmc_omap_switch_callback(unsigned long data, u8 mmc_mask)
> -{
> -}
> -
>  static void mmc_omap_switch_handler(void *data)
>  {
>  	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
> @@ -633,10 +627,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
>  	int sync_dev = 0;
>  
>  	data_addr = host->phys_base + OMAP_MMC_REG_DATA;
> -	frame = 1 << data->blksz_bits;
> +	frame = data->blksz;
>  	count = sg_dma_len(sg);
>  
> -	if ((data->blocks == 1) && (count > (1 << data->blksz_bits)))
> +	if ((data->blocks == 1) && (count > (data->blksz)))
>  		count = frame;
>  
>  	host->dma_len = count;
> @@ -825,7 +819,7 @@ mmc_omap_prepare_data(struct mmc_omap_ho
>  	}
>  
>  
> -	block_size = 1 << data->blksz_bits;
> +	block_size = data->blksz;
>  
>  	OMAP_MMC_WRITE(host, NBLK, data->blocks - 1);
>  	OMAP_MMC_WRITE(host, BLEN, block_size - 1);
>
>
>   
But then you will need to modify the struct mmc_data... and that didn't 
seem correct for me 'cause every module using this structure (and 
probable future modules) would need to modify the same way you did...

-- 
Regards,

Felipe Balbi
ext-felipe.lima@nokia.com
OSMRC
