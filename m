From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
Date: Wed, 21 Mar 2012 14:28:52 +0100
Message-ID: <CAORVsuUtQ3EYdrBMUkFm=nd-avz0q9D1BVmwKD-06qgaF3wDqA@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
	<1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
	<CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
	<4F69A37A.7020606@linaro.org>
	<4F69A762.5070006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49622 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758165Ab2CUN2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 09:28:53 -0400
Received: by vcqp1 with SMTP id p1so1003732vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 06:28:52 -0700 (PDT)
In-Reply-To: <4F69A762.5070006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 21, 2012 at 11:03 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 21 March 2012 03:16 PM, Daniel Lezcano wrote:
>> On 03/21/2012 10:41 AM, Shilimkar, Santosh wrote:
>>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> =A0wrote:
>>>> The 'valid' field is never used in the code, let's remove it.
>>>>
>>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>>> ---
>>> It is used during the registration. This field has been very useful=
 for
>>> debug when need to disable a C-state etc.
>>> So unless and until there is a strong reason, i would like to retai=
n it.
>>
>> IMO if it used for debug purpose, it should be moved to the debug co=
de
>> and if the debug code is not upstream, then that 'valid' should not =
be
>> here but in the out-of-tree code.
>>
> When I said debug, I mean CPUIDLE debug and not any special debug cod=
e.
>
>> By the way, this may be a debate for nothing because a patchset is o=
n
>> the way to disable C-states from sysfs.
>>
> I see but sysfs won't solve that because you want to disable certain
> C-state so that CPUIDLE driver don't use that state.
This will solve the problem, the only difference is that you need the
user space to switch the disable knob from sysfs.
=46rom the kernel space, for debug, you can set the .disable value to 1
in the cpuidle_driver->states struct.

>
> Let say if the C4 which is OSWR is broken. In such cases, just
> setting valid flag let you disable it.
>
> Again I don't have strong objection to this change.
>
> Regards
> santosh

Regards,
Jean

>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
