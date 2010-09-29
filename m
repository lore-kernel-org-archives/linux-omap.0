From: Silesh C V <silesh@ti.com>
Subject: Re: [PATCH] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Wed, 29 Sep 2010 10:57:32 +0530
Message-ID: <AANLkTi=Zkyo7EM511ueK6ZXO3_H+3vc093RvQ0utRn8r@mail.gmail.com>
References: <1285318494-22092-1-git-send-email-silesh@ti.com>
	<87pqw3ji5i.fsf@deeprootsystems.com>
	<AANLkTikWWyfgUOYyXud0D0vpMwAn2xxUKM=dNPoYsCK0@mail.gmail.com>
	<AANLkTimT0bfNjBThHj8bPAZ+ybfV=PFJkj09AUL0M20g@mail.gmail.com>
	<AANLkTi=kajdYN9rbdjH_9q6E5RLuy_oj-4Xsk-X6sFRg@mail.gmail.com>
	<87tyl9d6en.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33225 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab0I2F1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 01:27:32 -0400
Received: by iwn5 with SMTP id 5so574005iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 22:27:32 -0700 (PDT)
In-Reply-To: <87tyl9d6en.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Govindraj <govindraj.ti@gmail.com>, linux-omap@vger.kernel.org

On Wed, Sep 29, 2010 at 12:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:

> I see what you're saying now. =A0The current #elif clause will *alway=
s* be
> true.
>
> You'll notice that all of this confusion would not have happened if t=
he
> original changelog described the problem in detail, showing that that
> #elif clause will always be true, and especially not calling it a
> compliation fix.

I did not call it a compilation fix, I called it a _conditional_
compilation fix ;-).
The problem is not that the #elif clause ends up always being true.
The problem is that the preprocessor checks for the value of
CONFIG_ARCH_OMAP3 rather than the value of defined(CONFIG_ARCH_OMAP3).
Hence it emits warnings when CONFIG_ARCH_OMAP3 is not defined making
the #elif clause useless(which is there to check whether the macro is
defined or not).

>
> Please re-post with a better changelog and I will incoporate into the
> pm-cpufreq sub-branch of the PM branch.


Will do.

Thanks,
Silesh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
