From: jgq516@gmail.com
Subject: keystone2 board hangs with smp kernel
Date: Mon, 03 Jun 2013 10:18:51 +0800
Message-ID: <51ABFD0B.3020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:59612 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3FCCS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Jun 2013 22:18:57 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so4886804pdc.25
        for <linux-omap@vger.kernel.org>; Sun, 02 Jun 2013 19:18:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cyril@ti.com
Cc: linux-omap@vger.kernel.org

Hello Cyril,

I have got one TI keystone2 board, and tried different tags of tree: 
git://arago-project.org/git/projects/linux-keystone.git,
but seems the kernel always hangs as follows, and kernel runs ok if add 
"nosmp" flag.

[    0.028386] CPU: Testing write buffer coherency: ok
[    0.032493] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.037108] hw perfevents: enabled with ARMv7 Cortex-A15 PMU driver, 
7 counters available
[    0.043763] Setting up static identity map for 0x80464628 - 0x8046465c

The uboot version which I used is from 
git://arago-project.org/git/projects/u-boot-keystone.git
with tag DEV.MCSDK-2013-01.10, I also tried other tags, but seems no 
different effect.

Could you give some advice about smp problem? Thanks in advance!

Regards,
Xiao
