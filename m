From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Requirement for DSI video mode support
Date: Fri, 08 Oct 2010 13:12:54 +0300
Message-ID: <1286532774.28499.1088.camel@tubuntu.research.nokia.com>
References: <AANLkTikBn63Y1CofZksexds7tBqzxrNvX3MD=tZ49hDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:33892 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757088Ab0JHKM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 06:12:58 -0400
In-Reply-To: <AANLkTikBn63Y1CofZksexds7tBqzxrNvX3MD=tZ49hDw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jorge Bustamante <jbustamante.init@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "m-iovescu1@ti.com" <m-iovescu1@ti.com>, "nm@ti.com" <nm@ti.com>, "archit@ti.com" <archit@ti.com>, "y-qassid@ti.com" <y-qassid@ti.com>, "a-aguirre@ti.com" <a-aguirre@ti.com>

Hi,

On Mon, 2010-09-20 at 22:18 +0200, ext Jorge Bustamante wrote:
> Hi,
> 
> We (TI) have been working on a DSI video mode driver for OMAP4 and I

I hope it's also for OMAP3?

> am aware that other people are working with similar drivers. We had to
> tweak the code to make the drivers work with current code but we would
> like to make it the correct way, that is, introducing a proper
> functionality instead of inserting tweaks in the present command mode
> driver. Therefore, there is an initiative from us to modify current
> dss/dsi code to support DSI video mode.
> 
> We have collected a list of requirements and ideas (with the help of
> ppl copied) from our experience working with these drivers, but it
> would be great if you can discuss/comment further on this.
> 
> Requirements:
> 
> - A better way of exposing VC's to a panel driver, since most panels
> use more than one VC. Currently the design supports only one per
> panel. Perhaps a VC resource pool could be created.

Hmm, why would most panels use more than one VC? I haven't seen a single
one =).

Nevertheless, it should be possible to use multiple VCs in one driver.
I've implemented a driver for a buffer chip that used all 4 channels.
But it's true that there's no allocation of the VCs, so if you have two
panels at the same time, there's no proper way to make sure they don't
use overlapping VCs.

> - A way of imposing restrictions on clock sources based on dsi mode.
> - Runtime calculation of required clocks and PLL parameters. This is
> to reduce complexity in clock calculations, specially when having two
> panels running at the same time.
> - A way to pass specific requirements from panel driver to DSI driver
> (enable/disable BTA, set HS Clk always on, etc).
> - Remove some hardcoded values in dsi.c and make the panel pass the
> information to DSI driver(RX, TX fifo sizes of VCs, enabling/disabling
> dsi timers, etc)
> - A cleaner way of handling both DSI1 and DSI2 blocks(and more in
> omap5) in the same driver.
> - A way to easily set non-burst event mode, non-burst pulse mode and
> burst mode configuration as defined on DSI protocol specs.
> - A way to calculate correct DSI blanking parameters based on panel
> blanking requirements (for DSI Video panels, these will be have to be
> specified statically somewhere, much like DPI displays).
> - Remove timeout error/warnings when disabling dsi phy interface since
> on video mode it should wait instead for next vsync.

These are sound good to me.

> Design ideas:
> 
> - It could actually be worthwhile to have separate files for command
> and video mode and a core dsi driver file.

I think that's a good choice. At some point I thought of separating DSI
PLL, CIO and core stuff to separate files, but I never had time. And it
would also mean making lots of functions non-static.

> - We can have a enum like this to choose between modes:
> 
> plat/display.h can have an enum like:
> enum omap_dss_dsi_mode {
>     OMAP_DSS_DSI_CMDMODE   = 1 << 0,
>     OMAP_DSS_DSI_VIDEOMODE = 1 << 1,
> 
> };
> Nit pick - either make it #define and have bit offset as above OR
> Better still, you wont need both at the same time, so bit offset wont be
> useful too much.. OMAP_DSS_DSI_CMDMODE = 1, OMAP_DSS_DSI_VIDEOMODE = 2,
> 
> - If we want a user to switch between modes, we may need to have a

While I don't see any reason to forbid changing modes, I don't see any
real reason to implement switching between the modes either. If it comes
for free, sure, but if it means lots of implementation, I'd rather leave
it out. Or do you have some use cases where switching modes is
important?

 Tomi


