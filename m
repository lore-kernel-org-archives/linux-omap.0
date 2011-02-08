From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 13:11:51 +0100
Message-ID: <201102081311.52004.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <20110208110808.GA22877@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51872 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab1BHMMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 07:12:03 -0500
In-Reply-To: <20110208110808.GA22877@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tuesday 08 February 2011, Russell King - ARM Linux wrote:
> On Tue, Feb 08, 2011 at 11:01:25AM +0000, Dave Martin wrote:
> > For v6, wfi is architected as a defined MCR instruction, so
> > use that definition.
> > 
> > Doing a no-op instead of wfi() is probably bad, so for older
> > processors than v6, wfi() is not defined.  If needed, some CPU-
> > specific wfi() will have to be defined elsewhere.
> 
> This is something we kind-of already handle in a different way - see
> the individual processor idle function in arch/arm/mm/proc*.S.
> 
> There's various errata work-arounds older CPUs need for wfi (or rather
> its mcr equivalent) so maybe wfi() should just be an alias for a call
> to that function.  Or maybe we shouldn't have a wfi() macro at all.

I don't see any users of the sev/wfe/wfi macros in the current kernel,
so removing them seems like a good strategy to avoid people from
using them incorrectly.

If the definitions differ between v5/v6/v7 CPUs, any common code
using them would need to do either binary patching of some sort
or abstract the difference between the CPU in some other way.

Dave, what code do you have in mind as a possible user?

	Arnd
