From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] twl4030 reboot workaround
Date: Wed, 28 Jul 2010 13:18:11 +0300
Message-ID: <20100728101811.GA543@nokia.com>
References: <1265226207-22971-3-git-send-email-mturquette@ti.com> <1280310092-27260-1-git-send-email-ext-mikko.rapeli@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47331 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab0G1KSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 06:18:55 -0400
Content-Disposition: inline
In-Reply-To: <1280310092-27260-1-git-send-email-ext-mikko.rapeli@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rapeli Mikko (EXT-Ixonos/Oulu)" <ext-mikko.rapeli@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mturquette@ti.com" <mturquette@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Wed, Jul 28, 2010 at 11:41:32AM +0200, Rapeli Mikko (EXT-Ixonos/Oulu) wrote:
> From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
> 
> Original patch: http://marc.info/?l=linux-omap&m=126522625032441&w=2
> 
> "Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
> necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
> in the sleep script being executed on TWL4030. This usually results in
> VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
> MPU Watch Dog reset or worse, an irrecoverable hang."
> 
> Original patch resulted in a crash due to sleeping i2c calls late in the
> reboot sequence. Here's how to trigger the crash:
> 
> 	# cat /dev/urandom > /foo &
> 	sync();
>         reboot(LINUX_REBOOT_CMD_RESTART2);
> 
> Kernel trace from 2.6.32:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 805 [#2] PREEMPT
> ...
> [<c00b3210>] (exit_mmap+0x1d4/0x1f8) from [<c006069c>] (mmput+0x34/0x110)
> [<c006069c>] (mmput+0x34/0x110) from [<c0064a90>] (exit_mm+0x140/0x180)
> [<c0064a90>] (exit_mm+0x140/0x180) from [<c00668ec>] (do_exit+0x5d8/0x6ac)
> [<c00668ec>] (do_exit+0x5d8/0x6ac) from [<c0035858>] (die+0x2d4/0x2e0)
> [<c0035858>] (die+0x2d4/0x2e0) from [<c0035904>] (baddataabort+0x0/0x50)
> [<c0035904>] (baddataabort+0x0/0x50) from [<c0274ff4>] (i2c_transfer+0xec/0x104)
> [<c0274ff4>] (i2c_transfer+0xec/0x104) from [<00000001>] (0x1)
> 
> Fix is to move reboot preparations into a reboot notifier.
> 

And what if we get an OMAP3 watchdog reset ? In this case there is no
software to remove the script...

Cheers,

Peter.
