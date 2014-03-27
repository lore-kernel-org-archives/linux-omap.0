From: Paolo Pisati <p.pisati@gmail.com>
Subject: 3.1[34]: omap4: panda: hang on reboot?
Date: Thu, 27 Mar 2014 18:54:14 +0100
Message-ID: <20140327175414.GA5795@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:55486 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0RyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2014 13:54:18 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3169043eek.18
        for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2014 10:54:17 -0700 (PDT)
Received: from gmail.com (2-230-238-136.ip204.fastwebnet.it. [2.230.238.136])
        by mx.google.com with ESMTPSA id x45sm5840803eef.15.2014.03.27.10.54.16
        for <linux-omap@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 10:54:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I've been experiencing hangs on reboot on two different panda boards (es rev1
and vanilla rev a1) with v3.14-rc8 (but reproducible in 3.13 too):

toolchanin: gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7)

the config is a multi_v7_defconfig plus a couple of codepages:

http://people.canonical.com/~ppisati/omap4_reboot_hangs/config

a prebuilt zImage is available here:

http://people.canonical.com/~ppisati/omap4_reboot_hangs/zImage

sometimes i can hit this two times in a row, others it's a bit less
frequent - put this into your crontab and let it go:

*/5 * * * *       /bin/date >> /reboot.log && /sbin/reboot

it never passed 2hrs of reboot cycles.

I already tried different u-boots but that doesn't make any difference,
am i the only one experiencing this issue?
-- 
bye,
p.
