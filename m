From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Wed, 4 Nov 2015 10:18:24 +0530
Message-ID: <56398E18.4010100@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-2-git-send-email-vigneshr@ti.com>
 <CAOMqctQ7uPXo5GzVK918DfvuaAPBvbooxW00jFP4ryyfcdLURA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMqctQ7uPXo5GzVK918DfvuaAPBvbooxW00jFP4ryyfcdLURA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11/03/2015 04:49 PM, Michal Suchanek wrote:
> On 3 November 2015 at 11:06, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>> In addition to providing direct access to SPI bus, some spi controller
>> hardwares (like ti-qspi) provide special memory mapped port
>> to accesses SPI flash devices in order to increase read performance.
>> This means the controller can automatically send the SPI signals
>> required to read data from the SPI flash device.
>> For this, spi controller needs to know flash specific information like
>> read command to use, dummy bytes and address width. Once these settings
>> are populated in hardware registers, any read accesses to flash's memory
>> map region(SoC specific) through memcpy (or mem-to mem DMA copy) will be
>> handled by controller hardware. The hardware will automatically generate
>> SPI signals required to read data from flash and present it to CPU/DMA.
>>
>> Introduce spi_mtd_mmap_read() interface to support memory mapped read
>> over SPI flash devices. SPI master drivers can implement this callback to
>> support memory mapped read interfaces. m25p80 flash driver and other
>> flash drivers can call this to request memory mapped read. The interface
>> should only be used MTD flashes and cannot be used with other SPI devices.
>>
>> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/spi/spi.c       | 35 +++++++++++++++++++++++++++++++++++
>>  include/linux/spi/spi.h | 23 +++++++++++++++++++++++
>>  2 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index a5f53de813d3..5a5c7a7d47f2 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -1059,6 +1059,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
>>                 }
>>         }
>>
>> +       mutex_lock(&master->mmap_lock_mutex);
>>         trace_spi_message_start(master->cur_msg);
>>
>>         if (master->prepare_message) {
>> @@ -1068,6 +1069,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
>>                                 "failed to prepare message: %d\n", ret);
>>                         master->cur_msg->status = ret;
>>                         spi_finalize_current_message(master);
>> +                       mutex_unlock(&master->mmap_lock_mutex);
>>                         return;
>>                 }
>>                 master->cur_msg_prepared = true;
>> @@ -1077,6 +1079,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
>>         if (ret) {
>>                 master->cur_msg->status = ret;
>>                 spi_finalize_current_message(master);
>> +               mutex_unlock(&master->mmap_lock_mutex);
>>                 return;
>>         }
>>
>> @@ -1084,8 +1087,10 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
>>         if (ret) {
>>                 dev_err(&master->dev,
>>                         "failed to transfer one message from queue\n");
>> +               mutex_unlock(&master->mmap_lock_mutex);
>>                 return;
>>         }
>> +       mutex_unlock(&master->mmap_lock_mutex);
>>  }
>>
>>  /**
>> @@ -1732,6 +1737,7 @@ int spi_register_master(struct spi_master *master)
>>         spin_lock_init(&master->queue_lock);
>>         spin_lock_init(&master->bus_lock_spinlock);
>>         mutex_init(&master->bus_lock_mutex);
>> +       mutex_init(&master->mmap_lock_mutex);
>>         master->bus_lock_flag = 0;
>>         init_completion(&master->xfer_completion);
>>         if (!master->max_dma_len)
>> @@ -2237,6 +2243,35 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
>>  EXPORT_SYMBOL_GPL(spi_async_locked);
>>
>>
>> +int spi_mtd_mmap_read(struct spi_device *spi, loff_t from, size_t len,
>> +                     size_t *retlen, u_char *buf, u8 read_opcode,
>> +                     u8 addr_width, u8 dummy_bytes)
>> +
>> +{
>> +       struct spi_master *master = spi->master;
>> +       int ret;
>> +
>> +       if (master->auto_runtime_pm) {
>> +               ret = pm_runtime_get_sync(master->dev.parent);
>> +               if (ret < 0) {
>> +                       dev_err(&master->dev, "Failed to power device: %d\n",
>> +                               ret);
>> +                       goto err;
>> +               }
>> +       }
>> +       mutex_lock(&master->mmap_lock_mutex);
>> +       ret = master->spi_mtd_mmap_read(spi, from, len, retlen, buf,
>> +                                       read_opcode, addr_width,
>> +                                       dummy_bytes);
>> +       mutex_unlock(&master->mmap_lock_mutex);
>> +       if (master->auto_runtime_pm)
>> +               pm_runtime_put(master->dev.parent);
>> +
>> +err:
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mtd_mmap_read);
>> +
>>  /*-------------------------------------------------------------------------*/
>>
>>  /* Utility methods for SPI master protocol drivers, layered on
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 6b00f18f5e6b..0a6d8ad57357 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -297,6 +297,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
>>   * @flags: other constraints relevant to this driver
>>   * @bus_lock_spinlock: spinlock for SPI bus locking
>>   * @bus_lock_mutex: mutex for SPI bus locking
>> + * @mmap_lock_mutex: mutex for locking SPI bus when mmap transfer is on.
> 
> Any reason to not use the bus_lock_mutex here? The bus is busy as much
> during mmap transfer as it is during any other transfer.

If bus_lock_mutex is used, it will unnecessarily block queueing of new
messages when __spi_pump_messages() is calling transfer_one_message()
even in the case where there is no mmap mode. Hence, I chose to add new
mutex. But looks like it doesn't matter much as __spi_sync() anyways
blocks till message is transferred. I will drop the new mutex and use
bus_lock_mutex in v3. Thanks!

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
