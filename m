From: David Sin <davidsin@ti.com>
Subject: Re: [PATCH 0/9] TI DMM-TILER driver
Date: Thu, 16 Dec 2010 11:25:36 -0600
Message-ID: <20101216172531.GG29435@lba0869738>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com>
 <201012161434.05768.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100Ab0LPRNQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 12:13:16 -0500
Content-Disposition: inline
In-Reply-To: <201012161434.05768.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kgunn@ti.com
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Dec 16, 2010 at 02:34:05PM +0100, Arnd Bergmann wrote:
> On Monday 06 December 2010, David Sin wrote:
> > Tiling and Isometric Lightweight Engine for Rotation (TILER) driver
> > =====
> > 
> > Dynamic Memory Manager (DMM) is a hardware block made by Texas Instruments.
> > Within the DMM exists at least one TILER hardware component.  Its purpose is to
> > organize video/image memory in a 2-dimensional fashion to limit memory
> > bandwidth and facilitate 0 effort rotation and mirroring.  The TILER driver
> > facilitates allocating, freeing, as well as mapping 2D blocks (areas) in the
> > TILER container(s).  It also facilitates rotating and mirroring the allocated
> > blocks or its rectangular subsections.
> 
> How does this relate to DRM/GEM? I don't understand too much about graphics
> drivers, but it does sound like there is some overlap in functionality.
> 
> I guess at the very least the DMM should live in drivers/gpu/ instead of
> drivers/misc, but perhaps it could be integrated more closely with the
> existing code there.
> 
> 	Arnd
Do you know if anyone on your team is familiar with DRM/GEM (grap ext mgr) 
for x86?  I'm trying to understand the differences and make a case that 
 it's not the same as DMM/TILER.  

thanks,
-- 
David Sin
