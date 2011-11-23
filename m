From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 24/24] gpio/omap: handle set_dataout reg capable IP on restore
Date: Wed, 23 Nov 2011 11:54:15 -0800
Message-ID: <87zkfmaa3c.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<1317803593-12259-25-git-send-email-tarun.kanti@ti.com>
	<87aa8bde2d.fsf@ti.com>
	<CAC83Zv+gac_Wd8+V+o6USxv73ia5i8JLjLDHj8VQiRiqZ7DOtQ@mail.gmail.com>
	<CAC83ZvL9w=7RhAuT=5ahbDX+d6miQMif1ngOenEiqP4UN2+mzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:49143 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996Ab1KWTyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 14:54:21 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so2036274iag.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 11:54:20 -0800 (PST)
In-Reply-To: <CAC83ZvL9w=7RhAuT=5ahbDX+d6miQMif1ngOenEiqP4UN2+mzg@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Wed, 23 Nov 2011 18:01:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Mon, Nov 7, 2011 at 5:35 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Fri, Nov 4, 2011 at 10:23 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> GPIO IP revisions such as those used in OMAP4 have a set_dataout
>>>> while the previous revisions used a single dataout register.
>>>> Depending on what is available restore the dataout settings
>>>> to the right register.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>> =C2=A0drivers/gpio/gpio-omap.c | =C2=A0 =C2=A09 +++++++--
>>>> =C2=A01 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>> index 4009446..3df7a98 100644
>>>> --- a/drivers/gpio/gpio-omap.c
>>>> +++ b/drivers/gpio/gpio-omap.c
>>>> @@ -1073,7 +1073,7 @@ static int __devinit omap_gpio_probe(struct =
platform_device *pdev)
>>>> =C2=A0 =C2=A0 =C2=A0 bank->get_context_loss_count =3D pdata->get_c=
ontext_loss_count;
>>>> =C2=A0 =C2=A0 =C2=A0 bank->regs =3D pdata->regs;
>>>>
>>>> - =C2=A0 =C2=A0 if (bank->regs->set_dataout && bank->regs->clr_dat=
aout)
>>>> + =C2=A0 =C2=A0 if (bank->regs->set_dataout)
>>>
>>> This change isn't right.
>>>
>>> The _set_gpio_dataout_reg function depends on the existence of
>>> ->clr_dataout too.
>> Ok, I will add the clr_dataout condtion as well.
>
>>
>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->set_dataout=
 =3D _set_gpio_dataout_reg;
>>>> =C2=A0 =C2=A0 =C2=A0 else
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->set_dataout=
 =3D _set_gpio_dataout_mask;
>>>> @@ -1351,7 +1351,12 @@ static void omap_gpio_restore_context(struc=
t gpio_bank *bank)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->base + bank->regs->risingd=
etect);
>>>> =C2=A0 =C2=A0 =C2=A0 __raw_writel(bank->context.fallingdetect,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->base + bank->regs->falling=
detect);
>>>> - =C2=A0 =C2=A0 __raw_writel(bank->context.dataout, bank->base + b=
ank->regs->dataout);
>>>> + =C2=A0 =C2=A0 if (bank->regs->set_dataout)
>>>
>>> Why the check again? =C2=A0The check has already been done in probe=
=2E
>>>
>>> Just use bank->set_dataout() here.
>> Sure, i will make the change.
>
> When I look at the signature of set_dataout(), it does not seem
> straight forward to be used here. It expects (struct gpio_bank *bank,
> int gpio, int enable) to be passed to it.

IOW, it expects to only set 1 bit, where the context restore needs to
set the value for the whole register.

OK, then keep the original version, but make sure the if statement
matches is checking for ->set_dataout and ->clr_dataout like the other =
one.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
