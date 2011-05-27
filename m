From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 1/4] OMAP3: PM debug: remove sleep_while_idle feature
Date: Fri, 27 May 2011 18:01:40 +0200
Message-ID: <BANLkTikqgr7XxDwQCq5a_VT=irV82+vMKw@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-2-git-send-email-khilman@ti.com>
	<BANLkTimnt4-8hKuX+Lgd9PH1bu6e6jK+Hw@mail.gmail.com>
	<87vcww412s.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56979 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab1E0QBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 12:01:41 -0400
Received: by qyg14 with SMTP id 14so1042117qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 09:01:40 -0700 (PDT)
In-Reply-To: <87vcww412s.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On Fri, May 27, 2011 at 5:26 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Remove the OMAP-specific PM debug 'sleep_while_idle' feature which =
is
>>> currently available as an OMAP-specific debugfs entry.
>>>
>>> This duplicates existing ARM-generic functionality available as a
>>> boot-time option using the boot cmdline option 'hohlt'.
>> 'nohlt' is only for the default arch idle handler (pm_idle). It does
>> not apply to the cpuidle handler (omap3_enter_idle) which depends on
>> CONFIG_CPU_IDLE.
>
> AFAICT, it affects CPUidle also, since CPUidle replaces pm_idle, whic=
h
> is protected by the hlt_counter check.
That is correct, please ignore my comment.

> I think the CPUidle folks are looking for a way to replace using
> pm_idle though. =A0After that happens, there are a couple options. =A0=
1) add
> a check for hlt_counter in the CPUidle path, or 2) just disable CPUid=
le
> at Kconfig level.
1) makes sense if the kernel parameter is used to enable/disable idle.

>
>>> If runtime configuration of this is needed, then adding a debugfs
>>> entry for the ARM-generic hlt/nohlt interface should be added.
>> Is there a need for it?
>
> I don't think so. =A0 =A0But my point was that if anyone wants this f=
eature
> back, this would be the way to add it.
>
> Kevin
>
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
