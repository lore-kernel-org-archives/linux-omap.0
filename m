From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] gpio/omap: fix wakeups on level-triggered GPIOs
Date: Wed, 22 Feb 2012 13:40:05 -0800
Message-ID: <87aa4azgwa.fsf@ti.com>
References: <1329850878-22189-1-git-send-email-khilman@ti.com>
	<CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:55044 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043Ab2BVVjz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 16:39:55 -0500
Received: by mail-pz0-f50.google.com with SMTP id d2so444881dal.9
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 13:39:54 -0800 (PST)
In-Reply-To: <CAC83ZvKXSwSsU_hu7hrPV6DmVYv=G3iF7Wb5hF_qhSiL+BpfaQ@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Wed, 22 Feb 2012 22:47:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tarun,

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Wed, Feb 22, 2012 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> While both level- and edge-triggered GPIOs are capable of generating
>> interrupts, only edge-triggered GPIOs are capable of generating a
>> module-level wakeup to the PRCM (c.f. 34xx NDA TRM section 25.5.3.2.=
)
>>
>> In order to ensure that devices using level-triggered GPIOs as
>> interrupts can also cause wakeups (e.g. from idle), this patch enabl=
es
>> edge-triggering for wakeup-enabled, level-triggered GPIOs when a GPI=
O
>> bank is runtime-suspended (which also happens during idle.)
>>
>> This fixes a problem found in GPMC-connected network cards with GPIO
>> interrupts (e.g. smsc911x on Zoom3, Overo, ...) where network bootin=
g
>> with NFSroot was very slow since the GPIO IRQs used by the NIC were
>> not generating PRCM wakeups, and thus not waking the system from idl=
e.
>> NOTE: until v3.3, this boot-time problem was somewhat masked because
>> the UART init prevented WFI during boot until the full serial driver
>> was available. =C2=A0Preventing WFI allowed regular GPIO interrupts =
to fire
>> and this problem was not seen. =C2=A0After the UART runtime PM clean=
ups, we
>> no longer avoid WFI during boot, so GPIO IRQs that were not causing
>> wakeups resulted in very slow IRQ response times.
>>
>> Tested on platforms using level-triggered GPIOs for network IRQs usi=
ng
>> the SMSC911x NIC: 3530/Overo and 3630/Zoom3.
>>
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> I have tested on OMAP3430 by making modification to touchscreen GPIO.
> (I had similar change in my next planned cleanup/fix series.)
> If needed you can add my Tested-by:

Thanks for testing, I'll add a Tested-by from you and Tony before
submitting to Grant.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
