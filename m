From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v7 14/26] gpio/omap: remove unnecessary bit-masking for
 read access
Date: Wed, 14 Sep 2011 18:38:29 +0530
Message-ID: <CAC83Zv+1qT8uL5Jc+=RA61FT=GCOKbfogpqu3xNWM9Xfp0Kk7w@mail.gmail.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-15-git-send-email-tarun.kanti@ti.com>
	<4E708DCA.3090606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38489 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932406Ab1INNIa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 09:08:30 -0400
Received: by mail-bw0-f48.google.com with SMTP id zu5so2558371bkb.21
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 06:08:29 -0700 (PDT)
In-Reply-To: <4E708DCA.3090606@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Wed, Sep 14, 2011 at 4:49 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 13-09-2011 17:02, Tarun Kanti DebBarma wrote:
>
>> Remove un-necessary bit masking. Since the register are 4 byte align=
ed
>> and readl would work as is. The 'enabled' mask is already taking car=
e
>> to mask for bank width.
>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A02 --
>> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 876e387..d614c6d 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -571,8 +571,6 @@ static void gpio_irq_handler(unsigned int irq, s=
truct
>> irq_desc *desc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enabled =3D _get_gpio_irqbank_mask(ba=
nk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0isr_saved =3D isr =3D __raw_readl(isr=
_reg)& =A0enabled;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap15xx()&& =A0(bank->meth=
od =3D=3D METHOD_MPUIO))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr&=3D 0x0000ffff;
>>
>
> =A0 Should have removed the now unneeded empty line too.
Sure... I will remove.
--
Tarun
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bank->level_mask)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0level_mask =3D bank->=
level_mask& =A0enabled;
>
> WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
