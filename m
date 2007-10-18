From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: unlock flash device during boot
Date: Thu, 18 Oct 2007 07:30:52 -0700
Message-ID: <47176E1C.3060009@mvista.com>
References: <20071017222526.493688502@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290242BDAC@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290242BDAC@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard wrote:
> Long ago when the part size changed one version of the omap-nor driver did need to unlock partitions.  This was done on some internal tree version.
> 
> By partitions I mean physical ones, inside the NOR part.  Not mtd_partitions().  This only needed to be done on a per-partition basis not a per-sector one.
> 
> These physical partitions, allow for simultaneous XIP and programming on the same NOR chip.  One partition can be in status mode while another has code executing out of it.  
> 
> It kind of looks like this patch was aiming to do this.

FWIW, this patch was taken from the TI kernels on linux.omap.com which
have the same call to unlock in the probe hook.

Kevin

>> The bootloader may lock the flash device upon booting.  This requires
>> the use of 'flash_unlock' on each partition before using them.
>>
>> However, when booting from flash the MTD driver is unable to "mark
>> space as dirty" since the device is locked.  This results lots of boot
>> warnings from the MTD layer.
>>
>> The MTD driver for OMAP needs to unlock the device during init so
>> booting from flash can work without errors.
>>
>> Signed-off-by: Kevin Hilman <khilman@mvista.com>
>> ---
>>  drivers/mtd/maps/omap_nor.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> Index: linux-2.6.21/drivers/mtd/maps/omap_nor.c
>> ===================================================================
>> --- linux-2.6.21.orig/drivers/mtd/maps/omap_nor.c
>> +++ linux-2.6.21/drivers/mtd/maps/omap_nor.c
>> @@ -108,6 +108,10 @@ static int __devinit omapflash_probe(str
>>  	}
>>  	info->mtd->owner = THIS_MODULE;
>>
>> +	/* Unlock the flash device. */
>> +	if (info->mtd->unlock)
>> +		info->mtd->unlock(info->mtd, 0, info->mtd->size);
>> +
>>  #ifdef CONFIG_MTD_PARTITIONS
>>  	err = parse_mtd_partitions(info->mtd, part_probes, &info->parts, 0);
>>  	if (err > 0)
>> --
