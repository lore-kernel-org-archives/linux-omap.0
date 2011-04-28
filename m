From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 0/9] OMAP: GPIO: cleanup, consolidation, etc. (v2)
Date: Thu, 28 Apr 2011 15:09:13 +0530
Message-ID: <BANLkTi=dQohEF3ufyMJ53j5LgCkJV_RZ8A@mail.gmail.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33561 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131Ab1D1Jjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Apr 2011 05:39:55 -0400
Received: by mail-iw0-f177.google.com with SMTP id 36so3368097iwn.22
        for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 02:39:53 -0700 (PDT)
In-Reply-To: <1303418127-4310-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin,

On Fri, Apr 22, 2011 at 02:05, Kevin Hilman <khilman@ti.com> wrote:
> Here's an updated version of my work-in-progress GPIO cleanups.
>
> I now understand that others have some similar work in progress, so
> these are posted (to linux-omap only, for now) so that we can begin
> collaboration on the GPIO cleanups.
>
> This series applies on top of v2.6.39-rc4 plus the generic irq_chip
> series from Thomas Gleixner since in addition to the cleanups, I
> started moving the GPIO IRQ handling over to use generic irq_chip
> (last patch in series.)
>
> This work in progress is available in my wip/gpio-cleanup branch.

I tested the patch series in wip/gpio-cleanup branch.

Here are the results:

Compile tested for:
 - omap1_defconfig
 - omap2plus_defconfig

Boot test (Failed on the following board):
 - OMAP1710-H3

Boot test (Success on the following boards):
 - OMAP2420-H4
 - OMAP3430-SDP
 - OMAP3430-Zoom2
 - OMAP3630-Zoom3
 - OMAP4430-SDP
 - OMAP4430-Blaze

GPIO module functionality testing (success on the following boards):
 - OMAP2420-H4
 - OMAP3430-SDP
 - OMAP3430-Zoom2
 - OMAP3630-Zoom3
 - OMAP4430-SDP
 - OMAP4430-Blaze

PM Testing (success as given below):
OMAP3430-SDP: retention, off_mode, system_wide suspend, gpio wakeup
OMAP3630-Zoom3: retention, system_wide suspend
using the following:
            echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
            echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
            echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
            echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
            echo '5' > /debug/pm_debug/wakeup_timer_seconds
            echo 1 > /debug/pm_debug/sleep_while_idle
            echo 1 > /debug/pm_debug/enable_off_mode

-V Charulatha
