From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Fri, 18 May 2012 10:42:48 +0530
Message-ID: <CAC83ZvLr1rPZs1JBdxyLyLJAkvGT3ZQgLJbPdsP5Grha8CMS_g@mail.gmail.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
	<1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
	<87y5oqtpnw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47861 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758058Ab2ERFMu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 01:12:50 -0400
Received: by qcmv28 with SMTP id v28so2151384qcm.11
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 22:12:49 -0700 (PDT)
In-Reply-To: <87y5oqtpnw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Fri, May 18, 2012 at 3:51 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun, Santosh,
>
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> We do checking for bank->enabled_non_wakeup_gpios in order
>> to skip redundant operations. Somehow, the check got missed
>> while doing the cleanup series.
>>
>> Just to make sure that we do context restore correctly in
>> *_runtime_resume(), the bank->workaround_enabled check is
>> moved after context restore. Otherwise, it would prevent
>> context restore when bank->enabled_non_wakeup_gpios is 0.
>>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> I just noticed that this patch has caused some strange problems, nota=
bly
> with the GPIO IRQ used by smsc911x NIC (Overo, Zoom3, 2430SDP, etc. e=
tc.)
>
> The patch itself is OK, but it has exposed a bug in other parts of th=
e
> context restore path that was previously hidden.
>
> We seem to have been finding lots of GPIO bugs by just testing the
> network chips with GPIO IRQs. =A0Can I suggest that a platform with a=
 GPIO
> IRQ NIC be added to the test platforms you're using?
>
>> ---
>> =A0drivers/gpio/gpio-omap.c | =A0 13 ++++++++-----
>> =A01 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index d238f84..59a4af1 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1160,6 +1160,9 @@ static int omap_gpio_runtime_suspend(struct de=
vice *dev)
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&bank->lock, flags);
>>
>> + =A0 =A0 if (!bank->enabled_non_wakeup_gpios)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto update_gpio_context_count;
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Only edges can generate a wakeup event to the PRCM.
>> =A0 =A0 =A0 =A0*
>> @@ -1235,11 +1238,6 @@ static int omap_gpio_runtime_resume(struct de=
vice *dev)
>> =A0 =A0 =A0 __raw_writel(bank->context.risingdetect,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->base + bank->regs->risi=
ngdetect);
>>
>> - =A0 =A0 if (!bank->workaround_enabled) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&bank->lock, flags)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 }
>> -
>
> My moving this below, you exposed some buggy code that can now get
> executed in non-OFF mode, wherease before $SUBJECT patch, it would ne=
ver
> be exectued in non-OFF mode.
>
>> =A0 =A0 =A0 if (bank->get_context_loss_count) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_lost_cnt_after =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->get_context_loss_c=
ount(bank->dev);
>
> ...right below this line, we have:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (context_lost_cnt_after !=3D bank->=
context_loss_count ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0!context_lost_cnt_after) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_gpio_restore_cont=
ext(bank);
>
> While we've never hit off-mode, context_lost_cnt_after will always be
> zero. =A0However, becasue of the !context_lost_cnt_after check there,=
 we
> will *always* restore the bank context, even though context has never
> been lost.
>
> I have no idea why that !context_lost_cnt_after check is there, but
> clearly it is wrong. =A0Now that you moved the 'workraound_enabled' c=
heck
> below this section, as long as off-mode is disabled, the some GPIO
> context will be restored here on *every* runtime PM transition.
>
> The patch below fixes the problem.
>
> Grant, after Tarun/Santosh have a chance to review/ack this, can you
> still get this in for 3.5? =A0If not, getting it into -rc should be f=
ine.
>
> Kevin
>
>
> From 83874df8e0dd78a3609f5ba81d608df7217fd212 Mon Sep 17 00:00:00 200=
1
> From: Kevin Hilman <khilman@ti.com>
> Date: Thu, 17 May 2012 14:52:56 -0700
> Subject: [PATCH] gpio/omap: fix broken context restore for non-OFF mo=
de
> =A0transitions
>
> The fix in commit 1b12870 (gpio/omap: fix missing check in
> *_runtime_suspend()) exposed another bug in the context restore path.
>
> Currently, the per-bank context restore happens whenever the context
> loss count is different in runtime suspend and runtime resume *and*
> whenever the per-bank contex_loss_count =3D=3D 0:
>
> =A0 =A0 =A0 =A0if (context_lost_cnt_after !=3D bank->context_loss_cou=
nt ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0!context_lost_cnt_after) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_gpio_restore_context(bank);
>
> Restoring context when the context_lost_cnt_after =3D=3D 0 is clearly
> wrong, since this will be true until the first off-mode transition
> (which could be never, if off-mode is never enabled.) =A0This check
> causes the context to be restored on *every* runtime PM transition.
>
> Before commit 1b12870 (gpio/omap: fix missing check in
> *_runtime_suspend()), this code was never executed in non-OFF mode, s=
o
> there were never spurious context restores happening. =A0After that
> change though, spurious context restores could happen.
>
> To fix, simply remove the !context_lost_cnt_after check. It is not
> needed.
>
> This bug was found when noticing that the smc911x NIC on 3530/Overo
> was not working, and git bisect tracked it down to this patch. =A0It
> seems that the spurious context restore was causing the smsc911x to
> not be properly probed on this platform.
>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

> ---
> =A0drivers/gpio/gpio-omap.c | =A0 =A03 +--
> =A01 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 9b71f04..b570a6a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1238,8 +1238,7 @@ static int omap_gpio_runtime_resume(struct devi=
ce *dev)
> =A0 =A0 =A0 =A0if (bank->get_context_loss_count) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0context_lost_cnt_after =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank->get_context_loss=
_count(bank->dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (context_lost_cnt_after !=3D bank->c=
ontext_loss_count ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 !context_lost_cnt_after) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (context_lost_cnt_after !=3D bank->c=
ontext_loss_count) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_gpio_restore_cont=
ext(bank);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore=
(&bank->lock, flags);
> --
> 1.7.9.2
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
