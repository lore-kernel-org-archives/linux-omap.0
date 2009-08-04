From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP850 RTC and MMC registers differ from other OMAP1, how to
	implement?
Date: Tue, 4 Aug 2009 17:18:01 +0300
Message-ID: <20090804141759.GL24334@atomide.com>
References: <3d374d00907300839p43bf09b8vc0eb9a3a702ba7ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53601 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbZHDOSG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 10:18:06 -0400
Content-Disposition: inline
In-Reply-To: <3d374d00907300839p43bf09b8vc0eb9a3a702ba7ac@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-omap@vger.kernel.org

* Alistair Buxton <a.j.buxton@gmail.com> [090730 18:45]:
> Hi,
> 
> I'm working on OMAP850 support. I have found that OMAP 15xx and 16xx have
> 32 bit registers, while 730 and 850 have 8 bit RTC registers and 16
> bit MMC registers. At the moment I work around this using #defines as
> such:
> 
> #if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
> #define OMAP_RTC_SECONDS_REG           0x00
> ...
> #define OMAP_RTC_OSC_REG               0x19
> #else
> #define OMAP_RTC_SECONDS_REG            0x00
> ...
> #define OMAP_RTC_OSC_REG                0x54
> #endif
> 
> I have been told that this isn't a good way to handle it because the
> same binary kernel has to work on all OMAP1 machines. So this has to
> be checked for at run time. We can check that with cpu_is_omap7xx()
> but what would be the correct way to actually implement this? I could
> do something like this:
> 
> #define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)
> #define OMAP_RTC_OSC_REG               (0x19*OMAP_RTC_REGISTER_SIZE)
> 
> Would that be acceptable? If not, how should I do it? Is there an
> existing driver that does something similar I could look at?

Maybe take a look at this recent post by Russell:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14522.html

After you have the register offset arrays done, you can have the
drivers specific register read/write functions access the registers
based on cpu_is_omap7xx().

Regards,

Tony
