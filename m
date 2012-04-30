From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Mon, 30 Apr 2012 10:32:54 +0530
Message-ID: <CAC83Zv++LFbUiFP6UtbqZheL=OMSSskjfcHVj8USMSbf3yk4yg@mail.gmail.com>
References: <1335515951-6907-1-git-send-email-tarun.kanti@ti.com>
	<87k410yg2q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:59500 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755217Ab2D3FC4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 01:02:56 -0400
Received: by qaea16 with SMTP id a16so1260400qae.10
        for <linux-omap@vger.kernel.org>; Sun, 29 Apr 2012 22:02:55 -0700 (PDT)
In-Reply-To: <87k410yg2q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Sat, Apr 28, 2012 at 3:48 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Breaking commit: ab985f0f7c2c0ef90b7c832f0c04f470dda0593d
>>
>> Initialization of irqenable, irqstatus registers is the common
>> operation done in this function for all OMAP platforms, viz.
>> OMAP1, OMAP2+. The latter _gpio_rmw()'s to irqenable register
>> was overwriting the correctly programmed OMAP1 value at the
>> beginning. As a result, even though it worked on OMAP2+
>> platforms it was breaking OMAP1 functionality. On close
>> observation it is found that the first _gpio_rmw() which is
>> supposedly done to take care of OMAP1 platform is generic enough
>> and takes care of OMAP2+ platform as well. Therefore remove the
>> latter _gpio_rmw() to irqenable as they are redundant now.
>>
>> Writing to ctrl and debounce_en registers for OMAP2+ platforms
>> are modified to match the original(pre-cleanup) code where the
>> registers are initialized with 0. In the cleanup series since
>> we are using _gpio_rmw(reg, 0, 1), instead of __raw_writel(),
>> we are just reading and writing the same values to ctrl and
>> debounce_en. This is not an issue for debounce_en register
>> because it has 0x0 as the default value. But in the case of
>> ctrl register the default value is 0x2 (GATINGRATIO =3D 0x1)
>> so that we end up writing 0x2 instead of intended 0 value.
>> Therefore correcting it to _gpio_rmw(reg, l, 0), where
>> l =3D 0xffffffff so that registers are initialized to 0.
>>
>> Also, changing the sequence and logic of initializing the irqstatus.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> Tested on OMAP2+ platforms and bootup test on OMAP1710.
>> Janusz,
>> Please help me in validating the patch on OMAP1 platform.
>>
>> =A0drivers/gpio/gpio-omap.c | =A0 =A09 +++------
>> =A01 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 1adc2ec..910fd14 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -964,19 +964,16 @@ static void omap_gpio_mod_init(struct gpio_ban=
k *bank)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l, !bank->regs->irq=
enable_inv);
>> =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ir=
qenable_inv);
>> - =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bank->regs->irqenable_inv =3D=3D false);
>
> Not sure I follow this change. =A0It seems the ending value in irqsta=
tus
> will be the same, but it was just moved before irqenable.
Yes, it is just moved before irqenable and instead of:
bank->regs->irqenable_inv =3D=3D false, I made it !bank->regs->irqenabl=
e_inv
so that it fits in single line and avoid comparison with bool.

>
> You mention changing this order in the changelog, but do not mention =
why.
If we consider the overall code sequence it was something like:

_gpio_rmw(base, bank->regs->irqenable, l, <condition1>);
_gpio_rmw(base, bank->regs->irqstatus, l, <condition2>);
_gpio_rmw(base, bank->regs->irqenable, l, <condition3>);
_gpio_rmw(base, bank->regs->irqenable, l, <condition4>);

So I decided to move irqstatus first (beside the changing the logic
mentioned above)
and keep all irqenable settings together. However, with just single
irqenable setting
now this does not make any difference. In short, I can just change the
logic while
keeping it in place.

>
>> - =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debo=
unce_en !=3D 0);
>> - =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl=
 !=3D 0);
>
> Why were these here in the first place?
These we supposedly introduced wrongly to take care of OMAP2+ platforms=
=2E
Also, I somehow made incorrect assumption that each _gpio_rmw()'s were
mutually exclusive. In fact this is what led to overwrite of initial
OMAP1 setting.

>
> The changelog is not very clear about *why* these can be removed.
I can update changelog with what I have just said above.

>
>> =A0 =A0 =A0 if (bank->regs->debounce_en)
>> - =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->debounce_en, 0=
, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->debounce_en, l=
, 0);
>
> Why the read/modify/write? =A0Why not just go back to the __raw_write=
?
We can use __raw_writel() as before.

>
>> =A0 =A0 =A0 /* Save OE default value (0xffffffff) in the context */
>> =A0 =A0 =A0 bank->context.oe =3D __raw_readl(bank->base + bank->regs=
->direction);
>> =A0 =A0 =A0 =A0/* Initialize interface clk ungated, module enabled *=
/
>> =A0 =A0 =A0 if (bank->regs->ctrl)
>> - =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->ctrl, 0, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->ctrl, l, 0);
>
> same question.
Yes, here also we can use the __raw_writel().
--
Tarun
>
>> =A0}
>>
>> =A0static __devinit void
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
