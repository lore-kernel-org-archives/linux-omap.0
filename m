From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH 2/7] OMAP4: ID: add omap_has_feature for max freq supported
Date: Fri, 01 Jul 2011 10:18:02 +0530
Message-ID: <4E0D5182.4020205@ti.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com> <1309486081-8257-2-git-send-email-rnayak@ti.com> <1309486081-8257-3-git-send-email-rnayak@ti.com> <20110701024128.GA32673@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48518 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795Ab1GAEso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 00:48:44 -0400
Received: by mail-yi0-f47.google.com with SMTP id 18so1266988yib.6
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 21:48:43 -0700 (PDT)
In-Reply-To: <20110701024128.GA32673@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>



On Friday 01 July 2011 08:11 AM, Todd Poynor wrote:
> On Fri, Jul 01, 2011 at 07:37:56AM +0530, Rajendra Nayak wrote:
>> From: Aneesh V<aneesh@ti.com>
>>
>> Macros for identifying the max frequency supported by various
>> OMAP4 variants - Expanding along the lines of OMAP3's feature
>> handling.
>>
>> [nm@ti.com: minor fixes for checks that should only for 443x|446x]
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> Signed-off-by: Aneesh V<aneesh@ti.com>
>> ---
>>   arch/arm/mach-omap2/id.c              |   29 +++++++++++++++++++++++++++++
>>   arch/arm/plat-omap/include/plat/cpu.h |   19 +++++++++++++++++++
>>   2 files changed, 48 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 3d43d64..a86d0f9 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -32,6 +32,7 @@ static struct omap_chip_id omap_chip;
>>   static unsigned int omap_revision;
>>
>>   u32 omap3_features;
>> +u32 omap4_features;
>
> Since the features are enabled by cpu_is*, need to have separate masks
> for OMAP3 vs. OMAP4 in same kernel?

No. I think they can be same. How about changing both to omap_features?
I would not like to use omap3_features for OMAP4.

>
>>
>>   unsigned int omap_rev(void)
>>   {
>> @@ -212,6 +213,33 @@ static void __init omap3_check_features(void)
>>   	 */
>>   }
>>
>> +static void __init omap4_check_features(void)
>> +{
>> +	u32 si_type;
>> +
>> +	omap4_features = 0;
>
> Already guaranteed to be zero, could skip this.

ok.

>
>> +
>> +	if (cpu_is_omap443x())
>> +		omap4_features |= OMAP4_HAS_MPU_1GHZ;
>> +
>> +
>> +	if (cpu_is_omap446x()) {
>> +		si_type =
>> +			read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1);
>> +		switch ((si_type&  (3<<  16))>>  16) {
>> +		case 2:
>> +			/* High performance device */
>> +			omap4_features |= OMAP4_HAS_MPU_1_5GHZ;
>> +			break;
>
> Should this fall through to also add OMAP4_HAS_MPU_1_2GHZ?  (Or are
> they mutually exclusive, or 1.5 implies 1.2 also present by
> convention)?

This is the max frequency supported by the device. So, 1.5GHz implies
availability of 1.2GHz

