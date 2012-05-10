From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 0/8] gpio/omap: remaining cleanups and fix
Date: Thu, 10 May 2012 12:08:10 +0530
Message-ID: <CAMrsUdJg6bftZdtGM3Pfz7FO=69AfgCc86cDgGRxHW2gXR+0BA@mail.gmail.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:57025 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754944Ab2EJGib convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:38:31 -0400
Received: by obbtb18 with SMTP id tb18so1945102obb.33
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:38:30 -0700 (PDT)
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Tarun,

On Fri, Apr 27, 2012 at 7:43 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Here are the remaining cleanup patches. There are broadly
> two categories of cleanups.
>
> Cat-1: Those missed while introducing new feature like SPARSE_IRQ
> =A0 =A0 =A0 handling and DT support; use edge/level handlers from
> =A0 =A0 =A0 generic IRQ framework.
>
> Cat-2: Removal of redundant fields from struct gpio_bank{} as a
> =A0 =A0 =A0 result of they being already covered by members within
> =A0 =A0 =A0 context field of struct gpio_bank{}.
>
> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux-2.6.git
> Commit: 66f75a5d028beaf67c931435fdc3e7823125730c (Linux 3.4-rc4)
>
> Series is available for reference here:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-=
omap-dev.git for_3.5/gpio_more_cleanup_fixes


I tested this series from your tree on Beagle-XM retention, offmode,
suspend to mem and resume with and and without enabling offmode
from sysfs was checked and found retention count and off mode
count was getting incremented.

Also ran few test cases available from here[1] to request and release g=
pio,
test cases passed.

=46eel Free to add:

Tested-by: Govindraj.R <govindraj.raja@ti.com>

--
Thanks
Govindraj.R

[1]: http://gitorious.org/omap-ddt/omap-ddt/trees/master/gpio/test_code=
/utils/gpio_mods
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
