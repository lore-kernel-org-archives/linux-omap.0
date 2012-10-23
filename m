From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS interface; use platform_data fn ptr
Date: Tue, 23 Oct 2012 10:03:25 +0200
Message-ID: <20121023080325.GZ16482@spo001.leaseweb.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013233.21844.1279.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:37321 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756743Ab2JWID0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 04:03:26 -0400
Content-Disposition: inline
In-Reply-To: <20121016013233.21844.1279.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org

Hi Paul,

> Previously the OMAP watchdog driver used a non-standard way to report
> the chip reset source via the GETBOOTSTATUS ioctl.  This patch
> converts the driver to use the standard WDIOF_* flags for this
> purpose.
> 
> This patch may break existing userspace code that uses the existing
> non-standard data format returned by the OMAP watchdog driver's
> GETBOOTSTATUS ioctl.  To fetch detailed reset source information,
> userspace code will need to retrieve it directly from the CGRM or PRM
> drivers when those are completed.
> 
> Previously, to fetch the reset source, the driver either read a
> register outside the watchdog IP block (OMAP1), or called a function
> exported directly from arch/arm/mach-omap2.  Both approaches are
> broken.  This patch also converts the driver to use a platform_data
> function pointer.  This approach is temporary, and is due to the lack
> of drivers for the OMAP16xx+ Clock Generation and Reset Management IP
> block and the OMAP2+ Power and Reset Management IP block.  Once
> drivers are available for those IP blocks, the watchdog driver can be
> converted to call exported drivers from those functions directly.
> At that point, the platform_data function pointer can be removed.
> 
> In the short term, this patch is needed to allow the PRM code to be
> removed from arch/arm/mach-omap2 (it is being moved to a driver).
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

