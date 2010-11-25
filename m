From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
Date: Thu, 25 Nov 2010 10:06:11 +0530
Message-ID: <AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com> <1290524213-395-6-git-send-email-charu@ti.com>
 <4CED8DF7.6040606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41594 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343Ab0KYEgx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 23:36:53 -0500
Received: by mail-iw0-f178.google.com with SMTP id 1so613245iwn.9
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 20:36:53 -0800 (PST)
In-Reply-To: <4CED8DF7.6040606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

Benoit,

On Thu, Nov 25, 2010 at 03:43, Cousson, Benoit <b-cousson@ti.com> wrote=
:
> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>
>> Add GPIO hwmod data for OMAP2420
>>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0229
>> ++++++++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/gpio.h =A0 =A0 | =A0 =A05 +
>> =A02 files changed, 234 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> index a1a3dd6..c951061 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> @@ -17,6 +17,7 @@
>> =A0#include<plat/dma.h>
>> =A0#include<plat/serial.h>
>> =A0#include<plat/i2c.h>
>> +#include<plat/gpio.h>
>> =A0#include<plat/omap24xx.h>
>
> Do you still need that header file?

Yes, for the gpio_dev_attr

>
>>
>> =A0#include "omap_hwmod_common_data.h"
>> @@ -38,6 +39,10 @@ static struct omap_hwmod omap2420_iva_hwmod;
>> =A0static struct omap_hwmod omap2420_l3_main_hwmod;
>> =A0static struct omap_hwmod omap2420_l4_core_hwmod;
>> =A0static struct omap_hwmod omap2420_wd_timer2_hwmod;
>> +static struct omap_hwmod omap2420_gpio1_hwmod;
>> +static struct omap_hwmod omap2420_gpio2_hwmod;
>> +static struct omap_hwmod omap2420_gpio3_hwmod;
>> +static struct omap_hwmod omap2420_gpio4_hwmod;
>>
>> =A0/* L3 -> =A0L4_CORE interface */
>> =A0static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core =3D {
>> @@ -557,6 +562,224 @@ static struct omap_hwmod omap2420_i2c2_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D HWMOD_16BIT_REG,
>> =A0};
>>
>> +/* l4_wkup -> =A0gpio1 */
>> +static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x48018000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x480181ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap2420_l4_wkup_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap2420_gpio1_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "gpios_ick",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2420_gpio1_addr_spac=
e,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2420_gpio1_ad=
dr_space),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +/* l4_wkup -> =A0gpio2 */
>> +static struct omap_hwmod_addr_space omap2420_gpio2_addr_space[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4801a000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4801a1ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap2420_l4_wkup_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap2420_gpio2_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "gpios_ick",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2420_gpio2_addr_spac=
e,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2420_gpio2_ad=
dr_space),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +/* l4_wkup -> =A0gpio3 */
>> +static struct omap_hwmod_addr_space omap2420_gpio3_addr_space[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4801c000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4801c1ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap2420_l4_wkup_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap2420_gpio3_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "gpios_ick",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2420_gpio3_addr_spac=
e,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2420_gpio3_ad=
dr_space),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +/* l4_wkup -> =A0gpio4 */
>> +static struct omap_hwmod_addr_space omap2420_gpio4_addr_space[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4801e000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4801e1ff=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap2420_l4_wkup_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap2420_gpio4_hwmod,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "gpios_ick",
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2420_gpio4_addr_spac=
e,
>> + =A0 =A0 =A0 .addr_cnt =A0 =A0 =A0 =3D ARRAY_SIZE(omap2420_gpio4_ad=
dr_space),
>> + =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_=
SDMA,
>> +};
>> +
>> +/* gpio dev_attr */
>> +static struct omap_gpio_dev_attr gpio_dev_attr =3D {
>> + =A0 =A0 =A0 .bank_width =3D 32,
>> + =A0 =A0 =A0 .dbck_flag =3D false,
>> +};
>> +

<<snip>>

>> =A0};
>>
>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h
>> b/arch/arm/plat-omap/include/plat/gpio.h
>
> That change should not necessarily be there, it is not directly relat=
ed to
> the subject.
>
> Maybe that should be in an extra patch just before that one.

I merged these two patches because of a comment to introduce
new variables/structures only in the patch where they are used.
Since "omap_gpio_dev_attr" is being used by hwmod DB I merged
these two patches. Do you think that hwmod DB patches should not
be merged with other patches?

>
> Beside these 2 minor comments, that patch seems good to me.
>
> Almost-acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks.

>
> Regards,
> Benoit
>
>> index 5bef86d..24892a6 100644
>> --- a/arch/arm/plat-omap/include/plat/gpio.h
>> +++ b/arch/arm/plat-omap/include/plat/gpio.h
>> @@ -79,6 +79,11 @@
>> =A0#define METHOD_GPIO_24XX =A0 =A0 =A05
>> =A0#define METHOD_GPIO_44XX =A0 =A0 =A06
>>
>> +struct omap_gpio_dev_attr {
>> + =A0 =A0 =A0 int bank_width; =A0 =A0 =A0 =A0 /* GPIO bank width */
>> + =A0 =A0 =A0 bool dbck_flag; =A0 =A0 =A0 =A0 /* dbck required or no=
t - True for OMAP3&4
>> */
>> +};
>> +
>> =A0struct omap_gpio_platform_data {
>> =A0 =A0 =A0 =A0u16 virtual_irq_start;
>> =A0 =A0 =A0 =A0int bank_type;
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
