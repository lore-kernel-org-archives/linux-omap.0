From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/13] ARM: OMAP5: Add the WakeupGen IP updates.
Date: Thu, 10 May 2012 17:12:25 +0530
Message-ID: <CAMQu2gz4vw_jibsjSN_a-xAzp3Uthhvx2V=Y7KB5uO3q+N+WuQ@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-9-git-send-email-r.sricharan@ti.com> <4FABA84A.9000507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:52126 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932073Ab2EJLmq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 07:42:46 -0400
Received: by qcso7 with SMTP id o7so1219314qcs.34
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 04:42:45 -0700 (PDT)
In-Reply-To: <4FABA84A.9000507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com

On Thu, May 10, 2012 at 5:06 PM, Roger Quadros <rogerq@ti.com> wrote:
> Hi,
>
> On 05/03/2012 10:26 AM, R Sricharan wrote:
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> OMAP4 and OMAP5 share same WakeupGen IP with below few udpates on OM=
AP5.
>> - Additional 32 interrupt support is added w.r.t OMAP4 design.
>> - The AUX CORE boot registers are now made accessible from non-secur=
e SW.
>> - SAR offset are changed and PTMSYNC* registers are removed from SAR=
=2E
>>
>> Patch updates the WakeupGen code accordingly.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/include/mach/omap-wakeupgen.h | =A0 =A06 +
>> =A0arch/arm/mach-omap2/omap-hotplug.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 24 ++++-
>> =A0arch/arm/mach-omap2/omap-smp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 19 +++-
>> =A0arch/arm/mach-omap2/omap-wakeupgen.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0110 +++++++++++++++-----
>> =A0arch/arm/mach-omap2/omap4-sar-layout.h =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 12 ++-
>> =A05 files changed, 135 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arc=
h/arm/mach-omap2/include/mach/omap-wakeupgen.h
>> index 548de90..4d700bc 100644
>> --- a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
>> +++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
>> @@ -11,15 +11,20 @@
>> =A0#ifndef OMAP_ARCH_WAKEUPGEN_H
>> =A0#define OMAP_ARCH_WAKEUPGEN_H
>>
>> +/* OMAP4 and OMAP5 has same base address */
>> +#define OMAP_WKUPGEN_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x=
48281000
>
> unnecessary change, why don't you just use OMAP44XX_WKUPGEN_BASE or
> define this in the same header as OMAP44XX_WKUPGEN_BASE?
>
Just to avoid confusion about OMAP44XX and OMAP54XX. It's cleaner to
remove the OMAP44XX reference if the base is generic and not depend
on OMAP4/5.

It's not un-necessary change as such.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
