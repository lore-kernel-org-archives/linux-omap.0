From: David Sin <davidsin@ti.com>
Subject: Re: [PATCH 0/9] TI DMM-TILER driver
Date: Thu, 16 Dec 2010 13:02:08 -0600
Message-ID: <20101216190207.GC6767@lba0869738>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com>
 <20101216172531.GG29435@lba0869738>
 <20101216173737.GA6767@lba0869738>
 <201012161843.48262.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201012161843.48262.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 16, 2010 at 06:43:48PM +0100, Arnd Bergmann wrote:
> As far as I can tell, both DMM and GEM at a high level manage objects
> in video memory. The IOMMU that you have on the Omap hardware seems
> to resemble the GART that sits between PC-style video cards and main
> memory.
> 
> I don't know any details, but google quickly finds
> http://lwn.net/Articles/283798/ with a description of the
> initial GEM design. My main thought when looking over the
> DMM code was that this should not be tied too closely to a
> specific hardware, and GEM seems to be an existing abstraction
> that may fit what you need.
> 
> 	Arnd
Thanks for the pointer, Arnd.  I also found a nice readme file in 
the gpu/drm directory, which points to a wiki and source code.  
I'll read into this and get back to you.

BR,
-- 
David Sin
