From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Mon, 18 May 2009 14:03:05 +0100
Message-ID: <20090518130305.GE3067@n2100.arm.linux.org.uk>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com> <20090518120717.GA3067@n2100.arm.linux.org.uk> <94a0d4530905180559k4b3e13e9xd947ae8cb8849b66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56386 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZERNDP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:03:15 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530905180559k4b3e13e9xd947ae8cb8849b66@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, Felipe Contreras <felipe.contreras@nokia.com>

On Mon, May 18, 2009 at 03:59:42PM +0300, Felipe Contreras wrote:
> So resource_size_t is ok for 'base'?

Yes.
