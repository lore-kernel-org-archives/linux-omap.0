From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH]: Fixing blksz_bits calling inside drivers/mmc/mmc.c and
 drivers/mmc/omap.c
Date: Fri, 27 Oct 2006 20:21:45 +0200
Message-ID: <45424E39.8000207@gmail.com>
References: <45422209.3090602@nokia.com> <45422DA7.4060900@gmail.com>
	<454231E4.3020007@nokia.com> <454237BE.900@gmail.com>
	<4542473A.4050709@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4542473A.4050709@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <ext-felipe.lima@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> ext Dirk Behme wrote:
>>>> Index: linux-osk/drivers/mmc/omap.c
>>>> ===================================================================
>>>> --- linux-osk.orig/drivers/mmc/omap.c
>>>> +++ linux-osk/drivers/mmc/omap.c
>>>> @@ -581,12 +581,6 @@ static void mmc_omap_switch_timer(unsign
>>>>      schedule_work(&host->switch_work);
>>>>  }
>>>>  
>>>> -/* FIXME: Handle card insertion and removal properly. Maybe use a mask
>>>> - * for MMC state? */
>>>> -static void mmc_omap_switch_callback(unsigned long data, u8 mmc_mask)
>>>> -{
>>>> -}
>>>> -
>>>>  static void mmc_omap_switch_handler(void *data)
>>>>  {
>>>>      struct mmc_omap_host *host = (struct mmc_omap_host *) data;
>>>> @@ -633,10 +627,10 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
>>>>      int sync_dev = 0;
>>>>  
>>>>      data_addr = host->phys_base + OMAP_MMC_REG_DATA;
>>>> -    frame = 1 << data->blksz_bits;
>>>> +    frame = data->blksz;
>>>>      count = sg_dma_len(sg);
>>>>  
>>>> -    if ((data->blocks == 1) && (count > (1 << data->blksz_bits)))
>>>> +    if ((data->blocks == 1) && (count > (data->blksz)))
>>>>          count = frame;
>>>>  
>>>>      host->dma_len = count;
>>>> @@ -825,7 +819,7 @@ mmc_omap_prepare_data(struct mmc_omap_ho
>>>>      }
>>>>  
>>>>  
>>>> -    block_size = 1 << data->blksz_bits;
>>>> +    block_size = data->blksz;
>>>>  
>>>>      OMAP_MMC_WRITE(host, NBLK, data->blocks - 1);
>>>>      OMAP_MMC_WRITE(host, BLEN, block_size - 1);
>>>>
...
> Yep, my git tree is the newest version...
...
> --- linux-omap/drivers/mmc/mmc.c    2006-10-26 06:42:31.000000000 -0400
> +++ linux-omap-dev/drivers/mmc/mmc.c    2006-10-26 09:53:24.000000000 -0400
> @@ -996,7 +996,7 @@
> 
>         mmc_set_data_timeout(&data, card, 0);
> 
> -        data.blksz_bits = 1 << 3;
> +        data.blksz = 1 << 3;
>         data.blocks = 1;
>         data.flags = MMC_DATA_READ;
>         data.sg = &sg;

Weird. My drivers/mmc/mmc.c looks

...
mmc_set_data_timeout(&data, card, 0);

data.blksz = 1 << 3;
data.blocks = 1;
data.flags = MMC_DATA_READ;
data.sg = &sg;
data.sg_len = 1;
...

without any patch. Looking at line ~999 of

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=ee8863c123e37881e0f35ee658a15fd5e925ad31;hb=591db7639fd7e2b2ae3f82851ee1d25beac714c4;f=drivers/mmc/mmc.c#999

it's the same. So I don't have to touch mmc.c for my patch 
above.

Best regards

Dirk
