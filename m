From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Warnings: pm branch
Date: Wed, 30 Sep 2009 10:32:48 -0700
Message-ID: <636c5030909301032q4d39dd3ar7ee2fb522f009910@mail.gmail.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com>
	 <873a7y74mj.fsf@deeprootsystems.com>
	 <03d301ca1b32$14f97d10$LocalHost@wipultra793>
	 <7803.10.24.255.18.1250081698.squirrel@dbdmail.itg.ti.com>
	 <87d4712k4h.fsf@deeprootsystems.com>
	 <00a101ca1b58$4cdca100$LocalHost@wipultra793>
	 <87d47114ir.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f191.google.com ([209.85.222.191]:54808 "EHLO
	mail-pz0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZI3Rco convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 13:32:44 -0400
Received: by pzk29 with SMTP id 29so4589793pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 10:32:48 -0700 (PDT)
In-Reply-To: <87d47114ir.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

On Wed, Aug 12, 2009 at 7:38 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Hemanth V" <hemanthv@ti.com> writes:
>
>> ----- Original Message -----
>> From: "Kevin Hilman" <khilman@deeprootsystems.com>
>>>> =A0/* enter the state and update stats */
>>>> @@ -91,6 +93,12 @@ static void cpuidle_idle_call(void)
>>>> =A0/* give the governor an opportunity to reflect on the outcome *=
/
>>>> =A0if (cpuidle_curr_governor->reflect)
>>>> =A0cpuidle_curr_governor->reflect(dev);
>>>> +
>>>> + return;
>>>> +
>>>
>>> ... I think you want to drop this return. =A0If it returns here, it
>>> will still not enable IRQs. =A0I think it should just fall through
>>> to the enable and return.
>>
>> Since omap3_enter_idle returns with interrupts enabled, I had
>> added this return. We could remove it also for safety purposes.
>
> OK. =A0I think you should post to linux-pm for comment, and possibly
> raise this as a question.
>
> You can add:
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Hemanth,

I've reworked/simplified this patch slightly (see below) and will send
to linux-pm shortly.

Kevin


This one is against PM branch:

commit 808854375b94017ba996a467a082a38730fff434
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Wed Sep 30 09:57:40 2009 -0700

    CPUidle: always return with interrupts enabled

    In the case where cpuidle_idle_call() returns before changing state
    due to a need_resched(), it was returning with IRQs disabled.

    This patche ensures IRQs are (re)enabled before returning.

    Reported-by: Hemanth V <hemanthv@ti.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8504a21..910c49d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -75,8 +75,11 @@ static void cpuidle_idle_call(void)
 #endif
 	/* ask the governor for the next state */
 	next_state =3D cpuidle_curr_governor->select(dev);
-	if (need_resched())
+	if (need_resched()) {
+		local_irq_enable();
 		return;
+	}
+
 	target_state =3D &dev->states[next_state];

 	/* enter the state and update stats */
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
