From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/6] omap iommu: entries for Kconfig and Makefile
Date: Mon, 18 May 2009 14:36:47 +0100
Message-ID: <20090518133647.GA5141@n2100.arm.linux.org.uk>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com> <20090505124711.4583.52382.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41355 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZERNg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:36:57 -0400
Content-Disposition: inline
In-Reply-To: <20090505124711.4583.52382.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Tue, May 05, 2009 at 03:47:11PM +0300, Hiroshi DOYU wrote:
> +config OMAP_IOMMU
> +	tristate "IOMMU support"
> +	depends on ARCH_OMAP
> +	default n

default n is the default whatever.  There's no need for the depends line
either - the whole file is protected by an "if ARCH_OMAP".."endif"
encapsulation.
