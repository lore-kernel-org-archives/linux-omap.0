From: Andrew LeCain <alecain@google.com>
Subject: Re: dss_pwrdm & core_pwrdm not entering sleep state correctly on am37xx
Date: Wed, 7 May 2014 13:13:23 -0700
Message-ID: <CABCN2StAeAju9d0j108quWUpHW68_vb=M63VTWx_KddR=d+UPQ@mail.gmail.com>
References: <CABCN2StgZisw2WH=wQb_iGEDZLo1ysLJ-f8BZ4a_Yf0_Ph_zKQ@mail.gmail.com>
	<536A0809.3050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:39749 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaEGUNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 16:13:24 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so8180438igb.0
        for <linux-omap@vger.kernel.org>; Wed, 07 May 2014 13:13:23 -0700 (PDT)
In-Reply-To: <536A0809.3050008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, May 7, 2014 at 3:16 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> That is probably some custom kernel, as mainline 2.6.32 didn't even have
> omapdss driver.

My mistake-- I'm now working on 2.6.37, where I am also experiencing
the issue. Another point that may be relevant is that I have both dbi
and rfbi support compiled into the kernel. I am trying to enable
detection of two different panels that use the different busses. Only
one panel is loaded but both are compiled into the kernel.

> Hmm. I think the "dss_clkdm->dss_pwrdm (0)" says that there are no users
> with references dss_pwrdm. So it sounds to me all the clocks etc are
> properly off, but the platform code does not turn the dss powerdomain
> off for some reason.

This is what I thought at first too, but when I dump the clock control
registers as suggested by Tony Lindgren, it looks like the DSS clocks
are active:

Before suspend snapshot (/debug/pm_debug/registers/1)

MOD: CM_DSS (48004e00)
  20 => 00000003  30 => 00000001  40 => 00001005  48 => 00000003
  4c => 00000001

4c=> clocks active, 48=> automatic transition

MOD: CM_CCR (48004d00)
  00 => f0371007  04 => 00000011  20 => 00000a0b  30 => 00000009
  34 => 00000001  40 => 099f1700  44 => 04816807  48 => 00000009
  4c => 00004b0b  50 => 00000001  70 => 00000003

reg 20=> DSS1_ALWON_FCLK | FUNC96M | 48MPERIPH | CORE

The reference counts indicated by the count registers don't really
agree with this, so I'm trying to track down the inconsistencies.
Maybe a snapshot of clock usecounts taken at the same time as the
register snapshot will be helpful-- it's possible that my panel driver
is turning on a clock on the way down that is keeping the powerdomain
up. I've checked through the driver for mismatched enable/disable
calls, so that seems unlikely, but may be it.

Where is the actual shut down of the powerdomain supposed happen? If i
can dump clock usecounts at that point maybe that will provide some
insight.

-Andrew
