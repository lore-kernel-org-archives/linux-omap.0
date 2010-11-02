From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 08/11] OMAP4: Adding dev atrributes to OMAP4 smartreflex hwmod data
Date: Tue, 02 Nov 2010 13:10:21 +0000
Message-ID: <87aalrg9c2.fsf@deeprootsystems.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
	<1285419086-13047-9-git-send-email-thara@ti.com>
	<4CC6B8AC.8090007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36218 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab0KBNKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 09:10:32 -0400
Received: by wwe15 with SMTP id 15so7350404wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 06:10:31 -0700 (PDT)
In-Reply-To: <4CC6B8AC.8090007@ti.com> (Benoit Cousson's message of "Tue, 26
	Oct 2010 13:17:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 9/25/2010 2:51 PM, Gopinath, Thara wrote:
>> This patch adds dev attributes for smartreflex modules
>> in the OMAP4 hwmod database. This patch also updates the
>> smartreflex rev in the smartreflex class data structure
>> in the OMAP4 hwmod database.
>>
>> Signed-off-by: Thara Gopinath<thara@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   56 ++++++++++++++++++++++++++++
>>   arch/arm/plat-omap/include/plat/control.h  |   12 ++++++
>>   2 files changed, 68 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index ba3c215..82657b5 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -22,6 +22,8 @@
>>
>>   #include<plat/omap_hwmod.h>
>>   #include<plat/cpu.h>
>> +#include<plat/smartreflex.h>
>> +#include<plat/control.h>
>>
>>   #include "omap_hwmod_common_data.h"
>>
>> @@ -474,6 +476,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
>>   static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
>>   	.name = "smartreflex",
>>   	.sysc =&omap44xx_smartreflex_sysc,
>> +	.rev  = 2,
>>   };
>>
>>   /* smartreflex_core */
>> @@ -505,6 +508,22 @@ static struct omap_hwmod_ocp_if *omap44xx_smartreflex_core_slaves[] = {
>>   	&omap44xx_l4_cfg__smartreflex_core,
>>   };
>>
>> +static u32 omap44xx_sr_core_efuse_offs[] = {
>> +	OMAP44XX_CONTROL_FUSE_CORE_OPP50, OMAP44XX_CONTROL_FUSE_CORE_OPP100,
>> +};
>> +
>> +static u32 omap44xx_sr_core_test_nvalues[] = {
>> +	0x0, 0x0
>> +};
>
> At first, I thought it was a good idea to put such data here, but now
> after the discussion about timer hwmod data, I realize I was wrong.
>
> These informations belong to omap_volt_data. For each OPP you should
> provide the efuse offset an the SW nvalues.
> BTW, you should not call them test Nvalues, these are perfectly valid
> and can be potentially used in production. There are just not as
> optimized as a efuse Nvalue.

Just to clarify... 

Benoit, what's your opinion of my comment that these values don't belong
in the volt_data.

As they are only used in the SR layer, they should remain there, IMO.
The only thing needed in volt_data is an efuse id/offset.

Kevin
