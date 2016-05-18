From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
Date: Wed, 18 May 2016 21:57:59 +0100
Message-ID: <20160518205758.GY5783@n2100.arm.linux.org.uk>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <573C7844.5030107@ti.com>
 <20160518175102.GX5783@n2100.arm.linux.org.uk>
 <3861017.ZJOlWYvEFT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3861017.ZJOlWYvEFT@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 18, 2016 at 10:25:03PM +0200, Arnd Bergmann wrote:
> The ARM version of ioremap_exec() that gets added in this patch is cached
> (like memremap()), but then the asm-generic version is not? This is
> even more confusing, it should at least do roughly the same thing across
> architectures.
> 
> There should also be some documentation about what the expected behavior is, e.g.:
> 
> - is memremap_exec() by default cached or not? (I assume it would
>   be like memremap())
> - If we have an interface that does explicit uncached executable mapping,
>   what about architectures on which this is not possible? Should they
>   fall back to cached or non-executable, or cause a link error?  

Another important point is whether atomic instructions / kernel locks
can be located within the mapped memory.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
