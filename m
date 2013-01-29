From: =?UTF-8?B?xYF1a2FzeiBHw7NyYWxjenlr?= <lukasz.goralczyk@gmail.com>
Subject: [BUG] omap1 fails to boot on clock propagation
Date: Tue, 29 Jan 2013 10:53:56 +0100
Message-ID: <CAP2z3mkGdmSUPZcwTATGvnKrMmkgjwMUGNaTZk17R=X2xMy2AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:37131 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab3A2Jx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 04:53:59 -0500
Received: by mail-wg0-f51.google.com with SMTP id 8so156154wgl.18
        for <linux-omap@vger.kernel.org>; Tue, 29 Jan 2013 01:53:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Some background:
Recently I've ported Linux to some custom omap1 based (5940 or 1510)
hardware. I've had some initial problems, but after a "dirty" fix I
have a running kernel and I can boot using NFS.

Problem:
On the very beginning kernel boot process stopped on clock propagation
routine (simple freeze, no crash info, nothing). After investigation I
have found that one memory read is at fault in function
omap1_ckctl_recalc_dsp_domain() in clock.c file:

dsor = 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));

My fix was to exchange read operation with default value of DSP_CKCTL register:

dsor = 1 << (3 & (0x009000090 >> clk->rate_offset));

Since this fix I haven't dug deeper into this problem, but it keeps me
thinking how to fix it properly. Any suggestions what might be the
root cause of this?

System info:
kernel version 3.5-rc1, kernel boots using some old Redboot
bootloader, compiled with gcc 4.6, almost bare metal kernel
configuration.

Thanks,
Lukasz G.
