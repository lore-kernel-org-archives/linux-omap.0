From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/9] OMAP: GPIO: cleanup, consolidation, etc. (v2)
Date: Tue, 03 May 2011 18:04:10 -0700
Message-ID: <878vunwa2d.fsf@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
	<BANLkTi=dQohEF3ufyMJ53j5LgCkJV_RZ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:53475 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753976Ab1EDBEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 21:04:14 -0400
Received: by mail-pv0-f176.google.com with SMTP id 37so356466pve.7
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 18:04:13 -0700 (PDT)
In-Reply-To: <BANLkTi=dQohEF3ufyMJ53j5LgCkJV_RZ8A@mail.gmail.com> (Charulatha
	Varadarajan's message of "Thu, 28 Apr 2011 15:09:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Charu,

"Varadarajan, Charulatha" <charu@ti.com> writes:

> I tested the patch series in wip/gpio-cleanup branch.

Thanks so much for testing.  It's a great help.

I've updated the branch based on some of your comments, and in
particular it should now boot on OMAP1.

Kevin

> Here are the results:
>
> Compile tested for:
>  - omap1_defconfig
>  - omap2plus_defconfig
>
> Boot test (Failed on the following board):
>  - OMAP1710-H3
>
> Boot test (Success on the following boards):
>  - OMAP2420-H4
>  - OMAP3430-SDP
>  - OMAP3430-Zoom2
>  - OMAP3630-Zoom3
>  - OMAP4430-SDP
>  - OMAP4430-Blaze
>
> GPIO module functionality testing (success on the following boards):
>  - OMAP2420-H4
>  - OMAP3430-SDP
>  - OMAP3430-Zoom2
>  - OMAP3630-Zoom3
>  - OMAP4430-SDP
>  - OMAP4430-Blaze
>
> PM Testing (success as given below):
> OMAP3430-SDP: retention, off_mode, system_wide suspend, gpio wakeup
> OMAP3630-Zoom3: retention, system_wide suspend
> using the following:
>             echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>             echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>             echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>             echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>             echo '5' > /debug/pm_debug/wakeup_timer_seconds
>             echo 1 > /debug/pm_debug/sleep_while_idle
>             echo 1 > /debug/pm_debug/enable_off_mode
>
> -V Charulatha
