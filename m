From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP3+: Kconfig: has EHCI only if USB present
Date: Fri, 10 Jun 2011 11:20:13 -0500
Message-ID: <BANLkTimRyXm7uBkUsMNbzb_VrdWbQ2WqCA@mail.gmail.com>
References: <1307718873-27652-1-git-send-email-nm@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D426804@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36624 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751324Ab1FJQUe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 12:20:34 -0400
Received: by mail-bw0-f49.google.com with SMTP id 1so3999466bwz.22
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 09:20:33 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D426804@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

On Fri, Jun 10, 2011 at 11:08, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishan=
th
>> Sent: Friday, June 10, 2011 8:45 PM
>> To: linux-omap
>> Cc: Tony; linux-arm; Balbi, Felipe; Menon, Nishanth
>> Subject: [PATCH] OMAP3+: Kconfig: has EHCI only if USB present
>>
>> Attempting to disable USB generates the following warning at
>> the moment:
>> warning: (ARCH_OMAP3 && ARCH_OMAP4) selects USB_ARCH_HAS_EHCI
>> which has unmet direct dependencies (USB_SUPPORT)
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> based on 3.0-rc2
>> =A0arch/arm/mach-omap2/Kconfig | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconf=
ig
>> index ef7e12f..d5cf1a8 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -33,7 +33,7 @@ config ARCH_OMAP3
>> =A0 =A0 =A0 depends on ARCH_OMAP2PLUS
>> =A0 =A0 =A0 default y
>> =A0 =A0 =A0 select CPU_V7
>> - =A0 =A0 select USB_ARCH_HAS_EHCI
>> + =A0 =A0 select USB_ARCH_HAS_EHCI if USB_SUPPORT
>> =A0 =A0 =A0 select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
>> =A0 =A0 =A0 select ARCH_HAS_OPP
>> =A0 =A0 =A0 select PM_OPP if PM
>> @@ -50,7 +50,7 @@ config ARCH_OMAP4
>> =A0 =A0 =A0 select ARM_ERRATA_720789
>> =A0 =A0 =A0 select ARCH_HAS_OPP
>> =A0 =A0 =A0 select PM_OPP if PM
>> - =A0 =A0 select USB_ARCH_HAS_EHCI
>> + =A0 =A0 select USB_ARCH_HAS_EHCI if USB_SUPPORT
>>
>> =A0comment "OMAP Core Type"
>> =A0 =A0 =A0 depends on ARCH_OMAP2
>
>
> Here is earlier discussion on the same subject:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42064.html
>
> Exactly same patch was proposed.

You may want to do that for the full Kconfig file(not just for OMAP3)
and post out..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
