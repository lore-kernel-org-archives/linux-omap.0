From: Chao Xu <caesarxuchao@gmail.com>
Subject: what does the number in the pm_debug/count mean for clockdomains?
Date: Sun, 25 Aug 2013 21:11:48 -0500
Message-ID: <CAKZq+rda2svzfG4WRx91fCiK97JDzd5NMGqZfBtURFxoQnj-kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:55612 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3HZCLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Aug 2013 22:11:48 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu14so34676qab.7
        for <linux-omap@vger.kernel.org>; Sun, 25 Aug 2013 19:11:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I don't know how to interpret the bottom half of the
/sys/kernel/debug/pm_debug, e.g.    l3_dma_clkdm->core_pwrdm (0)
What does the number in the brackets mean? Does it mean how many times
the l3_dma_clkdm has been gated? Also, Thank you!

-- 
Regards,
Chao Xu
