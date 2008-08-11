From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Mon, 11 Aug 2008 14:18:28 +0300
Message-ID: <87r68ver5n.fsf@trdhcp146196.ntc.nokia.com>
References: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
	<alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34848 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbYHKKYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 06:24:23 -0400
In-Reply-To: <alpine.DEB.1.00.0808110231270.10219@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Mon, 11 Aug 2008 02:34:37 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com

"ext Paul Walmsley" <paul@booyaka.com> writes:

> Hello Jouni,
>
> a couple of questions about these patches....
>
> On Tue, 8 Jul 2008, Jouni Hogander wrote:
>
>> With this patch cpuidle boot problem with cpuidle doesn't exist. Als=
o hang on wake-up seems to
>> disappear (haven't seen this far).
>>=20
>> Main points in this patch are:
>> 1. Add wkdep between neon and mpu
>> 2. Add wkdep between per and core
>
> Could you explain a little further why PER would have a wakeup depend=
ency=20
> on CORE?  Is this something that we should only enable under certain=20
> conditions, e.g., latency requirements for a device in PER?

This is done to make sure we don't loose any gpio interrupts: GPIO
wakeup/interrupt doesn't work for GPIOs in PER domain if PER is not
active.

>
>> 3. Deny hwsup mode before writing next pwrst state
>
> I missed this part of the patch - could you point me at that
> section?

Patch changes code to use set_pwrdm_state from pm34xx.c instead of
pwrdm_set_next_pwrst from powerdomain code. That function contains
denying hwsup mode.

>
>
> regards,
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
