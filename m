From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 5/5] [RFC] Add MMC Password Protection (lock/unlock)
 support V7: mmc_omap_dma.diff
Date: Mon, 27 Nov 2006 09:43:12 -0400
Message-ID: <456AEB70.2000100@indt.org.br>
References: <4564648B.2020005@indt.org.br> <456805F3.1020407@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <456805F3.1020407@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> OMAP platform specific patch.
>> - Adjust the frame size for DMA transfers.
>>
>> Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
>> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
>>
> 
> This looks like a generic patch for OMAP and shouldn't be in this set.

This patch is needed only for lock/unlock commands. So, it's necessary to
make MMC omap works when using that feature. It's not a generic patch.
But I can take off this one from the series and send after (if) the series
is integrated.

> 
>> Index: linux-omap-2.6.git/drivers/mmc/omap.c
>> ===================================================================
>> --- linux-omap-2.6.git.orig/drivers/mmc/omap.c    2006-11-22
>> 09:07:25.000000000 -0400
>> +++ linux-omap-2.6.git/drivers/mmc/omap.c    2006-11-22
>> 09:19:03.000000000 -0400
>> @@ -629,6 +629,14 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
>>
>>      data_addr = host->phys_base + OMAP_MMC_REG_DATA;
>>      frame = data->blksz;
>> +
>> +#ifdef CONFIG_MMC_PASSWORDS
>> +    /* MMC LOCK/UNLOCK: Do frame size multiple of two. This is
>> +     * needed for DMA transfers to work properly, once
>> +     * the block size depends on MMC password length.
>> +     */
>> +    frame += frame&0x1;
>> +#endif
>>      count = sg_dma_len(sg);
>>
>>      if ((data->blocks == 1) && (count > (data->blksz)))
>>
> 
> Now this you're going to have to explain to me. Especially the part
> where why this is specific to the lock commands.

frame depends on data->blksz. When we were using data->blksz_bits everything was
ok because we always had a multiple of 16 bits (2 bytes). Once a pwd can has a size
not multiple of 2, the value must be rounded.
According to MMC OMAP Technical Reference Manual, because of each DMA transfer is of
equal size, it is necessary to have the block size of the transfer be a multiple of
the DMA write access size (which is 2 bytes).

I'm not a DMA expert, If I misunderstand something, please, correct me.

Best Regards,

Anderson Briglia
