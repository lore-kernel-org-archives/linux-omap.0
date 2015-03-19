From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Thu, 19 Mar 2015 06:13:41 +0100
Message-ID: <CAALWOA9=tY3X38O9p-xYabb-AZy7rJBM5AOFYgco_ZmsixOViQ@mail.gmail.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com> <20150117164709.GS18552@atomide.com>
 <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
 <20150202160932.GF16250@atomide.com> <20150318000652.GJ31346@atomide.com>
 <CAALWOA9yoS5sdo-A_hdqhkqGqZ-VCg9jZfdavhxskFdE_pA1Sg@mail.gmail.com> <20150318165453.GP31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36773 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbbCSFOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 01:14:03 -0400
Received: by wibg7 with SMTP id g7so107745744wib.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 22:14:01 -0700 (PDT)
In-Reply-To: <20150318165453.GP31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

> Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> 44400500 target 11 vcp
> 44800100 target 18 vlynq ?

scrap these guesses: I don't think Netra has a vcp module, and I had
only filled in vlynq based on it being the only remaining target NIU.
Once the memory ranges for the targets have been determined they
should be easy to identify conclusively.

On 18 March 2015 at 17:54, Tony Lindgren <tony@atomide.com> wrote:
> Oh there's a gap here and it goes all the way to 2400.. Is there
> a gap on am335x too?

There are indeed. See my work-in-progress spreadsheet on its L3
interconnect: http://goo.gl/miyCQw

As with the memory map, there are some "ghost" modules which I'm
reasonably sure don't exist, even though they have a target NIU and
clkctrl registers.

I haven't yet checked which initiator the sole bandwidth regulator on
subarctic is attached to. Plausible options are SGX, the LCD
controller, or one of the EDMA TCs.

I also just noticed how *big* its statistics collectors are. o.O  For
comparison, the ones on netra and centaurus are 0x200 (statcoll 0 and
3) or 0x400 (statcoll 1 and 2).


>> 2. Disable all L3 Target NIUs. You will temporarily lose access to all
>> peripherals, OCMC ram, and on subarctic also DDR memory (I think on
>> devices with a DMM you'd retain access to DDR memory). Note that the
>> service network itself isn't considered an L3 target.
>
> Hmm well we could that in the kernel using the SRAM code as long as
> it does not reset the devices.

If you run with MMU disabled then you'd have to run out of the 64K
internal SRAM, and catch data aborts since all writes will be
non-posted. With MMU enabled, locking code and MMU translation tables
into the (much larger) L2 cache makes more sense.

I *think* disabling the NIU only blocks access to the module and
doesn't affect the module operationally. I'd be inclined to put
external RAM into self-refresh during the procedure just to be sure,
in case disabling NIUs results in clock gating (which would otherwise
be hard to notice).

> OK the driver would have to be enabled with interrupts while scanning.

Polling makes more sense, especially since nothing else can be going
on at the same time anyway.


I still think a separate tool that scrapes as much data as possible
from the target and pours it into DT form makes more sense than doing
it in a kernel driver, especially since discovered targets may often
still need manual identification.  Also, probing discovered targets
requires you enable the clock(s) they need and if necessary release
local reset.  Auto-discovery of these associations may also be
possible, but probably would become a rather lenghy procedure. A
separate tool can also leave a record of what it's doing in SRAM and
enable the watchdog to be able to recover from probes that lock up the
system (and log a warning about them).

Also, on HS devices, it would surprise me if you're allowed to access
any interconnect registers at all.

Matthijs
