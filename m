From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Wed, 9 Jan 2013 11:48:09 +0000
Message-ID: <201301091148.09320.arnd@arndb.de>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <20130109081131.GH21994@gmail.com>
 <CACRpkdbx7ptCugpc1+JC5Yk+n835goOuoF6q0pdizsjpZ-G9mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdbx7ptCugpc1+JC5Yk+n835goOuoF6q0pdizsjpZ-G9mQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 January 2013, Linus Walleij wrote:
> On Wed, Jan 9, 2013 at 9:11 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Tue, 08 Jan 2013, Arnd Bergmann wrote:
> >> I don't remember the details unfortunately. Lee should be the one who can find out.
> >> IIRC there was at least a single integeger number on them.
> >
> > Not as far as I can remember. There was (is?) a crude method of
> > identifying UIBs, but attempting to obtain certain I2C lines and
> > testing which ones were accessible. However, if there is an issue
> > with I2C, the wrong UIB was 'probed'.
> 
> Right, so the UIBs had different GPIO expanders on some I2C addresses,
> so we attempt to communicate with the expander to see if it's board type A,
> and if it doesn't respond it's deemed to be board type B.
> 
> This is the code:
> arch/arm/mach-ux500/board-mop500-uib.c

Ok, no idea what I was confusing it with then.

> Compare this other case: the Integrator has pluggable daughterboards,
> (called LMs, logic modules) and in that case we have specific registers
> to detect them, and register the daughter board on this specific bus
> that Russell came up with in arch/arm/mach-integrator/lm.c,
> the actual board detection is in arch/arm/mach-integrator/integrator_ap.c:
> 
> static void __init ap_init(void)
> {
>         unsigned long sc_dec;
>         int i;
> 
>         platform_device_register(&cfi_flash_device);
> 
>         sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
>         for (i = 0; i < 4; i++) {
>                 struct lm_device *lmdev;
> 
>                 if ((sc_dec & (16 << i)) == 0)
>                         continue;
> 
>                 lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
>                 if (!lmdev)
>                         continue;
> 
>                 lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
>                 lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
>                 lmdev->resource.flags = IORESOURCE_MEM;
>                 lmdev->irq = IRQ_AP_EXPINT0 + i;
>                 lmdev->id = i;
> 
>                 lm_device_register(lmdev);
>         }
> 
>         integrator_init(false);
> }
> 
> In this case I think the autodetect is so nice that device tree probing
> is mostly pointless. If it wasn't for the fact that we get a
> cross-depenency to defined interrupts and clocks and whatever that
> are coming from the device tree. Which is where DT shows its
> all-or-nothing face.

Well, the extension bus above can easily be represented as a single device
with four interrupts and four memory ranges. The child devices don't
have to show up in DT at all, since they can be detected, but the detection
mechanism should be there. This is the same as PCI devices, where we have
to describe the host controller, but not the add-on cards.

> So to get an elegant DT probing in this case I *guess* the right thing
> to do is to dynamically add nodes to the device tree from the board
> code, or have all alternatives inside the DT marked "disable" and then
> mark them as "okay" from the board code by modifying the DT at
> runtime.

That would also work, but I think the other way is simpler.

	Arnd
