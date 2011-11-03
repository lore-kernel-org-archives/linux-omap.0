From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Thu, 03 Nov 2011 14:44:13 -0700
Message-ID: <87obwsg9ua.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45926 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752439Ab1KCVoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 17:44:20 -0400
Received: by ywn1 with SMTP id 1so2288491ywn.22
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 14:44:19 -0700 (PDT)
In-Reply-To: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 5 Oct 2011 14:02:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.

Using this series on 3630/Zoom3, UART wakeups no longer work from
suspend.  That suggests that GPIO wakeups from retention/off are not
working.

Please test GPIO wakeups from retention/off.  One way is to use Zoom3
UART wakeup from suspend using by enabling UART wakeups and suspending:

   # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
   # echo mem > /sys/power/state

Also, this series now has a handful of minor conflicts with stuff that
is queued or merged for v3.2.  Please rebase onto 

   git://github.com/khilman/linux-omap-pm.git for_3.3/gpio-base

Kevin
