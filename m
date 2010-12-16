From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] TI DMM-TILER driver
Date: Thu, 16 Dec 2010 18:43:48 +0100
Message-ID: <201012161843.48262.arnd@arndb.de>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com> <20101216172531.GG29435@lba0869738> <20101216173737.GA6767@lba0869738>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101216173737.GA6767@lba0869738>
Sender: linux-kernel-owner@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 16 December 2010 18:37:38 David Sin wrote:
> I'm not sure exactly how DRM/GEM works..  What functionality do you think is 
> overlapping?  The main feature, aside from reduced page accesses, of the DMM 
> hw block is to provide physically contiguous 2 dimensional memory blocks for 
> image and video processing.  This hw sits between the interconnect and the 
> ext memory interface in the OMAP, and contains an MMU-like address traslator 
> for "virtually" physically contiguous memory and sdram pages.

As far as I can tell, both DMM and GEM at a high level manage objects
in video memory. The IOMMU that you have on the Omap hardware seems
to resemble the GART that sits between PC-style video cards and main
memory.

I don't know any details, but google quickly finds
http://lwn.net/Articles/283798/ with a description of the
initial GEM design. My main thought when looking over the
DMM code was that this should not be tied too closely to a
specific hardware, and GEM seems to be an existing abstraction
that may fit what you need.

	Arnd
