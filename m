From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP1] mux: Add MMC mux pins for omap7xx
Date: Tue, 6 Oct 2009 12:44:21 -0700
Message-ID: <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com>
	<4ACB7EC0.3010401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f173.google.com ([209.85.210.173]:33101 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757369AbZJFTpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 15:45:18 -0400
Received: by yxe3 with SMTP id 3so4020988yxe.4
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 12:44:41 -0700 (PDT)
In-Reply-To: <4ACB7EC0.3010401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Tue, Oct 6, 2009 at 10:30 AM, Nishanth Menon <nm@ti.com> wrote:
> Cory Maccarrone had written, on 10/06/2009 08:53 AM, the following:
>>
>> There are three mux pins needed for omap7xx that differ
>> from the other omap configurations. =A0This change adds the
>> declarations into mux.c and mux.h.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
>> =A0arch/arm/mach-omap1/mux.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++++=
+
>> =A0arch/arm/plat-omap/include/mach/mux.h | =A0 =A05 +++++
>> =A02 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
>> index d59899d..feb6d8c 100644
>> --- a/arch/arm/mach-omap1/mux.c
>> +++ b/arch/arm/mach-omap1/mux.c
>> @@ -51,6 +51,11 @@ MUX_CFG_7XX("E3_7XX_KBC4", =A0 =A0 =A0 =A013, =A0=
 25, =A0 =A00,
>> 24, =A0 1, 0)
>> =A0MUX_CFG_7XX("AA17_7XX_USB_DM", =A0 =A0 2, =A0 21, =A0 =A00, =A0 2=
0, =A0 0, 0)
>> =A0MUX_CFG_7XX("W16_7XX_USB_PU_EN", =A0 2, =A0 25, =A0 =A00, =A0 24,=
 =A0 0, 0)
>> =A0MUX_CFG_7XX("W17_7XX_USB_VBUSI", =A0 2, =A0 29, =A0 =A00, =A0 28,=
 =A0 0, 0)
>> +
>> +/* MMC Pins */
>> +MUX_CFG_7XX("MMC_7XX_CMD", =A0 =A0 =A0 =A0 2, =A0 =A09, =A0 =A00, =A0=
 =A08, =A0 1, 0)
>> +MUX_CFG_7XX("MMC_7XX_CLK", =A0 =A0 =A0 =A0 2, =A0 13, =A0 =A00, =A0=
 12, =A0 1, 0)
>> +MUX_CFG_7XX("MMC_7XX_DAT0", =A0 =A0 =A0 =A02, =A0 17, =A0 =A00, =A0=
 16, =A0 1, 0)
>> =A0};
>> =A0#define OMAP7XX_PINS_SZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE=
(omap7xx_pins)
>> =A0#else
>> diff --git a/arch/arm/plat-omap/include/mach/mux.h
>> b/arch/arm/plat-omap/include/mach/mux.h
>> index f3c1d8a..56e357e 100644
>> --- a/arch/arm/plat-omap/include/mach/mux.h
>> +++ b/arch/arm/plat-omap/include/mach/mux.h
>> @@ -219,6 +219,11 @@ enum omap7xx_index {
>> =A0 =A0 =A0 =A0AA17_7XX_USB_DM,
>> =A0 =A0 =A0 =A0W16_7XX_USB_PU_EN,
>> =A0 =A0 =A0 =A0W17_7XX_USB_VBUSI,
>> +
>> + =A0 =A0 =A0 /* MMC */
>> + =A0 =A0 =A0 MMC_7XX_CMD,
>> + =A0 =A0 =A0 MMC_7XX_CLK,
>> + =A0 =A0 =A0 MMC_7XX_DAT0,
>
> probably a dumb question -> but should'nt these go off to bootloader
> perhaps?
>
> --
> Regards,
> Nishanth Menon
>

Perhaps, although we use either EOL (for HTC Wizard) or Haret to boot,
and they don't set up the right mux configuration for our board.

This way though, we don't have to worry about the boot loader -- we
can set it up right regardless of who boots us.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
