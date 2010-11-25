From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7 07/11] OMAP3: hwmod data: Add GPIO
Date: Thu, 25 Nov 2010 10:07:45 +0530
Message-ID: <AANLkTik4dtCv9uVbL4dJgw+mpK-WWGZykUHSsKv4zvEZ@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-8-git-send-email-charu@ti.com>
 <4CED96EC.1040608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37514 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226Ab0KYEi0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 23:38:26 -0500
Received: by mail-iw0-f172.google.com with SMTP id 40so611758iwn.31
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 20:38:25 -0800 (PST)
In-Reply-To: <4CED96EC.1040608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Benoit,

On Thu, Nov 25, 2010 at 04:21, Cousson, Benoit <b-cousson@ti.com> wrote=
:
> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>
>> Add GPIO hwmod data for OMAP3
>>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks.

>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0360
>> ++++++++++++++++++++++++++++
>> =A01 files changed, 360 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index a8bed84..9ca2206 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -20,6 +20,7 @@
>> =A0#include<plat/serial.h>
>> =A0#include<plat/l4_3xxx.h>
>> =A0#include<plat/i2c.h>
>> +#include<plat/gpio.h>
>> =A0#include<plat/omap34xx.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>> @@ -45,6 +46,12 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod=
;
>> =A0static struct omap_hwmod omap3xxx_i2c1_hwmod;
>> =A0static struct omap_hwmod omap3xxx_i2c2_hwmod;

<<snip>>

>> +};
>> +
>> +/* gpio1 */
>> +static struct omap_hwmod_irq_info omap3xxx_gpio1_irqs[] =3D {
>> + =A0 =A0 =A0 { .name =3D "gpio_mpu_irq", .irq =3D 29 }, /* INT_34XX=
_GPIO_BANK1 */
>
> In this case the name is not necessarily needed since there is only o=
ne irq
> line.
> You can save some memory by just adding the .irq field.

Yes, I too thought about it. But to be consistent with other devices,
I included it here
as I did not receive any comments before on this. Anyways, will remove
them while
re-sending patches as per Kevin's suggestions to rebase them on pm-core=
 branch.

>
> Benoit
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
