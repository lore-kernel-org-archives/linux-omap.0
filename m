From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 0/4] OMAP: PM debug: remove register dump, misc cleanups
Date: Fri, 27 May 2011 09:34:47 +0200
Message-ID: <BANLkTi=3s1DK-WtYtsF=grM7hRAyYhhbfA@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50852 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1E0Hes convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 03:34:48 -0400
Received: by qyg14 with SMTP id 14so824690qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 00:34:47 -0700 (PDT)
In-Reply-To: <1306450971-27732-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On Fri, May 27, 2011 at 1:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> Inspired by Jean's work to move PM code to modules, I decided it's
> time to remove a bunch of ugly and difficult to maintain code from PM
> debug.
Indeed this code is a spaghetti mess and makes pm-debug difficult to
be modularized.

> The main chunk here is removing the register dump features for
> OMAP2/OMAP3 which are awful to read, and impossible to scale for
> OMAP4+. =A0Also, there are now some userspace /dev/mem-based tools (l=
ike
> omapconf) that can handle this type of thing much better, and with a
> much better interface and display.
Agree. However we still need the equivalent of [1] to retrieve the
PRCM registers just before and after the WFI instructions.
I would like to propose some replacement when the current code
clean-up is settled down a bit.

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.g=
it;a=3Dcommitdiff;h=3D5dd36389eb6ef4837a2aad128e4bd0226468c171

Regards,
Jean

> Series applies to v2.6.39.
>
> Kevin Hilman (4):
> =A0OMAP3: PM debug: remove sleep_while_idle feature
> =A0OMAP2: PM debug: remove register dumping
> =A0OMAP3: PM debug: remove register dumping
> =A0OMAP2: PM debug: move wakeup timer into clockevent code
>
> =A0arch/arm/mach-omap2/pm-debug.c =A0 =A0 =A0 =A0 =A0 =A0| =A0362 ---=
--------------------------
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A09 -
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06=
 +-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06=
 -
> =A0arch/arm/mach-omap2/timer-gp.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 33 +++=
-
> =A0arch/arm/plat-omap/include/plat/dmtimer.h | =A0 =A01 -
> =A06 files changed, 32 insertions(+), 385 deletions(-)
>
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
