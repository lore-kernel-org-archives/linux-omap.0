From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Fri, 1 Feb 2013 19:22:05 -0600
Message-ID: <510C6A3D.70401@ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com> <1359736726-10193-3-git-send-email-jon-hunter@ti.com> <20130201215154.GV22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757258Ab3BBBWJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 20:22:09 -0500
In-Reply-To: <20130201215154.GV22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>


On 02/01/2013 03:51 PM, Tony Lindgren wrote:
> Hi Jon,
> 
> * Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -32,6 +32,7 @@
>>  
>>  #include "soc.h"
>>  #include "common.h"
>> +#include "control.h"
>>  #include "omap_device.h"
>>  #include "gpmc.h"
>>  
>> @@ -778,18 +779,26 @@ static void gpmc_mem_exit(void)
>>  static int gpmc_mem_init(void)
>>  {
>>  	int cs, rc;
>> -	unsigned long boot_rom_space = 0;
>>  
>> -	/* never allocate the first page, to facilitate bug detection;
>> -	 * even if we didn't boot from ROM.
>> +	/*
>> +	 * The first 1MB of GPMC address space is mapped to the
>> +	 * internal ROM. OMAP2 devices are an exception to this
>> +	 * where the first 1MB may be mapped to the GPMC.
>>  	 */
>> -	boot_rom_space = BOOT_ROM_SPACE;
>> -	/* In apollon the CS0 is mapped as 0x0000 0000 */
>> -	if (machine_is_omap_apollon())
>> -		boot_rom_space = 0;
> 
> This part is going away anyways with the patch dropping apollon
> board support from Kyungin.

Yes just saw that today.

>> -	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
>> +	gpmc_mem_root.start = GPMC_MEM_START + BOOT_ROM_SPACE;
>>  	gpmc_mem_root.end = GPMC_MEM_END;
>>  
>> +	/*
>> +	 * OMAP2 devices that boot from external memory devices, will
>> +	 * map CS0 to the start of the GPMC address space (0x0). We can
>> +	 * test this by checking if SYS_BOOT3 pin is set. If not set
>> +	 * then CS0 is mapped to 0x0.
>> +	 */
>> +	if (cpu_is_omap24xx())
>> +		if (!(omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
>> +		      OMAP2_SYSBOOT_3_MASK))
>> +			gpmc_mem_root.start = GPMC_MEM_START;
>> +
>>  	/* Reserve all regions that has been set up by bootloader */
>>  	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
>>  		u32 base, size;
> 
> How about let's fix this properly to start with so we don't add
> more blockers moving this code to drivers/bus?
> 
> Looks like gpmc_mem_init() gets called from gpmc_probe() so
> we can pass that information in pdev.

I wondered if you would suggest that ;-)

I definitely can and it is probably best. Things like this become
painful when we move to device-tree. We really need a generic way for
passing stuff like this to drivers for omap. Our options are auxdata or
bus notifiers. I am wondering whether we can plug pdata in the
omap_device bus notifier for device-tree. Let me know if you have any
thoughts.

Cheers
Jon
