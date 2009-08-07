From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Fri, 7 Aug 2009 23:00:16 +0100
Message-ID: <20090807220016.GG31543@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36744 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZHGWA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 18:00:26 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Aug 08, 2009 at 01:46:35AM +0530, Syed Mohammed, Khasim wrote:
> On OMAP3 we are creating a space for DSP components to have shared
> buffers using the boot arguments.
> 
> mem=88M@0x80000000 mem=128M@0x88000000

Ensure that you have ARCH_HAS_HOLES_MEMORYMODEL enabled in the
configuration - you need OMAP3 to select this symbol.
