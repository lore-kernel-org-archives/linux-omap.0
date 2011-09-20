From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] OMAP4: Fix the emif and dmm virtual mapping
Date: Tue, 20 Sep 2011 20:31:41 +0530
Message-ID: <4E78AAD5.6010906@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>	<1315459327-3285-9-git-send-email-santosh.shilimkar@ti.com> <87r53gnzfh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53733 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000Ab1ITPBu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 11:01:50 -0400
Received: by mail-gy0-f179.google.com with SMTP id 4so446579gyg.38
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 08:01:49 -0700 (PDT)
In-Reply-To: <87r53gnzfh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Girish S G <girishsg@ti.com>

On Friday 16 September 2011 11:26 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Fix the address overlap with Emulation domain (EMU).
>>
>> The previous mapping was entering into EMU mapping
>> and was not as per comments. Fix the mapping accordingly.
>>
>> [girishsg@ti.com: Helped fixing comments.]
>> Signed-off-by: Girish S G <girishsg@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/plat-omap/include/plat/io.h |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
>> index d72ec85..a2f7d31 100644
>> --- a/arch/arm/plat-omap/include/plat/io.h
>> +++ b/arch/arm/plat-omap/include/plat/io.h
>> @@ -228,12 +228,12 @@
>>  
>>  #define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
>>  						/* 0x4d000000 --> 0xfd200000 */
>> -#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_IO_OFFSET)
>> +#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + SZ_1M)
> 
> IMO, this would be much clearer (and future proof) if you used
> '+ OMAP44XX_EMIF1_SIZE' instead of SZ_1M.
> 
ok.

>>  #define OMAP44XX_EMIF2_SIZE	SZ_1M
>>  
>>  #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
>>  						/* 0x4e000000 --> 0xfd300000 */
>> -#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
>> +#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + SZ_1M)
> 
> and '+ OMAP44XX_EMIF2_SIZE' here.
> 
Will add OMAP44XX_EMIF_SIZE since 2 EMIFs instaces are and
suppose to be identical.Almost missed this email in other traffic.

Regards
Santosh
