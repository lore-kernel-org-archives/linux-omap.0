From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] rtc: ds1307: Use irq when available for wakeup-source
 device
Date: Wed, 20 Apr 2016 00:56:55 +0200
Message-ID: <20160419225655.GJ29844@piout.net>
References: <1461083034-9227-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461083034-9227-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Lange <linuxstuff@milaw.biz>
List-Id: linux-omap@vger.kernel.org

On 19/04/2016 at 11:23:54 -0500, Nishanth Menon wrote :
> With commit 8bc2a40730ec ("rtc: ds1307: add support for the
> DT property 'wakeup-source'") we lost the ability for rtc irq
> functionality for devices that are actually hooked on a real IRQ
> line and have capability to wakeup as well. This is not an expected
> behavior. So, instead of just not requesting IRQ, skip the IRQ
> requirement only if interrupts are not defined for the device.
> 
> Fixes: 8bc2a40730ec ("rtc: ds1307: add support for the DT property 'wakeup-source'")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Cc: Michael Lange <linuxstuff@milaw.biz>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
>  drivers/rtc/rtc-ds1307.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
