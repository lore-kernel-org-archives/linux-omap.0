From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/2] memory: Introduce ti-emif-sram driver
Date: Fri, 1 Dec 2017 09:54:18 -0800
Message-ID: <20171201175418.GS28152@atomide.com>
References: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [171130 22:58]:
> This is a resend of v5 of this series found here [1]. It introduces
> relocatable PM handlers for the emif that are copied to sram and
> run from there during low power mode entry.
> 
> The patches still have the previous ACKs but have a small change to
> accomodate a change made by Tony in commit cd57dc5a2099 ("ARM: dts:
> Add missing hwmod related nodes for am33xx"). If there are objections
> to this let me know ASAP.

Still looks good to me thanks.

> Now that a hwmod is present for the am335x EMIF, on probe fail the call to
> pm_runtime_put_sync causes the board to hang. In fact, this emif driver should
> never alter the PM state of the hardware at all through normal kernel calls, it
> is the job of the suspend handlers that are added, that is the whole point of
> this driver. Because of this, I have dropped all runtime pm calls, as any
> change to the PM state while the kernel is running is dangerous as we may shut
> of the memory controller. It makes the most sense just to drop runtime PM from
> the driver entirely. Besides that patch is unchanged.

OK makes sense to me.

Regards,

Tony
