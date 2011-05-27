From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 0/4] OMAP: PM debug: remove register dump, misc cleanups
Date: Fri, 27 May 2011 08:00:51 -0700
Message-ID: <87mxi85gt8.fsf@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<BANLkTi=3s1DK-WtYtsF=grM7hRAyYhhbfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49039 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752112Ab1E0PAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 11:00:55 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so991042pvg.5
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 08:00:54 -0700 (PDT)
In-Reply-To: <BANLkTi=3s1DK-WtYtsF=grM7hRAyYhhbfA@mail.gmail.com> (Jean
	Pihet's message of "Fri, 27 May 2011 09:34:47 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Inspired by Jean's work to move PM code to modules, I decided it's
>> time to remove a bunch of ugly and difficult to maintain code from P=
M
>> debug.
> Indeed this code is a spaghetti mess and makes pm-debug difficult to
> be modularized.
>
>> The main chunk here is removing the register dump features for
>> OMAP2/OMAP3 which are awful to read, and impossible to scale for
>> OMAP4+. =C2=A0Also, there are now some userspace /dev/mem-based tool=
s (like
>> omapconf) that can handle this type of thing much better, and with a
>> much better interface and display.
>
> Agree. However we still need the equivalent of [1] to retrieve the
> PRCM registers just before and after the WFI instructions.

Correct, but as that patch is not upstream, I'm not considering it=20
as support that needs to be maintained.

> I would like to propose some replacement when the current code
> clean-up is settled down a bit.

Great! =20

Kevin

> [1] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm=
=2Egit;a=3Dcommitdiff;h=3D5dd36389eb6ef4837a2aad128e4bd0226468c171
>
> Regards,
> Jean
>
>> Series applies to v2.6.39.
>>
>> Kevin Hilman (4):
>> =C2=A0OMAP3: PM debug: remove sleep_while_idle feature
>> =C2=A0OMAP2: PM debug: remove register dumping
>> =C2=A0OMAP3: PM debug: remove register dumping
>> =C2=A0OMAP2: PM debug: move wakeup timer into clockevent code
>>
>> =C2=A0arch/arm/mach-omap2/pm-debug.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0362 -----------------------------
>> =C2=A0arch/arm/mach-omap2/pm.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 -
>> =C2=A0arch/arm/mach-omap2/pm24xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +-
>> =C2=A0arch/arm/mach-omap2/pm34xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A06 -
>> =C2=A0arch/arm/mach-omap2/timer-gp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 33 +++-
>> =C2=A0arch/arm/plat-omap/include/plat/dmtimer.h | =C2=A0 =C2=A01 -
>> =C2=A06 files changed, 32 insertions(+), 385 deletions(-)
>>
>> --
>> 1.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
