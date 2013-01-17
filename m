From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Thu, 17 Jan 2013 11:20:27 +0100
Message-ID: <CACRpkdZ8hgV_=ev8Kcq=i7K15jrvwW+Or7p+=8fP+8Rb7GGvTQ@mail.gmail.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <20130109081131.GH21994@gmail.com>
 <CACRpkdbx7ptCugpc1+JC5Yk+n835goOuoF6q0pdizsjpZ-G9mQ@mail.gmail.com>
 <201301091148.09320.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201301091148.09320.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 9, 2013 at 12:48 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Wednesday 09 January 2013, Linus Walleij wrote:

>> static void __init ap_init(void)
>> {
>>         unsigned long sc_dec;
>>         int i;
>>
>>         platform_device_register(&cfi_flash_device);
>>
>>         sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
>>         for (i = 0; i < 4; i++) {
>>                 struct lm_device *lmdev;
>>
>>                 if ((sc_dec & (16 << i)) == 0)
>>                         continue;
>>
>>                 lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
>>                 if (!lmdev)
>>                         continue;
>>
>>                 lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
>>                 lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
>>                 lmdev->resource.flags = IORESOURCE_MEM;
>>                 lmdev->irq = IRQ_AP_EXPINT0 + i;
>>                 lmdev->id = i;
>>
>>                 lm_device_register(lmdev);
>>         }
>>
>>         integrator_init(false);
>> }
>>
>> In this case I think the autodetect is so nice that device tree probing
>> is mostly pointless. If it wasn't for the fact that we get a
>> cross-depenency to defined interrupts and clocks and whatever that
>> are coming from the device tree. Which is where DT shows its
>> all-or-nothing face.
>
> Well, the extension bus above can easily be represented as a single device
> with four interrupts and four memory ranges. The child devices don't
> have to show up in DT at all, since they can be detected, but the detection
> mechanism should be there. This is the same as PCI devices, where we have
> to describe the host controller, but not the add-on cards.

Right, so the picture is more complex.

Each logic module / plug-in card spawn a set of struct amba_device
primecells.

Each of them need clocks and interrupts. These are then cascaded
from the clocks/irqs on the main board.

>> So to get an elegant DT probing in this case I *guess* the right thing
>> to do is to dynamically add nodes to the device tree from the board
>> code, or have all alternatives inside the DT marked "disable" and then
>> mark them as "okay" from the board code by modifying the DT at
>> runtime.
>
> That would also work, but I think the other way is simpler.

So when taking into account that the daugther boards are not just
spawning themselves but a number of devices in turn, I thin
it's the only way...

I will get to tackle this when I've converted the Integrator PCI to DT
and removed the Integrator boardfiles.

Yours,
Linus Walleij
