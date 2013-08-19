From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 5/9] ARM: OMAP2+: AM33XX: Add assembly code for PM operations
Date: Mon, 19 Aug 2013 12:51:05 -0500
Message-ID: <52125B09.20004@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-6-git-send-email-d-gerlach@ti.com> <5212159F.10302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59863 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab3HSRvZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 13:51:25 -0400
In-Reply-To: <5212159F.10302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gururaja Hebbar <gururaja.hebbar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On 08/19/2013 07:54 AM, Gururaja Hebbar wrote:
> Hi,
>
> On 8/6/2013 11:19 PM, Dave Gerlach wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> In preparation for suspend-resume support for AM33XX, add
>> the assembly file with the code which is copied to internal
>> memory (OCMC RAM) during bootup and runs from there.
>>
>> As part of the low power entry (DeepSleep0 mode in AM33XX TRM),
>> the code running from OCMC RAM does the following
>> 1. Stores the EMIF configuration
>> 2. Puts external memory in self-refresh
>> 3. Disables EMIF clock
>> 4. Executes WFI after writing to MPU_CLKCTRL register.
>>
>
> ...snip...
> ...snip...
>
>
>> +	ldr	r1, [r0, #EMIF_DDR_PHY_CTRL_1]
>> +	str	r1, emif_rd_lat_val
>> +
>> +	/* Put SDRAM in self-refresh */
>> +	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
>> +	orr	r1, r1, #0xa0
>> +	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>> +	str	r1, [r0, #4]
>
> This seems to be a bug which I had pointed out to VB earlier.
>
> r0 ---> base of emif module
>
> r0 + 4 ---> EMIF4_0_SDRAM_STATUS   ===> which is read only register
>
>
> Above 2 lines should be as below
>
> +	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
> +	str	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
>
>
> It works even with the bug because the Shadow register is updated and
> that some how seems to take precedence.
>
>
> Thanks & regards
> Gururaja
>

Thanks for pointing this out, I have fixed it for next version.

Regards,
Dave

>
>> +
>> +	ldr	r1, dram_sync_word	@ a dummy access to DDR as per spec
>> +	ldr	r2, [r1, #0]
>

