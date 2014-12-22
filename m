From: Nishanth Menon <nm@ti.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Mon, 22 Dec 2014 11:12:42 -0600
Message-ID: <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
References: <5481D913.9040109@ti.com>
	<5481D9BF.2090007@ti.com>
	<20141209165746.GA29935@kahuna>
	<54881589.20105@samsung.com>
	<20141211092945.GE11502@n2100.arm.linux.org.uk>
	<54897528.4030804@samsung.com>
	<20141222170411.GL11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20141222170411.GL11502@n2100.arm.linux.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 22, 2014 at 11:04 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
>
> Nishanth - can we push OMAP over to using the generic DT L2C
> initialisation (the one from init_IRQ in arch/arm/kernel/irq.c) and
> kill the SoC specific stuff in arch/arm/mach-omap2/omap4-common.c ?
>
> From what I can see, in the DT case, the only thing which is used
> there is the ioremap() to provide omap4_get_l2cache_base() with
> something to return.  Everything else - the initialisation of the
> l2c_write_sec pointer, and the aux mask and values - can be specified
> via the machine_desc struct.

I think this is what Marek proposed. I had requested for patches to be
reposted with linux-omap in CC so that we can test and provide
feedback.

>
> That only leaves the non-DT stuff to worry about this, and from what I
> understand, that's going to be removed soon.  If we're going to keep
> the non-DT stuff, we should implement a new machine_desc hook for it
> instead of hijacking one of the existing callbacks.

none of the PL310 support requires non-DT. PL310 is needed for OMAP4
and AM437x both of which are DT only.


-- 
---
Regards,
Nishanth Menon
