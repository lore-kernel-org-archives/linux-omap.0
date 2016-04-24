From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: qemu:beagle no longer booting with omap2plus_defconfig in -next
Date: Sun, 24 Apr 2016 21:28:31 +0200
Message-ID: <20160424212831.3c44d72e@bbrezillon>
References: <571BB682.1010806@roeck-us.net>
	<20160423214617.4d0905d2@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160423214617.4d0905d2@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Roger Quadros <rogerq@ti.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 23 Apr 2016 21:46:17 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> And the other question I have for Roger is, do you see a reason why the
> rb-gpio mode would not work?
> 

Forget that one, this bug appeared to be caused by partial emulation of
the GPMC block in qemu.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
