From: Andrew LeCain <alecain@google.com>
Subject: Re: dss_pwrdm & core_pwrdm not entering sleep state correctly on am37xx
Date: Wed, 14 May 2014 15:32:50 -0700
Message-ID: <CABCN2Svhb4vM=4jWOi50ZropWgON7Un8-FDO4N+SwQk1o2J+gA@mail.gmail.com>
References: <CABCN2StgZisw2WH=wQb_iGEDZLo1ysLJ-f8BZ4a_Yf0_Ph_zKQ@mail.gmail.com>
	<536A0809.3050008@ti.com>
	<CABCN2StAeAju9d0j108quWUpHW68_vb=M63VTWx_KddR=d+UPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:51376 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbaENWcv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 18:32:51 -0400
Received: by mail-ig0-f176.google.com with SMTP id hl10so7200379igb.3
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 15:32:50 -0700 (PDT)
In-Reply-To: <CABCN2StAeAju9d0j108quWUpHW68_vb=M63VTWx_KddR=d+UPQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Follow up to this:

I found the patch from 9/oct/2009 ("[PATCH 1/1] OMAP: DSS2: RFBI
driver update") suggesting that perhaps the interface clocks in the
RFBI module are not disabled correctly by the autoidle mechanism. When
I mask off bits 3 and 4 in the RFBI SYSCONFIG register during susepnd
the ICLK appears to correctly disable and allows the DSS powerdomain
to sleep, saving about 6mW. I am not sure if there was consensus that
this is the correct behavior or just errata.

Unfortunately, this doesn't solve my problem entirely as my sleep
current is still far too high, but does seem to address the dss_pwrdm
retention state issue.

-Andrew

On Wed, May 7, 2014 at 1:13 PM, Andrew LeCain <alecain@google.com> wrote:
> On Wed, May 7, 2014 at 3:16 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>> That is probably some custom kernel, as mainline 2.6.32 didn't even have
>> omapdss driver.
>
> My mistake-- I'm now working on 2.6.37, where I am also experiencing
> the issue. Another point that may be relevant is that I have both dbi
> and rfbi support compiled into the kernel. I am trying to enable
> detection of two different panels that use the different busses. Only
> one panel is loaded but both are compiled into the kernel.
>
>> Hmm. I think the "dss_clkdm->dss_pwrdm (0)" says that there are no users
>> with references dss_pwrdm. So it sounds to me all the clocks etc are
>> properly off, but the platform code does not turn the dss powerdomain
>> off for some reason.
>
> This is what I thought at first too, but when I dump the clock control
> registers as suggested by Tony Lindgren, it looks like the DSS clocks
> are active:
>
> Before suspend snapshot (/debug/pm_debug/registers/1)
>
> MOD: CM_DSS (48004e00)
>   20 => 00000003  30 => 00000001  40 => 00001005  48 => 00000003
>   4c => 00000001
>
> 4c=> clocks active, 48=> automatic transition
>
> MOD: CM_CCR (48004d00)
>   00 => f0371007  04 => 00000011  20 => 00000a0b  30 => 00000009
>   34 => 00000001  40 => 099f1700  44 => 04816807  48 => 00000009
>   4c => 00004b0b  50 => 00000001  70 => 00000003
>
> reg 20=> DSS1_ALWON_FCLK | FUNC96M | 48MPERIPH | CORE
>
> The reference counts indicated by the count registers don't really
> agree with this, so I'm trying to track down the inconsistencies.
> Maybe a snapshot of clock usecounts taken at the same time as the
> register snapshot will be helpful-- it's possible that my panel driver
> is turning on a clock on the way down that is keeping the powerdomain
> up. I've checked through the driver for mismatched enable/disable
> calls, so that seems unlikely, but may be it.
>
> Where is the actual shut down of the powerdomain supposed happen? If i
> can dump clock usecounts at that point maybe that will provide some
> insight.
>
> -Andrew
