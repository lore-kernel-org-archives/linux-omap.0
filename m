From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 19:53:07 +0530
Message-ID: <CAMQu2gxrUycJq07Ngs-TXq+jqqe4uBH4Y_CZjFict=OL9ifb_g@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <4F69A872.50203@ti.com> <CAORVsuUL3Z_vw+n26eWaa8eAJ0yhXB=VRNmuCeSZjStG527Gag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50399 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818Ab2CUOXa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 10:23:30 -0400
Received: by mail-qc0-f178.google.com with SMTP id e14so804846qcs.37
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 07:23:29 -0700 (PDT)
In-Reply-To: <CAORVsuUL3Z_vw+n26eWaa8eAJ0yhXB=VRNmuCeSZjStG527Gag@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linaro Dev <linaro-dev@lists.linaro.org>

On Wed, Mar 21, 2012 at 6:49 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Hi Santosh, Daniel,
>
> On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Daniel,
>>
>> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>>> This patchset is a proposition to improve a bit the code.
>>> The changes are code cleanup and does not change the behavior of th=
e
>>> driver itself.
>>>
>>> A couple a things call my intention. Why the cpuidle device is set =
for cpu0 only
>>> and why the WFI is not used ?
>>>
>>> Daniel Lezcano (7):
>>> =A0 ARM: OMAP4: cpuidle - Remove unused valid field
>>> =A0 ARM: OMAP4: cpuidle - Declare the states with the driver declar=
ation
>>> =A0 ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>>> =A0 ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>>> =A0 ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile tim=
e
>>> =A0 ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>>> =A0 ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at =
boot
>>> =A0 =A0 time
>>>
>> The series looks fine to me in general. This clean-up is applicable
>> for OMAP3 cpuidle code as well.
>>
>> I want Jean to look at this series because some of his earlier
>> clean up has introduced those custom functions which
>> are getting removed in this series.
> I am OK with the patch set, I only have minor remarks to the individu=
al patches.
>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
>
Thanks Jean for looking at it.

Daniel,
=46eel free to add.
 Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
