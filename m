From: Li Haifeng <omycle@gmail.com>
Subject: Kexec couldn't reboot capture kernel on pandaboard ES with OMAP4460
Date: Wed, 10 Apr 2013 17:35:00 +0800
Message-ID: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35818 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab3DJJfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 05:35:03 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so5927708wiw.0
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 02:35:01 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pandaboard@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org

Hi, everyone.

Recently, I try to run kdump on pandaboard ES with omap4460. After
load capture kernel by "kexec -l" and execute "kexec -e", the serial
port output "Starting new kernel" and "Bye", then the system hangs up.

I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.

Could you tell my why and how to solve this issue?

Thanks very much.
