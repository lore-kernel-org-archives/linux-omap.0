From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: am335x crypto module clocks
Date: Fri, 17 Apr 2015 07:13:37 +0200
Message-ID: <CAALWOA9t5GFZESoLS=HUmEtEb5wAYbA=zmSoHs5nX=BR_BXz3w@mail.gmail.com>
References: <CAALWOA8Zno6pTfWRZpacgWm83m4=1+uvTmyREG9Nc+C2MZjK1w@mail.gmail.com>
 <20150409151338.GQ18048@atomide.com> <552B9A1C.9010802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35900 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbDQFN7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2015 01:13:59 -0400
Received: by wizk4 with SMTP id k4so8328604wiz.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2015 22:13:58 -0700 (PDT)
In-Reply-To: <552B9A1C.9010802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 13 April 2015 at 12:27, Tero Kristo <t-kristo@ti.com> wrote:
> pka/rng/des is using l4ls_gclk.

Does any instance of subarctic actually have a working DES
accelerator? Looking at the L4LS memory map, the only plausible
location for it would be 0x48315000 (sec context) / 0x48316000 (pub
context), but after enabling it manually in PRCM I still get a bus
error on attempt to read the version register (offset 0x30) through
either context.

(Of course it doesn't seem likely that anyone will miss it anyway...)


The PKA does appear to work, but it's missing from the hwmod data and
device tree. Given the TRM's (annoying) usual silence on crypto
modules, I'll summarize the relevant integration info I have:

For device-tree:
        pka: pka@48318000 {
                reg = <0x48318000 0x4000>;
                interrupts = <110>;
        };

Relevant wrapper registers:
0x1fe0  revision (highlander format)
0x1ff0  sysconfig
0x1ff4  sysstatus
0x1ff8  irq rawstatus
0x1ffc  irq enabled

For sysconfig, looks like bit 0 is autoidle, bit 1 reset, bits 4-5
(oddly) seem to be idlemode, though any mode other than force-idle
(the reset default) behaves like no-idle.

Clkctrl register is at offset 0xa4.

To be honest I don't understand all the hwmod stuff well enough yet to
attempt a patch myself.
