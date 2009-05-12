From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: linux-omap pm branch
Date: Tue, 12 May 2009 08:53:55 -0700
Message-ID: <871vque2r0.fsf@deeprootsystems.com>
References: <7B4574D56E4ADF438756313E9A172A873958F6A4@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:56920 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136AbZELPyB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 11:54:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so41086rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 08:54:02 -0700 (PDT)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A873958F6A4@dlee01.ent.ti.com> (Jon Hunter's message of "Mon\, 11 May 2009 16\:15\:22 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jon,

"Hunter, Jon" <jon-hunter@ti.com> writes:

> I want to run some tests using the linux-omap pm branch on the omap3430 and had a couple questions...
>
> 1). What omap3430 board(s) are being using to validate the pm branch functionality?

I typically validate on Beagle, OMAP3EVM and RX51.  Some folks in TII
have done some validation on SDP as well.

On SDP, I have noted that CORE powerdomain does not hit retention on
current PM branch yet the same code hits full-chip retention and OFF
on the other OMAP3 boards.  I have not yet fully debugged this and I
haven't heard from other TI folks if they have the same problem.

> 2). Is there a list of pm features are currently supported/functional for omap3430? For example, cpuidle, cpufreq, retention, off-mode, smart-reflex, suspend/restore, etc. 

All of the above.

But as others have mentioned, these are validated on a minimal kernel
since there is still driver/subsystem work required to support PM,
especially the context save/restore needed for off mode.

> 3). Are there any userspace tools (such as powertop) that are
> recommended for monitoring power states?

I use powertop when testing CPUidle, but but some of the in-kernel PM
debug features are also useful.  For example, you can see some
powerdomain and clockdomain accounting by enabling CONFIG_PM_DEBUG and
CONFIG_DEBUG_FS, then mounting debugfs and doing:

# cat /debug/pm_debug/count

Also, there's a patch in the PM branch which saves the PRCM registers
just before jumping to SRAM.  This snapshot can be dumped by doing:

# cat /debug/pm_debug/registers/1

This allows you to use the registers to check if there are any clocks
enabled or any clockactivity.

Kevin
