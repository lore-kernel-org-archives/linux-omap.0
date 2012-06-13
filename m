From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH V2 03/10] ARM: OMAP4: Re-map the CTIs IRQs from MPU to DEBUGSS
Date: Tue, 12 Jun 2012 23:13:28 -0700
Message-ID: <CAFm5wm2h9X-ELks7adT=NmRzVkvWhQEkefuBSvVHS6+AvstLwA@mail.gmail.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-4-git-send-email-jon-hunter@ti.com> <CAFm5wm07QXCLA9SoFSqQP1NbdU0XynmyxKfjNJEMvziEAtphJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:52403 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752713Ab2FMGNu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 02:13:50 -0400
Received: by ggnc4 with SMTP id c4so143099ggn.31
        for <linux-omap@vger.kernel.org>; Tue, 12 Jun 2012 23:13:49 -0700 (PDT)
In-Reply-To: <CAFm5wm07QXCLA9SoFSqQP1NbdU0XynmyxKfjNJEMvziEAtphJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>

On Tue, Jun 12, 2012 at 11:07 PM, Pandita, Vikram <vikram.pandita@ti.co=
m> wrote:
> On Thu, Jun 7, 2012 at 2:22 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> In order to use the CTI interrupts inconjunction with the DEBUGSS we=
 need to
>> re-map the CTI IRQs to the DEBUGSS HWMOD. The purpose for doing this=
 is so we
>> can create a PMU device based upon the DEBUGSS HWMOD and use the CTI=
 interrupts
>> for routing ARM PMU events for OMAP4430 devices.
>>
>> This is based upon Benoit Cousson's patch [1].
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-Novem=
ber/073319.html
>>
>> Cc: Ming Lei <ming.lei@canonical.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A09 +++++++--
>> =A01 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 950454a..faf5a6d 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -482,10 +482,17 @@ static struct omap_hwmod_class omap44xx_debugs=
s_hwmod_class =3D {
>> =A0};
>>
>> =A0/* debugss */
>> +static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] =3D {
>> + =A0 =A0 =A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_STAR=
T },
>> + =A0 =A0 =A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_STAR=
T },
>
> Data manual assigns cit0 =3D=3D MA_IRQ_1 and cti1 =3D=3D MA_IRQ_2
> Why do you add 32 base GIC_START ?

Looks we do the same for pl310:
{ .name =3D "pl310", .irq =3D 0 + OMAP44XX_IRQ_GIC_START },

so u can ignore my comment .. excuse the noise...

>
>> + =A0 =A0 =A0 { .irq =3D -1 }
>> +};
>> +
>> =A0static struct omap_hwmod omap44xx_debugss_hwmod =3D {
>> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "debugss",
>> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_debugss_hwmod=
_class,
>> =A0 =A0 =A0 =A0.clkdm_name =A0 =A0 =3D "emu_sys_clkdm",
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_debugss_irqs,
>> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "trace_clk_div_ck",
>> =A0 =A0 =A0 =A0.prcm =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap4 =3D {
>> @@ -2447,8 +2454,6 @@ static struct omap_hwmod_class omap44xx_mpu_hw=
mod_class =3D {
>> =A0/* mpu */
>> =A0static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .name =3D "pl310", .irq =3D 0 + OMAP44XX_IRQ_GIC_ST=
ART },
>> - =A0 =A0 =A0 { .name =3D "cti0", .irq =3D 1 + OMAP44XX_IRQ_GIC_STAR=
T },
>> - =A0 =A0 =A0 { .name =3D "cti1", .irq =3D 2 + OMAP44XX_IRQ_GIC_STAR=
T },
>> =A0 =A0 =A0 =A0{ .irq =3D -1 }
>> =A0};
>>
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
