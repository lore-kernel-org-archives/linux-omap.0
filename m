From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 3/8] omap3: pm: Correcting the sys_offmode signal polarity
Date: Wed, 2 Mar 2011 11:41:09 +0530
Message-ID: <AANLkTimx7uxp0T7FDsyn8hULOUgS5mnsAcf_R=JoCsT7@mail.gmail.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
	<1298723139-1693-4-git-send-email-leslyam@ti.com>
	<87k4gifp0n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45661 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717Ab1CBGLL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 01:11:11 -0500
Received: by vxd2 with SMTP id 2so5597379vxd.8
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 22:11:09 -0800 (PST)
In-Reply-To: <87k4gifp0n.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Wed, Mar 2, 2011 at 4:05 AM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Changing the polarity of the sys_offmode signal to active low,
>> to get a High to Low transition on the NSLEEP1 of PM IC when OMAP is
>> entering offmode. Because on PM IC the power resources (LDO, DCDC re=
gulators)
>> associated with P1 group which is controlled by NSLEEP1 are set to s=
leep,
>> when there is transition form High to Low.
>>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index e46f4b5..8a7c756 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -1034,6 +1034,10 @@ static int __init omap3_pm_init(void)
>>
>> =A0 =A0 =A0 printk(KERN_ERR "Power Management for TI OMAP3.\n");
>>
>> + =A0 =A0 /* Changing the polarity of the sys_offmode signal to acti=
ve low */
>> + =A0 =A0 omap2_prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, OMAP3_PRM=
_POLCTRL_OFFSET);
>> +
>
> This change belongs in voltage code.
>

Ok, then I will move this change to the additional patch for testing
this T2 script.

Regards,
Lesly A M

< ... >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
