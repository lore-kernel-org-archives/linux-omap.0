From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] [PATCH] rtc: ds1307: fix kernel splat due to wakeup
 irq handling
Date: Wed, 25 Nov 2015 12:05:10 +0100
Message-ID: <20151125110510.GM3950@piout.net>
References: <1447258261-2102-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1447258261-2102-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 11/11/2015 at 10:11:01 -0600, Felipe Balbi wrote :
> Since commit 3fffd1283927 ("i2c: allow specifying
> separate wakeup interrupt in device tree") we have
> automatic wakeup irq support for i2c devices. That
> commit missed the fact that rtc-1307 had its own
> wakeup irq handling and ended up introducing a
> kernel splat for at least Beagle x15 boards.
> 
> Fix that by reverting original commit _and_ passing
> correct interrupt names on DTS so i2c-core can
> choose correct IRQ as wakeup.
> 
> Now that we have automatic wakeirq support, we can
> revert the original commit which did it manually.
> 
> Fixes the following warning:
> 
> [   10.346582] WARNING: CPU: 1 PID: 263 at linux/drivers/base/power/wakeirq.c:43 dev_pm_attach_wake_irq+0xbc/0xd4()
> [   10.359244] rtc-ds1307 2-006f: wake irq already initialized
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |  1 +
>  drivers/rtc/rtc-ds1307.c                | 36 +++------------------------------
>  2 files changed, 4 insertions(+), 33 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
