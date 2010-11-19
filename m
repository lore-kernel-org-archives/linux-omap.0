From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Thu, 18 Nov 2010 18:07:40 -0600
Message-ID: <AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46000 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758990Ab0KSAHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 19:07:50 -0500
Received: by mail-qw0-f50.google.com with SMTP id 5so330335qwg.23
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 16:07:40 -0800 (PST)
In-Reply-To: <4CE5B68F.8000502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Benoit,

On Thu, Nov 18, 2010 at 5:28 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 11/18/2010 8:15 PM, Hari Kanigeri wrote:
>>
>> disabling rx interrupt on omap4 is different than its pre-decessors.
>> The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
>> interrupts instead of clearing the bit.
>>
>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/mailbox.c | =A0 =A05 ++++-
>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mai=
lbox.c
>> index 42dbfa4..82b5ced 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -195,7 +195,10 @@ static void omap2_mbox_disable_irq(struct omap_=
mbox
>> *mbox,
>> =A0 =A0 =A0 =A0struct omap_mbox2_priv *p =3D (struct omap_mbox2_priv=
 *)mbox->priv;
>> =A0 =A0 =A0 =A0u32 l, bit =3D (irq =3D=3D IRQ_TX) ? p->notfull_bit :=
 p->newmsg_bit;
>> =A0 =A0 =A0 =A0l =3D mbox_read_reg(p->irqdisable);
>> - =A0 =A0 =A0 l&=3D ~bit;
>> + =A0 =A0 =A0 if (cpu_is_omap44xx())
>
> Since it is not omap version specific but IP version specific, you sh=
ould
> not use cpu_is_ to do that. Moreover cpu_is calls should be used duri=
ng init
> only.
> You can use the rev field in hwmod_class in order to detect the IP ve=
rsion.
> Smartreflex series for 3630 is already using that kind of mechanism.
> You will have to copy that revision information into pdata struct and=
 then
> use that here.

I see your point, but since mailbox hwmod patches from Omar are still
under review I didn't find any other option than to enable this
This is critical functionality that I want to include in and not wait
till the hwmod patches are accepted.
Please let me know if there is any other way of approaching this proble=
m ?

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
