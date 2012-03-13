From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in _set_gpio_dataout_*
Date: Tue, 13 Mar 2012 09:27:21 -0700
Message-ID: <8762e8v53q.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
	<87y5r5wkmu.fsf@ti.com>
	<CAC83ZvJ5rjNJoSZW=j=DXQWKWGgr_Wqu8ukOubxKd7xuEQ4pzQ@mail.gmail.com>
	<CAC83Zv+CZOGnSpOJgfCgEv-eyWXZzV+_mmd37CBMKM6iMtEksQ@mail.gmail.com>
	<CAC83ZvLmaLOr4_eZZzKyP2=KvkG+LjHjeOwvxdQHhuiB8+2L0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:41201 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754764Ab2CMQ1k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 12:27:40 -0400
Received: by mail-ey0-f175.google.com with SMTP id e1so385051eaa.20
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 09:27:12 -0700 (PDT)
In-Reply-To: <CAC83ZvLmaLOr4_eZZzKyP2=KvkG+LjHjeOwvxdQHhuiB8+2L0w@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 13 Mar 2012 12:22:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Tue, Mar 13, 2012 at 12:03 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Tue, Mar 13, 2012 at 11:33 AM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>>> On Tue, Mar 13, 2012 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>>
>>>>> In the existing _set_gpio_dataout_*() implementation, the dataout
>>>>> register is overwritten every time the function is called. This i=
s
>>>>> not intended behavior because that would end up one user of a GPI=
O
>>>>> line overwriting what is written by another. Fix this so that pre=
vious
>>>>> value is always preserved until explicitly changed by respective
>>>>> user/driver of the GPIO line.
>>>>>
>>>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>>> ---
>>>>> =C2=A0drivers/gpio/gpio-omap.c | =C2=A0 =C2=A03 +++
>>>>> =C2=A01 files changed, 3 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>>> index 04c2677..2e8e476 100644
>>>>> --- a/drivers/gpio/gpio-omap.c
>>>>> +++ b/drivers/gpio/gpio-omap.c
>>>>> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio=
_bank *bank, int gpio, int enable)
>>>>> =C2=A0 =C2=A0 =C2=A0 else
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg +=3D bank->r=
egs->clr_dataout;
>>>>>
>>>>> + =C2=A0 =C2=A0 l |=3D __raw_readl(bank->base + bank->regs->set_d=
ataout);
>>>>
>>>> minor: IMO, it's more reader-friendly if this looks like
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 l =3D __raw_read(...)
>>>> =C2=A0 =C2=A0 =C2=A0 l |=3D GPIO_BIT(...)
>>>> =C2=A0 =C2=A0 =C2=A0 __raw_write(...)
>>> Agreed. I will make the change.
>> Also, the read should be: __raw_readl(bank->base + bank->regs->datao=
ut);
>> instead of bank->regs->set_dataout.
> I see a problem with this implementation. It is not correct to write =
l
> |=3D GPIO_BIT(...).
> For example if we write to clr_dataout register we would end up
> clearing bits which
> we are not supposed to. We should just be operating on current GPIO_B=
IT(...).
> The l |=3D GPIO_BIT(...) is needed just to make sure that we have the
> right context
> stored. So the overall sequence should be something like this:
>
>         void __iomem *reg =3D bank->base;
>         u32 l =3D GPIO_BIT(bank, gpio);
>
>         if (enable)
>                 reg +=3D bank->regs->set_dataout;
>         else
>                 reg +=3D bank->regs->clr_dataout;
>
>         __raw_writel(l, reg);
>         l |=3D __raw_readl(bank->base + bank->regs->dataout);
>         bank->context.dataout =3D l;

Again, you don't need the extra read-back here.  Just set/clear the bit
in the context.  Untested patch below.

Kevin


diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0b05629..db905c0 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -111,10 +111,13 @@ static void _set_gpio_dataout_reg(struct gpio_ban=
k *bank, int gpio, int enable)
 	void __iomem *reg =3D bank->base;
 	u32 l =3D GPIO_BIT(bank, gpio);
=20
-	if (enable)
+	if (enable) {
 		reg +=3D bank->regs->set_dataout;
-	else
+		bank->context.dataout |=3D l;
+	} else {
 		reg +=3D bank->regs->clr_dataout;
+		bank->context.dataout &=3D ~l;
+	}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
