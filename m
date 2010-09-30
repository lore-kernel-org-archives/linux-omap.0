From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Re: Compilation: omap-for-linus omap2plus error
Date: Thu, 30 Sep 2010 03:55:14 -0500
Message-ID: <AANLkTik77kJVLPm60rZEDZcGfh=X4oC_4=aFfPS+JzQj@mail.gmail.com>
References: <4CA409E3.8000800@ti.com>
	<AANLkTinONbTyE4CKDnGfXrco-qy0=u_MpzimpCSnDZr7@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64945 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab0I3IzQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 04:55:16 -0400
Received: by fxm4 with SMTP id 4so531569fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Sep 2010 01:55:15 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02FA5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Santosh,

On Thu, Sep 30, 2010 at 2:55 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> > =A0CC =A0 =A0 =A0arch/arm/mach-omap2/pm_bus.o
>> > arch/arm/mach-omap2/pm_bus.c: In function 'omap_pm_runtime_init':
>> > arch/arm/mach-omap2/pm_bus.c:64: error: implicit declaration of fu=
nction
>> > 'platform_bus_get_pm_ops'
>> > arch/arm/mach-omap2/pm_bus.c:64: warning: assignment makes pointer=
 from
>> > integer without a cast
>> > arch/arm/mach-omap2/pm_bus.c:81: error: implicit declaration of fu=
nction
>> > 'platform_bus_set_pm_ops'
>>
>> I am trying using following commit as latest
>>
>> Kevin Hilman
>> 7ad0e386d46e9edff64705ab25337ad9130baf63
>> OMAP2+: defconfig: disable CPUfreq
>>
> Looks like Kevin's platform.c patch is missing
> in omap-for-linus branch. Patch attached.
>

Compilation error fixed... no more issues

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
