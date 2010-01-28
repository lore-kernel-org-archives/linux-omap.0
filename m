From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Thu, 28 Jan 2010 14:24:04 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E768536D@dnce01.ent.ti.com>
References: <1264657260-12310-1-git-send-email-nm@ti.com>
 <4B6134EB.8040202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab0A1NY0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 08:24:26 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <4B6134EB.8040202@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Andrew Murray <amurray@mpc-data.co.uk>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Nishanth,

>From: Dasgupta, Romit
>
>Menon, Nishanth wrote:
>> We had removed the frequency for OPP1 L3 when we used to use frequency
>> to enable/disable frequencies. It is better to populate the same
>> instead of confusing future readers of the code. The OPP1 remains
>> disabled as explained in the discussion.
>
>IMHO the best way to unconfuse readers is to remove the entry.

The confusion is due to a mismatch between public TRM/white paper and current code, so maybe a simple comment on top of the omap34xx_l3_rate_table will be enough.

Regards,
Benoit

>>
>> Discussion: http://marc.info/?t=126453821900001&r=1&w=2
>>
>> Cc: Andrew Murray <amurray@mpc-data.co.uk>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/mach-omap2/cpufreq34xx.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-
>omap2/cpufreq34xx.c
>> index 209af2b..aec1ffe 100644
>> --- a/arch/arm/mach-omap2/cpufreq34xx.c
>> +++ b/arch/arm/mach-omap2/cpufreq34xx.c
>> @@ -43,7 +43,7 @@ static struct omap_opp_def __initdata
>omap34xx_mpu_rate_table[] = {
>>
>>  static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
>>      /* OPP1 */
>> -    OMAP_OPP_DEF(false, 0, 975000),
>> +    OMAP_OPP_DEF(false, 41500000, 975000),
>>      /* OPP2 */
>>      OMAP_OPP_DEF(true, 83000000, 1050000),
>>      /* OPP3 */


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



