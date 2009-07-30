From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: OMAP850 RTC and MMC registers differ from other OMAP1, how to
	implement?
Date: Thu, 30 Jul 2009 16:39:20 +0100
Message-ID: <3d374d00907300839p43bf09b8vc0eb9a3a702ba7ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:52230 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbZG3PjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 11:39:21 -0400
Received: by ey-out-2122.google.com with SMTP id 9so406536eyd.37
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2009 08:39:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm working on OMAP850 support. I have found that OMAP 15xx and 16xx have
32 bit registers, while 730 and 850 have 8 bit RTC registers and 16
bit MMC registers. At the moment I work around this using #defines as
such:

#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
#define OMAP_RTC_SECONDS_REG           0x00
...
#define OMAP_RTC_OSC_REG               0x19
#else
#define OMAP_RTC_SECONDS_REG            0x00
...
#define OMAP_RTC_OSC_REG                0x54
#endif

I have been told that this isn't a good way to handle it because the
same binary kernel has to work on all OMAP1 machines. So this has to
be checked for at run time. We can check that with cpu_is_omap7xx()
but what would be the correct way to actually implement this? I could
do something like this:

#define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)
#define OMAP_RTC_OSC_REG               (0x19*OMAP_RTC_REGISTER_SIZE)

Would that be acceptable? If not, how should I do it? Is there an
existing driver that does something similar I could look at?

Thanks,

-- 
Alistair Buxton
a.j.buxton@gmail.com
