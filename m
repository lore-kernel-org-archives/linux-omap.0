From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 15:13:22 +0530
Message-ID: <BANLkTinP+79pEzkkD_dTU5SKDq=kAgdoNw@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-3-git-send-email-tarun.kanti@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:45698 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751145Ab1EZJoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 05:44:03 -0400
Received: by mail-pz0-f41.google.com with SMTP id 4so272997pzk.14
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 02:44:02 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D177FCC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Sanjeev,

Thanks for the comments.

On Thu, May 26, 2011 at 14:53, Premi, Sanjeev <premi@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> DebBarma, Tarun Kanti
>> Sent: Tuesday, May 24, 2011 7:55 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Hilman, Kevin; Shilimkar, Santosh; tony@atomide.com;
>> linux-arm-kernel@lists.infradead.org; Varadarajan,
>> Charulatha; Cousson, Benoit; Paul Walmsley
>> Subject: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO
>> and rev_ids
>>
>> From: Charulatha V <charu@ti.com>
>>
>> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
>> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
>> (bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.
>>
>> Fix the above by providing non-wakeup GPIO information through pdata
>> specific to the SoC.
>>
>> The GPIO rev id provided in the hwmod database is the same
>> for OMAP2420
>> and OMAP2430. Change the GPIO rev ids in hwmod database as given bel=
ow
>> so that it can be used to identify OMAP2420 and OMAP2430.
>> OMAP2420 - 0
>> OMAP2430 - 1
>> OMAP3 =A0 =A0- 2
>> OMAP4 =A0 =A0- 3

>
> [sp] Magic numbers should be avoided.
> =A0 =A0 Suggest using something like:
> =A0 =A0 #define GPIO_REV_2420 =A0 =A0 =A00
> =A0 =A0 #define GPIO_REV_2430 =A0 =A0 =A01
> =A0 =A0 #define GPIO_REV_34XX =A0 =A0 =A02
> =A0 =A0 #define GPIO_REV_44xx =A0 =A0 =A03
>
> =A0 =A0 We don't have to refer back to this comment while reading the=
 code.

Okay.

> =A0 =A0 I also believed that HWMODs were auto generated.
> =A0 =A0 Can the changes to structures in this patch recreated using c=
urrent
> =A0 =A0 scripts?

Benoit's and Paul's ack is required for this change.

>
> ~sanjeev
>
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> ---
>> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
26
>> ++++++++++++++++++++++++--
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 =A02 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A02 +-
>> =A0arch/arm/plat-omap/include/plat/gpio.h =A0 =A0 | =A0 =A01 +
>> =A0drivers/gpio/gpio_omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 11 +++--------
>> =A06 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 0446bd1..6cd26b4 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -56,6 +56,28 @@ static int omap2_gpio_dev_init(struct
>> omap_hwmod *oh, void *unused)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 switch (oh->class->rev) {
>> + =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (id =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP2420 Bank1 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0xe203ffc0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (id =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP2420 Bank2 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0x08700040;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case 2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (id =3D=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP3 Bank2 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0x00000001;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (id =3D=3D 6)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* non-wakeup GPIO pins fo=
r OMAP3 Bank6 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->non_wakeup_gpios =3D=
 0x08000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> [sp] Where is the description on non-wakeup GPIOs in OMAP3?

As mentioned in other reply, I am referring to
Table 25-5. GPIO Channel Description at page no 3354
OMAP3430 public TRM Version P. Please correct me if I am wrong.

> =A0 =A0 Here is text from AM37x TRM:
> =A0 =A0 [quote ...only relevant text]
> =A0 =A0 Each GPIO module provides 32 dedicated general-purpose pins w=
ith input
> =A0 =A0 and output capabilities; .... These pins can be configured fo=
r the
> =A0 =A0 following applications:
> =A0 =A0 - Data input (capture)/output (drive)
> =A0 =A0 - Keyboard interface with a debounce cell
> =A0 =A0 - Interrupt generation in ....
> =A0 =A0 - Wake-up request generation in idle mode
> =A0 =A0 [/quote]
> =A0 =A0 Otherwise, what are the GPIO2_WAKEUPENABLE (0x4905 0020) and
> =A0 =A0 GPIO6_WAKEUPENABLE (0x4905 8020) meant for?
>
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* No non-wakeup GPIO pins for other SoCs =
*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>
> ~sanjeev
>
> [snip]...[snip]
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
