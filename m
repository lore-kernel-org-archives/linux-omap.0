From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 18/27] mtd: nand: omap2: Implement NAND ready using
 gpiolib
Date: Tue, 27 Oct 2015 09:12:35 +0100
Message-ID: <20151027091235.03dba8c5@bbrezillon>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
	<1442588029-13769-19-git-send-email-rogerq@ti.com>
	<20151026204900.GI13239@google.com>
	<562F2FB6.7050806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562F2FB6.7050806@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>, Harvey Hunt <harvey.hunt@imgtec.com>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, 27 Oct 2015 10:03:02 +0200
Roger Quadros <rogerq@ti.com> wrote:

> On 26/10/15 22:49, Brian Norris wrote:
> > 
> > Others have been looking at using GPIOs for the ready/busy pin too. At a
> > minimum, we need an updated DT binding doc for this, since I see you're
> > adding this via device tree in a later patch (I don't see any DT binding
> > patch for this; but I could just be overlooking it). It'd also be great
> > if this support was moved to nand_dt_init() so other platforms can
> > benefit, but I won't require that.
> > 
> > Also, previous [0] proposers had suggested 'rb-gpios', not 'ready-gpio'
> > (the hardware docs typically call it 'rb' for ready/busy, FWIW). I don't
> > really care, but the name should be going into a doc, so we can choose
> > the same one everywhere.
> > 
> > EDIT: looks like the discussion was partly here [1] and it seems we're
> > landing on "rb-gpios" in the latest version [2]. Can we stick with that?
> 
> Why should it be "rb-gpios" and not "rb-gpio"?
> I don't think there are multiple gpios for r/b# function.

Because it's supposed to be a generic binding, and some NAND chips
embed several dies, thus exposing several CS and RB pins, hence the
rb-gpios name.
Also, as described here [1], the convention is to name your property
<name>-gpios even if you only need one gpio.

Best Regards,

Boris

[1]http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/gpio/gpio.txt#L16



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
