From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 4/6] gpio/omap: get rid of retrigger variable in gpio_irq_handler
Date: Tue, 28 Feb 2012 10:41:47 +0530
Message-ID: <CAC83Zv+qGD-60=hmd=7rgxqSiw2yHe78C6TyO1pj+qe3UPtcEQ@mail.gmail.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
	<1329999031-6914-5-git-send-email-tarun.kanti@ti.com>
	<87linnu8o8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87linnu8o8.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 28, 2012 at 5:32 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> This local variable is just assigned zero and then OR'ed
>> with isr. It does not appear to serve any purpose and so
>> removing it.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> Looks like the use of this was removed when I moved things over to us=
ing
> the generic IRQ framework, but I didn't fully clean up.
>
> Can you update the changelog to something along the lines of:
>
> "commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic I=
RQ
> framework) removed retrigger support in favor of using generic IRQ
> framework. =A0This patch cleans up some unused remnants of that remov=
al.
Yes, sure.
--
Tarun
>
> Thanks,
>
> Kevin
>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A03 ---
>> =A01 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index b62e861..3dd4b3a 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -623,7 +623,6 @@ static void gpio_irq_handler(unsigned int irq, s=
truct irq_desc *desc)
>> =A0 =A0 =A0 u32 isr;
>> =A0 =A0 =A0 unsigned int gpio_irq, gpio_index;
>> =A0 =A0 =A0 struct gpio_bank *bank;
>> - =A0 =A0 u32 retrigger =3D 0;
>> =A0 =A0 =A0 int unmasked =3D 0;
>> =A0 =A0 =A0 struct irq_chip *chip =3D irq_desc_get_chip(desc);
>>
>> @@ -660,8 +659,6 @@ static void gpio_irq_handler(unsigned int irq, s=
truct irq_desc *desc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chained_irq_exit(chip, d=
esc);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 isr |=3D retrigger;
>> - =A0 =A0 =A0 =A0 =A0 =A0 retrigger =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!isr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
