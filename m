From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 04/10] ARM: OMAP3: hwmod: rename the smartreflex entries
Date: Fri, 4 May 2012 15:41:34 +0530
Message-ID: <CAJ6a13ZSWSa_RpGB9NxtfyChUba9NGivGogpsfyk7oT9pNayjg@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<1335462041-4949-5-git-send-email-j-keerthy@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1AA2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9B1AA2@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi AnilKumar,

Thanks for reviewing.

On Fri, May 4, 2012 at 2:00 PM, AnilKumar, Chimata <anilkumar@ti.com> w=
rote:
> On Thu, Apr 26, 2012 at 23:10:35, J, KEERTHY wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Change the name field value to better reflect the smartreflex
>> integration in the system.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Signed-off-by: J Keerthy <j-keerthy@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 =A08 ++++----
>> =A0arch/arm/mach-omap2/smartreflex.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
>> =A02 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_3xxx_data.c
>> index 144d118..15907b0 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -1324,7 +1324,7 @@ static struct omap_hwmod_irq_info omap3_smartr=
eflex_mpu_irqs[] =3D {
>> =A0};
>>
>> =A0static struct omap_hwmod omap34xx_sr1_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr1",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smartreflex_mpu_iva",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr1_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> @@ -1342,7 +1342,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod =3D=
 {
>> =A0};
>>
>> =A0static struct omap_hwmod omap36xx_sr1_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr1",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smartreflex_mpu_iva",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap36xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr1_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> @@ -1369,7 +1369,7 @@ static struct omap_hwmod_irq_info omap3_smartr=
eflex_core_irqs[] =3D {
>> =A0};
>>
>> =A0static struct omap_hwmod omap34xx_sr2_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr2",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smartreflex_core",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr2_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> @@ -1387,7 +1387,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod =3D=
 {
>> =A0};
>>
>> =A0static struct omap_hwmod omap36xx_sr2_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr2",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smartreflex_core",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap36xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr2_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2=
/smartreflex.c
>> index 2edd1e2..d859277 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -183,7 +183,7 @@ static void sr_set_regfields(struct omap_sr *sr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->err_weight =3D OMAP3430_SR_ERRWEIGHT=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->err_maxlimit =3D OMAP3430_SR_ERRMAXL=
IMIT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->accum_data =3D OMAP3430_SR_ACCUMDATA=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(sr->name, "sr1"))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(sr->name, "smartreflex_mpu_iv=
a"))) {
>
> What if voltage rail is different for mpu and iva? I have seen some d=
evices
> supports SmartReflex have different voltage rails for mpu and iva.
>

I get the point. OMAP3 iva and mpu have a common rail. OMAP4 onwards
even we have different rails for mpu and iva. I will enhance the checks=
 here.

> Regards
> AnilKumar



--=20
Regards and Thanks,
Keerthy
