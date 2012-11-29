From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v6 4/5] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Thu, 29 Nov 2012 14:32:55 -0600
Message-ID: <50B7C677.7090504@ti.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com> <1354204892-22762-5-git-send-email-zonque@gmail.com> <50B7BE9C.6040506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab2K2UdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 15:33:03 -0500
In-Reply-To: <50B7BE9C.6040506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, avinashphilip@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 11/29/2012 01:59 PM, Jon Hunter wrote:
> 
> On 11/29/2012 10:01 AM, Daniel Mack wrote:
>> The am33xx is capable of handling bch error correction modes, so
>> enable that feature in the driver.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  arch/arm/mach-omap2/gpmc-nand.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>> index f9f23a2..c8a72ba 100644
>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>> @@ -92,17 +92,18 @@ static int omap2_nand_gpmc_retime(
>>  static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>>  {
>>  	/* support only OMAP3 class */
>> -	if (!cpu_is_omap34xx()) {
>> +	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
>>  		pr_err("BCH ecc is not supported on this CPU\n");
>>  		return 0;
>>  	}
>>  
>>  	/*
>> -	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1.
>> -	 * Other chips may be added if confirmed to work.
>> +	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
>> +	 * and AM33xx derivates. Other chips may be added if confirmed to work.
>>  	 */
>>  	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
>> -	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0))) {
>> +	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)) &&
>> +	    (!soc_is_am33xx())) {
>>  		pr_err("BCH 4-bit mode is not supported on this CPU\n");
>>  		return 0;
>>  	}
> 
> Sorry I should have seen this earlier. Ideally, this type of thing
> should be reflected by the device-tree/platform-data and we should get
> away from these cpu_is_xxxx macros for hardware features (where we can).
> Furthermore, we need to avoid including plat-omap/gpmc.h in drivers for
> the single zImage work (I see the omap nand driver is including gpmc.h).
> 
> Tony, should this be addressed now or can we live this for the minute
> and fix-up later?

Actually, I see that you do read the ecc mode from DT, so is this really
needed? It would be good to eliminate this.

Cheers
Jon
