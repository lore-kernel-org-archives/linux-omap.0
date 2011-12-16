From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v9 00/31] gpio/omap: driver cleanup and fixes
Date: Fri, 16 Dec 2011 12:58:31 +0530
Message-ID: <CAMQu2gyZtuW3HLbWH5wH-YjB4SpLD9tz5kpVdRHi2j9RsXLA2w@mail.gmail.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34169 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758988Ab1LPH3J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:29:09 -0500
Received: by qadc11 with SMTP id c11so1760948qad.4
        for <linux-omap@vger.kernel.org>; Thu, 15 Dec 2011 23:28:53 -0800 (PST)
In-Reply-To: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun,

On Wed, Dec 14, 2011 at 1:50 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.
>
> Baseline: git://github.com/khilman/linux-omap-pm.git
> Branch: for_3.3/gpio-base
>
> Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x-2.6.git
> Branch: master
> Commit: b835c0f
>
> Power Tests
> a) OMAP3430SDP
> - Modify board-3430sdp.c file to have multiple GPIO modules active
> =A0with debounce timeout enabled.
> - Enable CPU-Idle
> - Enable UART timeouts
> - Enable offmode
> - echo mem > /sys/power/state
> - Verify retention and offmode count increment
>
> b) ZOOM3
> - Enable CPU-Idle
> - Enable UART timeout
> - echo mem > /sys/power/state
> - Wakeup system using serial keyboard
> - Verify retention count increment
>
> Functional Tests
> - Done on OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430
>
> Bootup Test
> - Done on OMAP1710
>
> v9:
> - Summary of Comments/Issues fixed
> =A0* GPIO wakeup does not work
> =A0* Call debounce clock enable/disable functions from PM runtime cal=
lbacks.
> =A0 =A0This will avoid calling the functions from multiple places.
> =A0* Modify description of following patch to match latest changes.
> =A0 =A0gpio/omap: save and restore debounce registers
> =A0* Use (bank->regs->set_dataout && bank->regs->clr_dataout) togethe=
r instead
> =A0 =A0of using only one of them.
> =A0* Remove cpu_is_omapxxxx() checks from set_gpio_trigger().
> =A0* _gpio_dbck_enable() in runtime callback triggered from omap_gpio=
_request
> =A0 =A0does not enable dbck because dbck_enable_mask is not set at th=
is point.
> =A0* Workaround associated with an errata got missed in v8. This has =
been
> =A0 =A0 =A0included.
>
As reported by Kevin ( off-the list), only 25 patches out of 31
reached to the list.
The rest 8, for some reason didn't reached to the list.

Also since you have added few additional bug fixes in this series on to=
p of
the v8, the v9 becomes slightly different.

So here is what I suggest.
1. Repost your v9 only with those 25 reworked patches.
2. Create a separate series for additional bug fixes which will apply o=
n top
of 1)

That way it's easier to line up the patches since the 25 ones have gone=
 though
few review cycles where as the new 8 has only gone through the internal=
 review.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
