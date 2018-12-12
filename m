From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Date: Wed, 12 Dec 2018 09:25:55 -0800
Message-ID: <20181212172555.GH6707@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
 <20181123163742.GC53235@atomide.com>
 <5BFBAA24.1070503@ti.com>
 <20181126193332.GO53235@atomide.com>
 <5C112DB6.9090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C112DB6.9090605@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181212 15:48]:
> On 26/11/18 21:33, Tony Lindgren wrote:
> >>> So are there any reasons why this could not be just a regular
> >>> drivers/irqchip driver nowadays?
> >>
> >> This is a reqular irqchip driver. Do you mean it should be moved
> >> to drivers/irqchip directory?
> > 
> > I think so, is there something preventing doing it?
> > 
> No.

OK great.

> > Also, is this maybe the same INTC that we already have a
> > driver for in drivers/irqchip/irq-omap-intc.c?
> 
> No, it is completely different.

OK thanks for checking that.

Regards,

Tony
