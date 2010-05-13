From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 13 May 2010 14:19:51 -0700
Message-ID: <20100513211951.GH3428@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
 <20100505150209.GC2606@n2100.arm.linux.org.uk>
 <20100513174023.GB13001@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63538 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab0EMVUC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 17:20:02 -0400
Content-Disposition: inline
In-Reply-To: <20100513174023.GB13001@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10:35]:
> And here's a patch which converts the OMAP FB code to use lmb_reserve
> instead of poking about with bootmem stuff.  Untested, so I'd like to
> hear back whether it works.

Did a quick test with the following patches picked from your lmb
branch on top of omap for-next branch:

ARM: Remove useless linux/bootmem.h includes
ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
ARM: initial LMB trial
ARM: Move platform LMB memory reservations out of generic code

and then this patch.

It does not boot.. It seems to be related to the patch
"ARM: initial LMB trial". If I only apply the first two patches
above the system boots.

Otherwise it only boots to:

Linux version 2.6.34-rc7-08102-ga1a6e35 ...
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f  
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Nokia RX-51 board                                       
Ignoring unrecognised tag 0x414f4d50                             
bootconsole [earlycon0] enabled                                  
Memory policy: ECC disabled, Data cache writeback

Regards,

Tony
