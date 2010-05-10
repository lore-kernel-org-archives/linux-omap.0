From: Suresh Rajashekara <suresh.raj@gmail.com>
Subject: Issue with SCHED_FIFO app
Date: Sun, 9 May 2010 21:39:05 -0700
Message-ID: <k2j54a292881005092139u7e120250hf530f8b688abdd22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60887 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0EJEj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 00:39:26 -0400
Received: by gwj19 with SMTP id 19so1713390gwj.19
        for <linux-omap@vger.kernel.org>; Sun, 09 May 2010 21:39:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

I had a couple of application (with real time priority SCHED_FIFO)
which were working fine on 2.6.16. They have started behaving
differently on 2.6.29.

I will explain my problem briefly.

Application A (my main application) is scheduled with SCHED_FIFO and
priority 5.
Application B (watchdog application) is also scheduled with SCHED_FIFO
but with priority 54.

A keeps putting the OMAP to sleep and wake up every 4 seconds and
again puts it to sleep.
B is supposed to be running every 1.25 seconds to kick watchdog, but
since A keeps OMAP in sleep for 4 seconds, it should run as soon as
OMAP wakes up.

Since B is of a higher priority, its supposed to run whenever the OMAP
wakes up and then A should again put it back to sleep. This happens
perfectly on 2.6.16

On 2.6.29, B fails to run when OMAP wakes up and before A puts it back
to sleep. B only runs if there is atleast 1.5 seconds of delay between
the awake-sleep cycle.

On searching the internet, I figured out that CFS (completely fair
scheduler) was introduced in 2.6.23, which makes some changes to the
RT bandwidth (and many users started facing issues with they
applications with SCHED_FIFO). Somewhere on the web I found that
issuing

echo -1 > /proc/sys/kernel/sched_rt_runtime_us

should disable the changes which affects the RT bandwidth. It actually
did help to an extent in solving some other problem (not described
above. A's IOCTL call return was getting delayed), but this problem
still persists.

Any pointers to where I should look for the solution.

Is there a way I can revert back to the scheduler behavior as it was on 2.6.16?

I have disabled CONFIG_GROUP_SCHED and also CONFIG_CGROUPS. I am using
2.6.29 on an OMAP1 platform.

Thanks in advance,
Suresh
