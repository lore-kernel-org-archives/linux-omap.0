From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Fri, 18 May 2012 10:18:29 +0530
Message-ID: <CAC83ZvKgHz00rP7JMkV5OP1_0w3S-ZDmGLR5CJOSgFpv78--+g@mail.gmail.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
	<1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
	<87y5oqtpnw.fsf@ti.com>
	<20120517231251.GH17852@atomide.com>
	<87mx56s6nz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:45815 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757381Ab2EREsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 00:48:31 -0400
Received: by qaea16 with SMTP id a16so2586518qae.10
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 21:48:30 -0700 (PDT)
In-Reply-To: <87mx56s6nz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, May 18, 2012 at 5:26 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
>
>> * Kevin Hilman <khilman@ti.com> [120517 15:29]:
>>>
>>> I just noticed that this patch has caused some strange problems, no=
tably
>>> with the GPIO IRQ used by smsc911x NIC (Overo, Zoom3, 2430SDP, etc.=
 etc.)
>>>
>>> The patch itself is OK, but it has exposed a bug in other parts of =
the
>>> context restore path that was previously hidden.
>>>
>>> We seem to have been finding lots of GPIO bugs by just testing the
>>> network chips with GPIO IRQs. =A0Can I suggest that a platform with=
 a GPIO
>>> IRQ NIC be added to the test platforms you're using?
>>
>> Yes considering the breakage it's pretty obvious the original series=
 was
>> never properly tested on omaps.
>
> Agreed.
>
>> Regarding this fix, using gpio/next + this patch fixes nfsroot for 2=
430sdp,
>> and gets zoom3 nfsroot booting going a bit better.
>>
>> However, at least on zoom3 nfsroot now takes several _minutes_ to ge=
t to
>> login: with gpio/next + this patch. The system is totally unusable.
>>
>> It seems that the GPIO interrupt wake-up events are not properly wor=
king
>> now?
>>
>> Reverting the "gpio/omap: fix missing check in *_runtime_suspend()"
>> patch seems to fix the issue.
>
> Argh, then $SUBJECT patch here has caused brokeness in multiple ways.
> It managed to break both runtime suspend and runtime resume at the sa=
me
> time. :(
>
> The change added by this patch to runtime_suspend effectively disable=
s
> the fix I did in 68942edb09 (gpio/omap: fix wakeups on level-triggere=
d GPIOs)
> causing the sluggish network problems to reappear, since that GPIO IR=
Q
> is no longer causing wakeups.
>
> Simple fix is below, which just moves the check added in $SUBJECT pat=
ch
> below the workaround for the edge/level fix. =A0Can you confirm it wo=
rks
> on Zoom3 (applies on gpio/next + my previous fix.)
>
> I didn't notice the same problem on Overo, but I guess it's because
> Overo had some enabled non-wakeup GPIOs in the same bank, so it didn'=
t
> bypass the level-triggered IRQ fix.
>
>>> Subject: [PATCH] gpio/omap: fix broken context restore for non-OFF =
mode
>>> =A0transitions
>>>
>>> The fix in commit 1b12870 (gpio/omap: fix missing check in
>>> *_runtime_suspend()) exposed another bug in the context restore pat=
h.
>>
>> Kevin, looks like commit 1b12870 does not exist in gpio/next?
>
> Will update the changelog.
>
> Because of this new problem, I have to add the patch below too, so
> I'll get them both queued up for Grant
>
> In the mean time, they're availble in my for_3.5/fixes/gpio-2 branch.
>
> Kevin
>
> [1]
> From afb4f0836dc3c432aa999fc98a80bf75e1481e04 Mon Sep 17 00:00:00 200=
1
> From: Kevin Hilman <khilman@ti.com>
> Date: Thu, 17 May 2012 16:42:16 -0700
> Subject: [PATCH] gpio/omap: (re)fix wakeups on level-triggered GPIOs
>
> commit 1b1287032 (gpio/omap: fix missing check in *_runtime_suspend()=
)
> broke wakeups on level-triggered GPIOs by adding the enabled
> non-wakeup GPIO check before the workaround that enables wakeups
> on level-triggered IRQs, effectively disabling that workaround.
>
> To fix, move the enabled non-wakeup GPIO check after the
> level-triggered IRQ workaround.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

> ---
> =A0drivers/gpio/gpio-omap.c | =A0 =A06 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b570a6a..c4ed172 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1157,9 +1157,6 @@ static int omap_gpio_runtime_suspend(struct dev=
ice *dev)
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&bank->lock, flags);
>
> - =A0 =A0 =A0 if (!bank->enabled_non_wakeup_gpios)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto update_gpio_context_count;
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Only edges can generate a wakeup event to the PRCM.
> =A0 =A0 =A0 =A0 *
> @@ -1180,6 +1177,9 @@ static int omap_gpio_runtime_suspend(struct dev=
ice *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_writel(wake_hi | bank->context.r=
isingdetect,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->base + =
bank->regs->risingdetect);
>
> + =A0 =A0 =A0 if (!bank->enabled_non_wakeup_gpios)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto update_gpio_context_count;
> +
> =A0 =A0 =A0 =A0if (bank->power_mode !=3D OFF_MODE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->power_mode =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto update_gpio_context_count;
> --
> 1.7.9.2
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
