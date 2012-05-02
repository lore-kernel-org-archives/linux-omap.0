From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/7] ARM: OMAP2+: Clean up wrapping multiple objects in Makefile
Date: Wed, 2 May 2012 15:44:27 +0530
Message-ID: <CAMQu2gx3_tZnQg=+8xm4Bnnv31BTOgJki_y=aNDOAUG-xNNrvg@mail.gmail.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-3-git-send-email-santosh.shilimkar@ti.com> <20120502095612.GG25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:57346 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab2EBKOt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 06:14:49 -0400
Received: by obbuo13 with SMTP id uo13so1694699obb.1
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 03:14:48 -0700 (PDT)
In-Reply-To: <20120502095612.GG25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, May 2, 2012 at 3:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, May 02, 2012 at 03:18:08PM +0530, Santosh Shilimkar wrote:
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/Makefile | =A0160 ++++++++++++++++++++-------=
--------------
>> =A01 files changed, 78 insertions(+), 82 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 56ed62e..669e2b1 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -24,10 +24,11 @@ endif
>> =A0obj-$(CONFIG_TWL4030_CORE) +=3D omap_twl.o
>>
>> =A0# SMP support ONLY available for OMAP4
>> +
>> =A0obj-$(CONFIG_SMP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D oma=
p-smp.o omap-headsmp.o
>> =A0obj-$(CONFIG_HOTPLUG_CPU) =A0 =A0 =A0 =A0 =A0 =A0+=3D omap-hotplu=
g.o
>> -obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D omap4-common.=
o omap-wakeupgen.o \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0sleep44xx.o
>> +obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D omap4-common.=
o omap-wakeupgen.o
>> +obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep44xx.o
>
> Using \ in makefiles really isn't a problem. =A0I don't think this is=
 something
> which we need to do, and it just creates additional changes where non=
e is
> required.

Tony might give better reasoning for this change since he suggested it.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
