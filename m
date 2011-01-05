From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS
 entry
Date: Wed, 5 Jan 2011 08:51:25 +0200
Message-ID: <20110105065124.GD2458@legolas.emea.dhcp.ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
 <1294142577-28772-3-git-send-email-balbi@ti.com>
 <20110104140031.GE25121@pengutronix.de>
 <20110104173301.GA25976@n2100.arm.linux.org.uk>
 <20110104205445.GF25121@pengutronix.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TYecfFk8j8mZq+dy"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:55145 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169Ab1AEGva (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 01:51:30 -0500
Received: by mail-ey0-f180.google.com with SMTP id 18so6476551eyf.25
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 22:51:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104205445.GF25121@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Tue, Jan 04, 2011 at 09:54:45PM +0100, Uwe Kleine-König wrote:
> > If you look at kernel/irq/Kconfig (as I did with the original patch)
> > you'd notice kernel/irq/Kconfig defines both of these symbols being
> > removed when HAVE_GENERIC_HARDIRQS is enabled.
> > 
> > If you read the discussion in the previous version of this patch set,
> > you'd notice that the removal of this was specifically requested.
> > 
> > It's very tiresome to have to re-explain these things.  Please take
> > some more time to research the points you bring up, rather than
> I don't agree here 100%.  IMHO the commit log was not good enough for
> the change introduced by the patch (and Felipe's reply suggests that he
> agrees).  I could still research it, but:
> 
>  - it was not obvious for me there was a previous version (no "v2" or
>    similar in the patch subject);
>  - for me it would take say 5 minutes to check, the author knows
>    the answer to my question immediately (at least he should);
>  - after a research I could suggest a better wording, but I don't care
>    much if it's me or Felipe who comes up with a better text.
> 
> So all in all I'm still confident that my mail was OK.

No need to fight over a simple change, here it is updated.

-- 
balbi

--TYecfFk8j8mZq+dy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-arm-Kconfig-remove-duplicated-GENERIC_HARDIRQS-entry.diff"

>From cf332402a5476d7aaa9bada6b895430ba7bfa3fe Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Tue, 4 Jan 2011 12:38:24 +0200
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
Organization: Texas Instruments\n

GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
so it's safe to drop the duplicated entry and simply
select HAVE_GENERIC_HARDIRQS. While at that, also
remove GENERIC_HARDIRQS_NO__DO_IRQ because it's also
defined under kernel/irq/Kconfig when
HAVE_GENERIC_HARDIRQS is selected.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c0..e6f0f8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_GENERIC_HARDIRQS
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
@@ -88,10 +89,6 @@ config MCA
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
 config STACKTRACE_SUPPORT
 	bool
 	default y
@@ -171,9 +168,6 @@ config FIQ
 config ARCH_MTD_XIP
 	bool
 
-config GENERIC_HARDIRQS_NO__DO_IRQ
-	def_bool y
-
 config ARM_L1_CACHE_SHIFT_6
 	bool
 	help
-- 
1.7.3.4.598.g85356


--TYecfFk8j8mZq+dy--
