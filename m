From: Paul Walmsley <paul@pwsan.com>
Subject: Re: State of LDP3430 platform
Date: Tue, 7 Dec 2010 17:50:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com> <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com> <20101207083720.GB18336@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48506 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab0LHAuB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 19:50:01 -0500
In-Reply-To: <20101207083720.GB18336@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Tue, 7 Dec 2010, Russell King - ARM Linux wrote:

> So LDP will remain unusable until after the 2.6.38 merge window?

I don't think that Tony or I realized that LDP3430 was broken until your 
E-mail.  Usually I use a BeagleBoard 35xx for OMAP3430 testing, and I 
think Tony uses an Overo.  The BeagleBoard boots cleanly with v2.6.37-rc5.

I do have a LDP3430 here though.  It doesn't boot past:

[    0.000000] Linux version 2.6.37-rc5 (paul@twilight) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #68 SMP Tue Dec 7 17:42:20
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: OMAP Zoom2 board
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000

Looking into it now.


- Paul
