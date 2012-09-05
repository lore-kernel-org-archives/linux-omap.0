From: Viresh Kumar <viresh.linux@gmail.com>
Subject: OMAP: Compilation error: omapzoom kernel tree
Date: Wed, 5 Sep 2012 10:52:05 +0530
Message-ID: <CAOh2x=nbJyxkb7ErYKBQuQa8EaUrswaas-qywTUcpmp=cico6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43112 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2IEFWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 01:22:06 -0400
Received: by ieje11 with SMTP id e11so297229iej.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 22:22:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Which branch should i use from TI[1] tree? I need to boot linux
with linaro-nano.

I tried: p-linux-omap-3.4 branch but i am getting compilation error for
omap4plus_pm_min_defconfig and omap2plus_defconfig:

/home/arm/work/kernel/mywork/linux.git/arch/arm/mm/proc-v7.S:
Assembler messages:
/home/arm/work/kernel/mywork/linux.git/arch/arm/mm/proc-v7.S:260:
Error: selected processor does not support ARM mode `smc #0'
/home/arm/work/kernel/mywork/linux.git/arch/arm/mm/proc-v7.S:260:
Error: selected processor does not support ARM mode `smc #0'
make[2]: *** [arch/arm/mm/proc-v7.o] Error 1

Can somebody help?

--
viresh

[1] http://omapzoom.org/?p=kernel/omap.git;a=summary
