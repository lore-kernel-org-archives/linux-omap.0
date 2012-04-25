From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v9 11/25] gpio/omap: cleanup omap_gpio_mod_init function
Date: Wed, 25 Apr 2012 10:04:42 +0530
Message-ID: <CAC83Zv+CCLQfZHfqMcbof6JtA-hOK1PfX5Gs0BBVQhBAiWzX_g@mail.gmail.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
	<1328203851-20435-12-git-send-email-tarun.kanti@ti.com>
	<13629551.hP3ZV1ajDo@vclass>
	<CAC83ZvK630=6B-k2TfV3XBg8w7ZosLVDNE4ezjDYnn=hcXA48Q@mail.gmail.com>
	<CAC83ZvJDDvCu8NKTOYh75USA3fvSAKEGaXXi9PtCM955K_keSA@mail.gmail.com>
	<20120424160447.GI3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:51720 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab2DYEeo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 00:34:44 -0400
Received: by qaeb19 with SMTP id b19so3547781qae.4
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 21:34:43 -0700 (PDT)
In-Reply-To: <20120424160447.GI3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, khilman@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Tue, Apr 24, 2012 at 9:34 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120424 08:40]:
>> Hi Janusz,
>>
>> On Tue, Apr 24, 2012 at 12:24 AM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>> > On Sat, Apr 21, 2012 at 7:33 PM, Janusz Krzysztofik
>> > <jkrzyszt@tis.icnet.pl> wrote:
>> >> On Thursday 02 of February 2012 23:00:37 Tarun Kanti DebBarma wro=
te:
>> >>> With register offsets now defined for respective OMAP versions w=
e can get rid
>> >>> of cpu_class_* checks. This function now has common initializati=
on code for
>> >>> all OMAP versions...
>> >>>
>> >>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> >>> Signed-off-by: Charulatha V <charu@ti.com>
>> >>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >>> Acked-by: Tony Lindgren <tony@atomide.com>
>> >>
>> >> Sorry for being so late with my comment for chanes already presen=
t in
>> >> mainline, but this patch breaks GPIO on Amstrad Delta at least, a=
nd I
>> >> have neither enough spare time nor enough experience with non OMA=
P1
>> >> machines to provide a solution myself.
>> > Yes, I looked at the omap_gpio_mod_init() and OMAP1 configurations=
 are
>> > overwritten.
>> > Also looks like there is issue in making distinction between omap1=
5xx
>> > and omap16xx.
>> > I will post a patch and you can help me testing it in OMAP1 platfo=
rm.
>> > Thanks for pointing this out.
> ...
>
>> Here is the patch, with attachment as well. I have just tested on
>> OMAP4 platform.
>> Testing on other OMAP2+ platforms is pending. In the meantime can yo=
u please
>> validate on OMAP1 platform and confirm? Thanks.
>> --
>> Tarun
>>
>> From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Date: Tue, 24 Apr 2012 20:34:32 +0530
>> Subject: [PATCH] gpio/omap: fix omap1 register overwrite in omap_gpi=
o_mod_init
>>
>> Initialization of irqenable, irqstatus registers is the common
>> operation done in this function for all OMAP platforms, viz.
>> OMAP1, OMAP2+. The latter _gpio_rmw()'s to irqenable register
>> was overwriting the correctly programmed OMAP1 value at the
>> beginning. As a result, even though it worked on OMAP2+
>> platforms it was breaking OMAP1 functionality.
>
> Sounds like the original patch was never tested on omap1?
That's right, only bootup test was done on OMAP1710-SDP.

>
>> On closer observation it is found that the first _gpio_rmw()
>> which is supposedly done to take care of OMAP1 platform is
>> generic enough and takes care of OMAP2+ platform as well.
>> Therefore remove the latter _gpio_rmw() to irqenable as they
>> are redundant.
>>
>> Also, changing the sequence and logic of initializing the
>> irqstatus.
>
> Please mention also the breaking commit here and get this fix
> merged as a regression as soon as it's tested for the current
> -rc series.
Sure, I will do that!
--
Tarun
>
> Regards,
>
> Tony
>
>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 =A05 +----
>> =A01 files changed, 1 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 1adc2ec..b8f01c1 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -964,11 +964,8 @@ static void omap_gpio_mod_init(struct gpio_bank=
 *bank)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 =A0 }
>>
>> + =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l,
>> bank->regs->irqenable_inv =3D=3D 0 );
>> =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs=
->irqenable_inv);
>> - =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqstatus, l,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bank->regs->irqenable_inv =3D=3D false);
>> - =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->=
debounce_en !=3D 0);
>> - =A0 =A0 =A0 _gpio_rmw(base, bank->regs->irqenable, l, bank->regs->=
ctrl !=3D 0);
>> =A0 =A0 =A0 =A0 if (bank->regs->debounce_en)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _gpio_rmw(base, bank->regs->debounce=
_en, 0, 1);
>>
>> --
>> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
