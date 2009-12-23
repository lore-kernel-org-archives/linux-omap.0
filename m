From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Amba device porting
Date: Wed, 23 Dec 2009 16:50:09 +0000
Message-ID: <20091223165009.GA13900@n2100.arm.linux.org.uk>
References: <20091223101902.GA15537@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49116 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbZLWQxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 11:53:06 -0500
Content-Disposition: inline
In-Reply-To: <20091223101902.GA15537@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman <roman.tereshonkov@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Dec 23, 2009 at 12:19:02PM +0200, Roman wrote:
> Hi,
> 
> I planned to port the omap3 SDTI (Serial Debug Trace Interface) driver to amba based interface.
> 
> SDTI memory map is two parts composed:
> 0x54500000 0x5450FFFF 4KB       SDTI module (configuration) - coresight based format.
> 0x54510000 0x545FFFFF 1984KB    Reserved
> 0x54600000 0x546FFFFF 1MB       SDTI module (window)
> 
> But amba interface seems to support only one memory region resource.

The 'amba' interface is more a primecell interface.  Is SDTI a primecell
peripheral?  If not, then it shouldn't be using the AMBA "primecell" bus
support.
