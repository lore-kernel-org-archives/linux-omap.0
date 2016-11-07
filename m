From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/3] Add memremap executable mapping and extend
 drivers/misc/sram.c
Date: Mon, 7 Nov 2016 11:04:44 +0000
Message-ID: <20161107110444.GA23750@n2100.armlinux.org.uk>
References: <20161027185612.22362-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027185612.22362-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2016 at 01:56:09PM -0500, Dave Gerlach wrote:
> There are several instances when one would want to execute out of on-chip
> SRAM, such as PM code on ARM platforms, so once again revisiting this
> series to allow that in a generic manner. Seems that having a solution for
> allowing SRAM to be mapped as executable will help clean up PM code on several
> ARM platforms that are using ARM internal __arm_ioremap_exec API
> and also open the door for PM support on new platforms like TI AM335x and
> AM437x. This was last sent as RFC here [1] and based on comments from Russell
> King and Arnd Bergmann has been rewritten to use memremap API rather than
> ioremap API, as executable iomem does not really make sense.

This is better, as it avoids the issue that I pointed out last time
around, but I'm still left wondering about the approach.

Sure, having executable SRAM mappings sounds nice and easy, but we're
creating WX mappings.  Folk have spent a while improving the security of
the kernel by ensuring that there are no WX mappings, and this series
reintroduces them.  The sad thing is that any WX mapping which appears
at a known address can be exploited.

"A known address" can be something that appears to be random, but ends
up being the same across the same device type... or can be discovered
by some means.  Eg, consider if the WX mapping is dynamically allocated,
but occurs at exactly the same point at boot - and if this happens with
android phones, consider how many of those are out there.  Or if the
address of the WX mapping is available via some hardware register.
Or...

See Kees Cook's slides at last years kernel summit -
	https://outflux.net/slides/2015/ks/security.pdf

So, I think avoiding WX mappings - mappings should be either W or X but
not both simultaneously (see page 19.)

I guess what I'm angling at is that we don't want memremap_exec(), but
we need an API which changes the permissions of a SRAM mapping between
allowing writes and allowing execution.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
