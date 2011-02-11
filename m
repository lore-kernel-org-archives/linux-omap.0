From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri, 11 Feb 2011 09:36:03 +0000
Message-ID: <AANLkTinF67qb-y30Z2gfxk-ZZJCjEpBgy22FwQ24ETvZ@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<36192288611a2912eca9abc99a4353ff@mail.gmail.com>
	<AANLkTi=sPeQPfcGzrLSB=9-V805y6pnU4gA5QgqMSwWe@mail.gmail.com>
	<9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
	<AANLkTiknZ1VrA_OuqY=0AihNWiEdMkHA_zyVKQLg70+w@mail.gmail.com>
	<82c254dc5a3a4a405b25350e1ef3240e@mail.gmail.com>
	<87sjvvh8oc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37246 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab1BKJgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 04:36:05 -0500
Received: by wwa36 with SMTP id 36so2361635wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 01:36:03 -0800 (PST)
In-Reply-To: <87sjvvh8oc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Thu, Feb 10, 2011 at 9:38 PM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> [...]
>
>>>
>>> The SD card gets suspended, but nothing else seems to happen, and I
>>> can't resume the system.
>>>
>>> Am I doing something wrong?
>>>
>> MMC suspend is broken. I use ramdisk-ext3 or NFS for my testing
>>
>
> Just to clarify, MMC suspend is not broken. =A0It's a "feature" the M=
MC
> core. =A0See the help text of the following Kconfig option, and ensur=
e
> that it's enabled:
>
>
> config MMC_UNSAFE_RESUME
> =A0 =A0 =A0 =A0bool "Assume MMC/SD cards are non-removable (DANGEROUS=
)"
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say Y here, the MMC layer will assume that =
all cards
> =A0 =A0 =A0 =A0 =A0stayed in their respective slots during the suspen=
d. The
> =A0 =A0 =A0 =A0 =A0normal behaviour is to remove them at suspend and
> =A0 =A0 =A0 =A0 =A0redetecting them at resume. Breaking this assumpti=
on will
> =A0 =A0 =A0 =A0 =A0in most cases result in data corruption.
>
> =A0 =A0 =A0 =A0 =A0This option is usually just for embedded systems w=
hich use
> =A0 =A0 =A0 =A0 =A0a MMC/SD card for rootfs. Most people should say N=
 here.
>
> =A0 =A0 =A0 =A0 =A0This option sets a default which can be overridden=
 by the
> =A0 =A0 =A0 =A0 =A0module parameter "removable=3D0" or "removable=3D1=
".
>
> Looking at Dave's .config, this option is disabled, so suspend will h=
ang
> when rootfs is on MMC.

Thanks for the clarification.  For simplicity, and since Thumb-2
should be unrelated to the MMC subsystem, I've been testing suspend
from the initramfs instead ... which sidesteps the MMC issue.

Power-off-suspend does still have some weird problems when
CONFIG_THUMB2_KERNEL is enabled; I'm still investigating this.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
