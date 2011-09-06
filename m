From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: BUG : clock_gettime reports time going backwards with high resolution timer
Date: Mon, 5 Sep 2011 23:19:28 -0500
Message-ID: <CAFQPvXe-ymm_Mxq4g0QmwCrBfEQG_tjxV12ef6c5HW=N6WKzkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42626 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1IFET3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 00:19:29 -0400
Received: by vxi9 with SMTP id 9so4323176vxi.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 21:19:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Based on tglx's suggestion, I ran the following test on 2 panda boards.
>
>        clock_gettime(CLOCK_MONOTONIC, &prev);
>        while (1) {
>              clock_gettime(CLOCK_MONOTONIC, &curr);
>              if (curr < prev) /* Use a proper compare function for
> timespec! */
>                       printf(.....);
>              prev = curr;
>        }

Both of them fail this simple test with vanilla (both single core and
SMP) kernels (2.6.39-rc4 mainline with high-resolution timer patch,
3.0.1 mainline with high-resolution timer patch, 3.1-rc2 OMAP git tree
without any patch but with high-resolution timer enabled) within a few
seconds to an hour. Time goes backwards from as low as 234 nsec to 53
usec. The problem does not reproduce without high resolution timer
(i.e by enabling 32 KHz timer in kernel config) for several hours of
testing.

Is this issue panda board specific or a common issue on all ARM
targets? Is it a known issue already and anyone looking into it?

Thanks in advance for the help,
Sankara
