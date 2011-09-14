From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Wed, 14 Sep 2011 10:56:36 +0530
Message-ID: <CAMQu2gwtj17KTeQFA-okaPYV4KKTnvzM8FcqaO0ptm2ZEH-8=A@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
 <87y5xteahc.fsf@ti.com> <4E6EECA3.4040704@ti.com> <87wrdcbb49.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58485 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750906Ab1INF05 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 01:26:57 -0400
Received: by mail-gw0-f54.google.com with SMTP id 18so1643126gwj.27
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 22:26:56 -0700 (PDT)
In-Reply-To: <87wrdcbb49.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Tue, Sep 13, 2011 at 11:03 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh <santosh.shilimkar@ti.com> writes:
>
>> On Tuesday 13 September 2011 02:36 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar<santosh.shilimkar@ti.com> =A0writes:
>>>
>>>> This patch adds the CPU0 and CPU1 off mode support. CPUX close swi=
tch
>>>> retention (CSWR) is not supported by hardware design.
>>>>
>>>> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>>>>
>>>> CPUx sleep code is common for hotplug, suspend and CPUilde.
>>>>
>>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>> Cc: Kevin Hilman<khilman@ti.com>
>>>
>>> [...]
>>>
>>>> @@ -38,6 +39,11 @@ void __iomem *omap4_get_scu_base(void)
>>>>
>>>> =A0 void __cpuinit platform_secondary_init(unsigned int cpu)
>>>> =A0 {
>>>> + =A0 /* Enable NS access to SMP bit for this CPU on EMU/HS device=
s */
>>>> + =A0 if (cpu_is_omap443x()&& =A0(omap_type() !=3D OMAP2_DEVICE_TY=
PE_GP))
>>>
>>> A comment here about why this is 443x specific would be helpful.
>>>
>>> I see a comment in omap4_cpu_resume() that seems to indicate that S=
MP
>>> bit is accessible on 446x NS devices, but repeating that commen her=
e
>>> would help future readability.
>>>
>> Ok. Will add comments here too. Was just trying to save some lines :=
)
>
> heh, this is a negative side-effect of people caring primarily about
> diffstat. :(
>
ya.

> One other comment on this patch. =A0You need spaces around the '&&' a=
bove.
>
The original patch is fine for that. Some replies has eaten that space.=
 My
Thunderbird email client is doing the same. :(

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
