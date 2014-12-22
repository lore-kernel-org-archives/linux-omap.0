From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Mon, 22 Dec 2014 17:28:38 +0000
Message-ID: <20141222172838.GM11502@n2100.arm.linux.org.uk>
References: <5481D913.9040109@ti.com>
 <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna>
 <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk>
 <54897528.4030804@samsung.com>
 <20141222170411.GL11502@n2100.arm.linux.org.uk>
 <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 22, 2014 at 11:12:42AM -0600, Nishanth Menon wrote:
> On Mon, Dec 22, 2014 at 11:04 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > That only leaves the non-DT stuff to worry about this, and from what I
> > understand, that's going to be removed soon.  If we're going to keep
> > the non-DT stuff, we should implement a new machine_desc hook for it
> > instead of hijacking one of the existing callbacks.
> 
> none of the PL310 support requires non-DT. PL310 is needed for OMAP4
> and AM437x both of which are DT only.

Right, so the simple answer for the time being is to kill most of
omap_l2_cache_init(), leaving just the ioremap() behind.  Everything
else can go into the machine_desc structures, and OMAP4 and AM437x
can both benefit from initialising the L2 cache at exactly the same
point as most other platforms.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
