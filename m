From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 24/24] gpio/omap: handle set_dataout reg capable IP on restore
Date: Thu, 24 Nov 2011 11:01:01 +0530
Message-ID: <CAC83ZvLCBFVBrZTeebK-53b-UjKXYo5F-yqC7zcDQn+3uHcwkQ@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<1317803593-12259-25-git-send-email-tarun.kanti@ti.com>
	<87aa8bde2d.fsf@ti.com>
	<CAC83Zv+gac_Wd8+V+o6USxv73ia5i8JLjLDHj8VQiRiqZ7DOtQ@mail.gmail.com>
	<CAC83ZvL9w=7RhAuT=5ahbDX+d6miQMif1ngOenEiqP4UN2+mzg@mail.gmail.com>
	<87zkfmaa3c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60290 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735Ab1KXFbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 00:31:03 -0500
Received: by mail-qw0-f48.google.com with SMTP id y1so977861qad.0
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 21:31:01 -0800 (PST)
In-Reply-To: <87zkfmaa3c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Nov 24, 2011 at 1:24 AM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Mon, Nov 7, 2011 at 5:35 PM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>>> On Fri, Nov 4, 2011 at 10:23 PM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>>
>>>>> From: Nishanth Menon <nm@ti.com>
>>>>>
>>>>> GPIO IP revisions such as those used in OMAP4 have a set_dataout
>>>>> while the previous revisions used a single dataout register.
>>>>> Depending on what is available restore the dataout settings
>>>>> to the right register.
>>>>>
>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>> ---
>>>>> =A0drivers/gpio/gpio-omap.c | =A0 =A09 +++++++--
>>>>> =A01 files changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>>> index 4009446..3df7a98 100644
>>>>> --- a/drivers/gpio/gpio-omap.c
>>>>> +++ b/drivers/gpio/gpio-omap.c
>>>>> @@ -1073,7 +1073,7 @@ static int __devinit omap_gpio_probe(struct=
 platform_device *pdev)
>>>>> =A0 =A0 =A0 bank->get_context_loss_count =3D pdata->get_context_l=
oss_count;
>>>>> =A0 =A0 =A0 bank->regs =3D pdata->regs;
>>>>>
>>>>> - =A0 =A0 if (bank->regs->set_dataout && bank->regs->clr_dataout)
>>>>> + =A0 =A0 if (bank->regs->set_dataout)
>>>>
>>>> This change isn't right.
>>>>
>>>> The _set_gpio_dataout_reg function depends on the existence of
>>>> ->clr_dataout too.
>>> Ok, I will add the clr_dataout condtion as well.
>>
>>>
>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->set_dataout =3D _set_gpio_datao=
ut_reg;
>>>>> =A0 =A0 =A0 else
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->set_dataout =3D _set_gpio_datao=
ut_mask;
>>>>> @@ -1351,7 +1351,12 @@ static void omap_gpio_restore_context(stru=
ct gpio_bank *bank)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-=
>base + bank->regs->risingdetect);
>>>>> =A0 =A0 =A0 __raw_writel(bank->context.fallingdetect,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-=
>base + bank->regs->fallingdetect);
>>>>> - =A0 =A0 __raw_writel(bank->context.dataout, bank->base + bank->=
regs->dataout);
>>>>> + =A0 =A0 if (bank->regs->set_dataout)
>>>>
>>>> Why the check again? =A0The check has already been done in probe.
>>>>
>>>> Just use bank->set_dataout() here.
>>> Sure, i will make the change.
>>
>> When I look at the signature of set_dataout(), it does not seem
>> straight forward to be used here. It expects (struct gpio_bank *bank=
,
>> int gpio, int enable) to be passed to it.
>
> IOW, it expects to only set 1 bit, where the context restore needs to
> set the value for the whole register.
>
> OK, then keep the original version, but make sure the if statement
> matches is checking for ->set_dataout and ->clr_dataout like the othe=
r one.
Right. I have done that.
--
Tarun
>
> Kevin
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
