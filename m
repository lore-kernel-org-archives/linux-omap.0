From: Kan-Ru Chen <kanru@0xlab.org>
Subject: Re: [PATCH] omap: Devkit8000: Use DIE id to initialize dm9000 MAC
	address
Date: Mon, 5 Jul 2010 19:54:17 +0800
Message-ID: <AANLkTimnLo0b--CkMP1DO_RDuDngy_bi2DlKoy69DVY0@mail.gmail.com>
References: <1278308819-9531-1-git-send-email-kanru@0xlab.org>
	<20100705094432.GO15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45184 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0GELyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 07:54:18 -0400
Received: by qyk35 with SMTP id 35so1499138qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Jul 2010 04:54:17 -0700 (PDT)
In-Reply-To: <20100705094432.GO15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>

On Mon, Jul 5, 2010 at 5:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kan-Ru Chen <kanru@0xlab.org> [100705 09:27]:
>> The devkit8000 debug boards often come with empty EEPROM thus withou=
t
>> valid ethernet MAC address. The DIE id to MAC formula is copied from
>> u-boot.
>>
>> Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
>> ---
>> =C2=A0arch/arm/mach-omap2/board-devkit8000.c | =C2=A0 17 +++++++++++=
++++++
>> =C2=A01 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-=
omap2/board-devkit8000.c
>> index a2a8afe..807ceee 100644
>> --- a/arch/arm/mach-omap2/board-devkit8000.c
>> +++ b/arch/arm/mach-omap2/board-devkit8000.c
>> @@ -45,6 +45,7 @@
>> =C2=A0#include <plat/usb.h>
>> =C2=A0#include <plat/timer-gp.h>
>> =C2=A0#include <plat/display.h>
>> +#include <plat/io.h>
>>
>> =C2=A0#include <plat/mcspi.h>
>> =C2=A0#include <linux/input/matrix_keypad.h>
>> @@ -66,6 +67,10 @@
>> =C2=A0#define OMAP_DM9000_GPIO_IRQ 25
>> =C2=A0#define OMAP3_DEVKIT_TS_GPIO 27
>>
>> +#define DIE_ID_REG_BASE =C2=A0 =C2=A0 =C2=A0(L4_34XX_PHYS + 0xA000)
>> +#define DIE_ID_REG_0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x218
>> +#define DIE_ID_REG_1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x21C
>> +
>> =C2=A0struct flash_partitions {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mtd_partition *parts;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nr_parts;
>> @@ -603,6 +608,9 @@ static struct platform_device omap_dm9000_dev =3D=
 {
>>
>> =C2=A0static void __init omap_dm9000_init(void)
>> =C2=A0{
>> + =C2=A0 =C2=A0 unsigned char *eth_addr =3D omap_dm9000_platdata.dev=
_addr;
>> + =C2=A0 =C2=A0 unsigned int die_id_0;
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 =
irq") < 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "Fa=
iled to request GPIO%d for dm9000 IRQ\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 OMAP_DM9000_GPIO_IRQ);
>> @@ -610,6 +618,15 @@ static void __init omap_dm9000_init(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
>> +
>> + =C2=A0 =C2=A0 /* init the mac address using DIE id */
>> + =C2=A0 =C2=A0 die_id_0 =3D omap_readl(DIE_ID_REG_BASE + DIE_ID_REG=
_0);
>
> We should not add omap_readl/writel to any new code, those are slowly
> going away.
>
>> + =C2=A0 =C2=A0 eth_addr[0] =3D 0x02; /* locally administered */
>> + =C2=A0 =C2=A0 eth_addr[1] =3D omap_readl(DIE_ID_REG_BASE + DIE_ID_=
REG_1) & 0xff;
>> + =C2=A0 =C2=A0 eth_addr[2] =3D (die_id_0 & 0xff000000) >> 24;
>> + =C2=A0 =C2=A0 eth_addr[3] =3D (die_id_0 & 0x00ff0000) >> 16;
>> + =C2=A0 =C2=A0 eth_addr[4] =3D (die_id_0 & 0x0000ff00) >> 8;
>> + =C2=A0 =C2=A0 eth_addr[5] =3D (die_id_0 & 0x000000ff);
>> =C2=A0}
>>
>> =C2=A0static struct platform_device *devkit8000_devices[] __initdata=
 =3D {
>
> How about adding a function for getting this from mach-omap2/id.c?
> Other boards might want to use it too.

I had originally intended to do so, but I was not sure how to design th=
e api.

omap_read_die_0(), omap_read_die_id_1() and so on? or a function that
return those ids at once?

Any suggestions?

Regards,
Kanru

> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
