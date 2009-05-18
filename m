From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 13:11:13 +0100
Message-ID: <20090518121113.GB3067@n2100.arm.linux.org.uk>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51555 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbZERMLU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:11:20 -0400
Content-Disposition: inline
In-Reply-To: <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, May 16, 2009 at 01:05:50PM +0300, Felipe Contreras wrote:
> This allows devices to be registered only when they are used. The
> current dsp-bridge driver for example is not using iommu so registering
> the iommu iva2 device would conflict. By allowing remote registration
> the dsp-bridge can decide when the iommu iva2 device is registered.

I don't think that this is a good idea - what happens if two people
call omap_iommu_add() for the same IOMMU device independently?

The real problem here seems to be the TI DSP bridge code, and if that's
the case why can't we just avoid registering IVA2 if the TI DSP bridge
code is enabled.  That solves your stated problem without creating
additional management issues.
