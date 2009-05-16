From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Sat, 16 May 2009 17:36:35 +0100
Message-ID: <20090516163635.GB25657@n2100.arm.linux.org.uk>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45588 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbZEPQgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 12:36:42 -0400
Content-Disposition: inline
In-Reply-To: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrote:
> This patch series cleanups up a bit the opap3-iommu device registration and
> then allows registration from other parts of the code.
> 
> Currently the iva2 code (tidspbridge) is not using iommu, therefore it can't be
> used as-is with the current omap iommu. By allowing devies to be registered
> externaly (either isp, or iva2) this problem goes away.

Hmm, so does this mean that the iommu patchset is going to grow by three
patches?  Hope not.

Also, please ensure that you address my other comments, some of which do
seem applicable to your cleanups as well - eg, the __initdata one.
