From: "Menon, Nishanth" <nm@ti.com>
Subject: pm-core: recursive dependency on config
Date: Sat, 5 Mar 2011 13:51:07 +0530
Message-ID: <AANLkTi=wNSOmZ8TcWGUoPmdaC5ga9NrzsXhULnUxLMGk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49448 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487Ab1CEIV2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 03:21:28 -0500
Received: by mail-wy0-f170.google.com with SMTP id 19so3763545wyf.15
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 00:21:27 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Folks,
Dumb question:
Some one seen this one? is there a patch in the pipe for the fix?

scripts/kconfig/conf --silentoldconfig Kconfig
arch/arm/Kconfig:1277:error: recursive dependency detected!
arch/arm/Kconfig:1277:	symbol SMP depends on CPU_V6K
arch/arm/mm/Kconfig:407:	symbol CPU_V6K depends on SMP

Regards,
Nishanth Menon
