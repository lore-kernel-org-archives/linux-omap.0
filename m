From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/9] ARM: OMAP3: hwmod: rename the smartreflex entries
Date: Wed, 18 Apr 2012 22:41:33 +0200
Message-ID: <CAORVsuXO5jxBZOEjTpJ4NTwOugmkK2JdsPE6yU_HbJ6iSALSGg@mail.gmail.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
	<1332173578-27422-6-git-send-email-j-pihet@ti.com>
	<87k41dkks0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50115 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab2DRUle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 16:41:34 -0400
Received: by vcqp1 with SMTP id p1so5163365vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 13:41:33 -0700 (PDT)
In-Reply-To: <87k41dkks0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>

Kevin,

On Wed, Apr 18, 2012 at 7:33 PM, Kevin Hilman <khilman@ti.com> wrote:
> +Benoit
>
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Change the name field value to better reflect the smartreflex
>> integration in the system
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 =A08 ++++----
>> =A0arch/arm/mach-omap2/smartreflex.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
>> =A02 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_3xxx_data.c
>> index d7d4c70..40f57c4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -2751,7 +2751,7 @@ static struct omap_hwmod_ocp_if *omap34xx_sr1_=
slaves[] =3D {
>> =A0};
>>
>> =A0static struct omap_hwmod omap34xx_sr1_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr1",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpu_iva",
>
> Should this be "smartreflex_mpu_iva"?
>
> The OMAP4 SR hwmods have a 'smartreflex_' prefix which seems better.
>
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr1_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> @@ -2775,7 +2775,7 @@ static struct omap_hwmod_ocp_if *omap36xx_sr1_=
slaves[] =3D {
>> =A0};
>>
>> =A0static struct omap_hwmod omap36xx_sr1_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr1",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpu_iva",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap36xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr1_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> @@ -2803,7 +2803,7 @@ static struct omap_hwmod_ocp_if *omap34xx_sr2_=
slaves[] =3D {
>> =A0};
>>
>> =A0static struct omap_hwmod omap34xx_sr2_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr2",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "core",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr2_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> @@ -2827,7 +2827,7 @@ static struct omap_hwmod_ocp_if *omap36xx_sr2_=
slaves[] =3D {
>> =A0};
>>
>> =A0static struct omap_hwmod omap36xx_sr2_hwmod =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr2",
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "core",
>> =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap36xx_smartreflex_hwmo=
d_class,
>> =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr2_fck",
>> =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2=
/smartreflex.c
>> index c18d47d..b2728a5 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -184,7 +184,7 @@ static void sr_set_regfields(struct omap_sr *sr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->err_weight =3D OMAP3430_SR_ERRWEIGHT=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->err_maxlimit =3D OMAP3430_SR_ERRMAXL=
IMIT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->accum_data =3D OMAP3430_SR_ACCUMDATA=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(sr->name, "sr1"))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(sr->name, "sr_mpu_iva"))) {
>
> Why the 'sr_' prefix?
Historically the sr instance name is generated from hwmod name
prepended with "sr_".
I agree it is better to change the hwmod name and remove the "sr_"
prefix from the sr init code.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->senn_avgweight =3D O=
MAP3430_SR1_SENNAVGWEIGHT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr->senp_avgweight =3D O=
MAP3430_SR1_SENPAVGWEIGHT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>
> Kevin

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
