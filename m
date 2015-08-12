From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Wed, 12 Aug 2015 14:57:03 +0530
Message-ID: <55CB1167.7010804@ti.com>
References: <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com> <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com> <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com> <20150806102225.GI7576@n2100.arm.linux.org.uk> <55C35233.2000105@ti.com> <20150806135129.GJ7576@n2100.arm.linux.org.uk> <CAMuHMdWWDwZ=ziGQXFCnOX8pErXpsEi533J73_Hh=sEqq4hR6Q@mail.gmail.com> <20150806213340.GK7576@n2100.arm.linux.org.uk> <55C46B84.3010304@sperl.org> <CAOMqctScUybdoZPgqH185qzDxB=TyutDMARextHx0XwC7L3Xmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMqctScUybdoZPgqH185qzDxB=TyutDMARextHx0XwC7L3Xmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 08/07/2015 03:46 PM, Michal Suchanek wrote:
[snip]
> On 7 August 2015 at 10:35, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>>
>>
>> On 08/07/2015 01:08 PM, Michal Suchanek wrote:
>>
>>> Now since the description is clearer it's obvious that ti-qspi cannot
>>> work fully mmapped as fsl-qspi does because the setup has to be done
>>> over normal spi access and using non-m25p80 devices on the same bus is
>>> a requirement.
>>>
>>> The place where it is known if a transfer can use the mmap access is m25p80.c
>>>
>>> So my suggestion is
>>>
>>>  - add a new method for spi master that gets the read opcode, dummy
>>> length, address, address length, buffer, buffer length and performs
>>> read from the flash memory in a hardware-specific way
>>>
>>> - add a check in m25p80.c that the master supports this feature and if
>>> so use it (eg check that the method is non-null)
>>>
>>> Presumably if some new SPI controllers with similar feature are
>>> supported in the future they can use the same inteface because you
>>> pass on everything the m25p80 read knows.
>>>
>>
>> Ok... Do you mean something like this?
>>
>> I will take m25p80 as example but can be expanded for any flash.
>>
>> In include/linux/mtd.h:
>>         struct spi_mtd_config_info {
>>                 struct spi_device       *spi;
>>                 u32                     page_size;
>>                 u8                      addr_width;
>>                 u8                      erase_opcode;
>>                 u8                      read_opcode;
>>                 u8                      read_dummy;
>>                 u8                      program_opcode;
>>                 enum read_mode          flash_read;
>>
>>         } /* subset of struct spi_nor */
>>
> 
> I would just pass these as separate arguments to the function but whatver.
> 
>> In m25p80.c:
>>
>>         static int m25p80_read(struct spi_nor *nor, loff_t from,
>>                                 size_t len, size_t *retlen,
>>                                 u_char *buf)
>>         {
>>                 struct spi_mtd_config_info info;
>>                 struct spi_device *spi;
>>
>>                 if (spi->master->spi_mtd_mmap_read) {
>>                   /* Populate spi_mtd_config_info */
>>                   spi->master->spi_mtd_mmap_read(&info, from, len,
>>                                                  retlen, buf);
>>                 }
>>                 else {
>>                 /* no mtd specific acceleration supported try normal
>>                  * SPI way of communicating with flash
>>                  * continue with current code
>>                  * set up spi_message and call spi_sync()
>>                  */
>>         }
>>
>>       }
>>
>> In spi-ti-qspi.c:
>> Implement spi_mtd_mmap_read while holding master->bus_lock mutex.
>>
> 

I will re-submit patches based on the above idea, if there are no
further comments..

-- 
Thanks
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
