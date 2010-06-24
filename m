From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 05/13] OMAP2&3: hwmod: Remove _hwmod prefix in name
 string
Date: Thu, 24 Jun 2010 13:53:29 +0200
Message-ID: <74583B8642AB8841B30447520659FCA901AA590C9E@dnce01.ent.ti.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
 <1277336563-24988-6-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.1006232302580.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829Ab0FXLxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 07:53:46 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.1006232302580.1550@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Paul,

>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Thursday, June 24, 2010 7:05 AM
>
>Beno=EEt,
>
>one minor comment here:
>
>On Wed, 23 Jun 2010, Kevin Hilman wrote:
>
>> From: Benoit Cousson <b-cousson@ti.com>
>>
>> In the lastest OMAP4 hwmod data file, the _hwmod was removed
>> in order to save some memory space and because it does not
>> bring a lot.
>> Align OMAP2420, 2430 and 3430 data files with the same convention.
>
>Shouldn't we also synchronize the names of the structures as
>well?  i.e.,
>if the name is changed to "l3_main", shouldn't the name of the
>structure
>also be changed from
>
>   static struct omap_hwmod omap2420_l3_hwmod =3D {
>
>to
>
>   static struct omap_hwmod omap2420_l3_main_hwmod =3D {
>
>(... as one example?)

You're right, I didn't change that because only the string is relevant
for the lookup, but it will be much more consitent to change the struct=
ures
as well.

I'll do it.

Thanks,
Benoit

>
>
>- Paul
>
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
>>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> index a8b57a6..646386c 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> @@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if
>*omap2420_l3_masters[] =3D {
>>
>>  /* L3 */
>>  static struct omap_hwmod omap2420_l3_hwmod =3D {
>> -    .name           =3D "l3_hwmod",
>> +    .name           =3D "l3_main",
>>      .class          =3D &l3_hwmod_class,
>>      .masters        =3D omap2420_l3_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap2420_l3_masters),
>> @@ -90,7 +90,7 @@ static struct omap_hwmod_ocp_if
>*omap2420_l4_core_masters[] =3D {
>>
>>  /* L4 CORE */
>>  static struct omap_hwmod omap2420_l4_core_hwmod =3D {
>> -    .name           =3D "l4_core_hwmod",
>> +    .name           =3D "l4_core",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap2420_l4_core_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap2420_l4_core_masters),
>> @@ -111,7 +111,7 @@ static struct omap_hwmod_ocp_if
>*omap2420_l4_wkup_masters[] =3D {
>>
>>  /* L4 WKUP */
>>  static struct omap_hwmod omap2420_l4_wkup_hwmod =3D {
>> -    .name           =3D "l4_wkup_hwmod",
>> +    .name           =3D "l4_wkup",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap2420_l4_wkup_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap2420_l4_wkup_masters),
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> index 8b1f74b..b2100cf 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if
>*omap2430_l3_masters[] =3D {
>>
>>  /* L3 */
>>  static struct omap_hwmod omap2430_l3_hwmod =3D {
>> -    .name           =3D "l3_hwmod",
>> +    .name           =3D "l3_main",
>>      .class          =3D &l3_hwmod_class,
>>      .masters        =3D omap2430_l3_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap2430_l3_masters),
>> @@ -92,7 +92,7 @@ static struct omap_hwmod_ocp_if
>*omap2430_l4_core_masters[] =3D {
>>
>>  /* L4 CORE */
>>  static struct omap_hwmod omap2430_l4_core_hwmod =3D {
>> -    .name           =3D "l4_core_hwmod",
>> +    .name           =3D "l4_core",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap2430_l4_core_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap2430_l4_core_masters),
>> @@ -113,7 +113,7 @@ static struct omap_hwmod_ocp_if
>*omap2430_l4_wkup_masters[] =3D {
>>
>>  /* L4 WKUP */
>>  static struct omap_hwmod omap2430_l4_wkup_hwmod =3D {
>> -    .name           =3D "l4_wkup_hwmod",
>> +    .name           =3D "l4_wkup",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap2430_l4_wkup_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap2430_l4_wkup_masters),
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index e288b20..ec6a5f8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -70,7 +70,7 @@ static struct omap_hwmod_ocp_if
>*omap3xxx_l3_masters[] =3D {
>>
>>  /* L3 */
>>  static struct omap_hwmod omap3xxx_l3_hwmod =3D {
>> -    .name           =3D "l3_hwmod",
>> +    .name           =3D "l3_main",
>>      .class          =3D &l3_hwmod_class,
>>      .masters        =3D omap3xxx_l3_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap3xxx_l3_masters),
>> @@ -101,7 +101,7 @@ static struct omap_hwmod_ocp_if
>*omap3xxx_l4_core_masters[] =3D {
>>
>>  /* L4 CORE */
>>  static struct omap_hwmod omap3xxx_l4_core_hwmod =3D {
>> -    .name           =3D "l4_core_hwmod",
>> +    .name           =3D "l4_core",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap3xxx_l4_core_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap3xxx_l4_core_masters),
>> @@ -122,7 +122,7 @@ static struct omap_hwmod_ocp_if
>*omap3xxx_l4_per_masters[] =3D {
>>
>>  /* L4 PER */
>>  static struct omap_hwmod omap3xxx_l4_per_hwmod =3D {
>> -    .name           =3D "l4_per_hwmod",
>> +    .name           =3D "l4_per",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap3xxx_l4_per_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap3xxx_l4_per_masters),
>> @@ -143,7 +143,7 @@ static struct omap_hwmod_ocp_if
>*omap3xxx_l4_wkup_masters[] =3D {
>>
>>  /* L4 WKUP */
>>  static struct omap_hwmod omap3xxx_l4_wkup_hwmod =3D {
>> -    .name           =3D "l4_wkup_hwmod",
>> +    .name           =3D "l4_wkup",
>>      .class          =3D &l4_hwmod_class,
>>      .masters        =3D omap3xxx_l4_wkup_masters,
>>      .masters_cnt    =3D ARRAY_SIZE(omap3xxx_l4_wkup_masters),
>> --
>> 1.7.0.2
>>
>
>
>- Paul
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Lo=
ubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
