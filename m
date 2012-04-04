From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: hwmod_data: Name the common irq for McBSP
 ports
Date: Wed, 4 Apr 2012 21:06:22 +0200
Message-ID: <4F7C9BAE.1030601@ti.com>
References: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com> <1332169966-25400-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1204040946230.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34010 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386Ab2DDTGe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Apr 2012 15:06:34 -0400
In-Reply-To: <alpine.DEB.2.00.1204040946230.8000@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 4/4/2012 5:46 PM, Paul Walmsley wrote:
> + Beno=EEt
>
> Hi Beno=EEt
>
> On Mon, 19 Mar 2012, Peter Ujfalusi wrote:
>
>> Use 'common' as name for the common irq number in hwmod data for the=
 McBSP
>> ports. The same name already in use for OMAP2430, and OMAP3.
>>
>> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
>
> care to Ack this one for 3.5?

That looks good to me.

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit


>
>
> - Paul
>
>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
>>   1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index ef0524c..f8058b7 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -2942,7 +2942,7 @@ static struct omap_hwmod_class omap44xx_mcbsp_=
hwmod_class =3D {
>>   /* mcbsp1 */
>>   static struct omap_hwmod omap44xx_mcbsp1_hwmod;
>>   static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] =3D {
>> -	{ .irq =3D 17 + OMAP44XX_IRQ_GIC_START },
>> +	{ .name =3D "common", .irq =3D 17 + OMAP44XX_IRQ_GIC_START },
>>   	{ .irq =3D -1 }
>>   };
>>
>> @@ -3017,7 +3017,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod=
 =3D {
>>   /* mcbsp2 */
>>   static struct omap_hwmod omap44xx_mcbsp2_hwmod;
>>   static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] =3D {
>> -	{ .irq =3D 22 + OMAP44XX_IRQ_GIC_START },
>> +	{ .name =3D "common", .irq =3D 22 + OMAP44XX_IRQ_GIC_START },
>>   	{ .irq =3D -1 }
>>   };
>>
>> @@ -3092,7 +3092,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod=
 =3D {
>>   /* mcbsp3 */
>>   static struct omap_hwmod omap44xx_mcbsp3_hwmod;
>>   static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] =3D {
>> -	{ .irq =3D 23 + OMAP44XX_IRQ_GIC_START },
>> +	{ .name =3D "common", .irq =3D 23 + OMAP44XX_IRQ_GIC_START },
>>   	{ .irq =3D -1 }
>>   };
>>
>> @@ -3167,7 +3167,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod=
 =3D {
>>   /* mcbsp4 */
>>   static struct omap_hwmod omap44xx_mcbsp4_hwmod;
>>   static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] =3D {
>> -	{ .irq =3D 16 + OMAP44XX_IRQ_GIC_START },
>> +	{ .name =3D "common", .irq =3D 16 + OMAP44XX_IRQ_GIC_START },
>>   	{ .irq =3D -1 }
>>   };
>>
>> --
>> 1.7.8.5
>>
>
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
