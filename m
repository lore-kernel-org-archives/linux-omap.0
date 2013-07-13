From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Fri, 12 Jul 2013 19:31:58 -0700
Message-ID: <CAOesGMjv=GxWSxaUebY6pP4sJHfQNeuUk2BcAFBT3QxX3jGZLw@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost>
	<20130517191751.468.89202.stgit@localhost>
	<20130520095447.GR21614@n2100.arm.linux.org.uk>
	<20130706131057.GU21614@n2100.arm.linux.org.uk>
	<20130706133627.GV21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:61928 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053Ab3GMCb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 22:31:59 -0400
Received: by mail-qe0-f51.google.com with SMTP id a11so5409180qen.24
        for <linux-omap@vger.kernel.org>; Fri, 12 Jul 2013 19:31:58 -0700 (PDT)
In-Reply-To: <20130706133627.GV21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

Hi,


On Sat, Jul 6, 2013 at 6:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> With that worked out, throwing my standard printascii() hack into the
> kernel results in boot messages... up to the point where the timer is
> calibrated.  So, it looks like either interrupts, clocks, or the OMAP
> timers are non-functional with DT based kernels on the SDP board.
>
> Any ideas?

I'm a bit late to the party due to travel and other things going on,
but I have the exact same thing happening with multi_v7_defconfig on
my Panda ES right now -- it gets stuck on calibrating delay loop. I
needed to enable DEBUG_LL and early printk to not just get a dead
system though.

What happened in my case was that MACH_OMAP4 was no longer enabled so
clocks weren't registered. I wonder if we can improve debugability of
that somehow.

Before Arnd's patch to flip the MACH_OMAP2PLUS option around, they got
enabled by default I think. So now I needed:

-CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_ARCH_OMAP3=y
+CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
+CONFIG_SOC_AM33XX=y

...in the defconfig.

This is pretty painful, and I don't know if we want to rethink Arnd's
patch since it will break existing defconfigs out there that rely on
OMAP2PLUS enabling the socs instead of the other way around. Opinions?


-Olof
