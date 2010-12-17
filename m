From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Fri, 17 Dec 2010 11:52:06 -0600
Message-ID: <AANLkTinp4AuxsoUxkbW4A3LhSH7ScuNmgCVOvdkEo0MB@mail.gmail.com>
References: <1291792247-26634-1-git-send-email-raghuveer.murthy@ti.com> <201012081207.14044.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48893 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755237Ab0LQRw1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 12:52:27 -0500
Received: by mail-wy0-f180.google.com with SMTP id 28so892899wyb.25
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 09:52:26 -0800 (PST)
In-Reply-To: <201012081207.14044.marek.vasut@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony L <tony@atomide.com>
Cc: Raghuveer Murthy <raghuveer.murthy@ti.com>, linux-omap@vger.kernel.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Marek Vasut <marek.vasut@gmail.com>

Tony,

2010/12/8 Marek Vasut <marek.vasut@gmail.com>:
> On Wednesday 08 December 2010 08:10:47 Raghuveer Murthy wrote:
>> This patch adds omap_reserve functionality to board-omap4panda.c.
>> Helps in the reserving boot time memory in SDRAM, used here for
>> framebuffer allocation.
>>
>> This patch is in similar lines to commit id 71ee7dad9b6991, from
>> Russell king
>
> Russell King ... it's a surname, not a title :-D
>
> btw. CCing linux-arm-kernel, as that's a proper mailing list.

Gentle ping on this patch - should this be reposted for the -next
cycle inclusion?

Regards,
Nishanth Menon

>
> Cheers
>>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: linux-arm@lists.arm.linux.org.uk
>> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>> b/arch/arm/mach-omap2/board-omap4panda.c index da24745..0ccc24f 1006=
44
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -393,6 +393,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
>> =A0 =A0 =A0 /* Maintainer: David Anders - Texas Instruments Inc */
>> =A0 =A0 =A0 .boot_params =A0 =A0=3D 0x80000100,
>> =A0 =A0 =A0 .map_io =A0 =A0 =A0 =A0 =3D omap4_panda_map_io,
>> + =A0 =A0 .reserve =A0 =A0 =A0 =A0=3D omap_reserve,
>> =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D omap4_panda_init_irq,
>> =A0 =A0 =A0 .init_machine =A0 =3D omap4_panda_init,
>> =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
