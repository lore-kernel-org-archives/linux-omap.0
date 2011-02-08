From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 12:22:06 +0000
Message-ID: <20110208122205.GA5903@arm.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
 <20110208110808.GA22877@n2100.arm.linux.org.uk>
 <201102081311.52004.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53487 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1BHMWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 07:22:17 -0500
Received: by wyb28 with SMTP id 28so5636720wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 04:22:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102081311.52004.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

> > On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> > > For v6, wfi is architected as a defined MCR instruction, so
> > > use that definition.

[...]

On Tue, Feb 08, 2011 at 01:11:51PM +0100, Arnd Bergmann wrote:
> I don't see any users of the sev/wfe/wfi macros in the current kernel,
> so removing them seems like a good strategy to avoid people from
> using them incorrectly.
> 
> If the definitions differ between v5/v6/v7 CPUs, any common code
> using them would need to do either binary patching of some sort
> or abstract the difference between the CPU in some other way.
> 
> Dave, what code do you have in mind as a possible user?

The OMAP BSP has its own version of this, which I'm suggesting
to port to the more generic macros in system.h, now that they
exist.

---Dave
