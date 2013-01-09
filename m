From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Wed, 9 Jan 2013 11:56:59 +0200
Message-ID: <57EDCDB4-2AC9-4052-BBA6-9F4A5D3C3D8C@antoniou-consulting.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <201301081212.29089.arnd@arndb.de>
 <51A6DFCC-BBC8-475D-88C4-1B22186339C1@antoniou-consulting.com>
 <201301081612.59292.arnd@arndb.de> <20130109081131.GH21994@gmail.com>
 <CACRpkdbx7ptCugpc1+JC5Yk+n835goOuoF6q0pdizsjpZ-G9mQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On Jan 9, 2013, at 10:29 AM, Linus Walleij wrote:

> On Wed, Jan 9, 2013 at 9:11 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, 08 Jan 2013, Arnd Bergmann wrote:
>> 
>>> On Tuesday 08 January 2013, Pantelis Antoniou wrote:
>>>> On Jan 8, 2013, at 2:12 PM, Arnd Bergmann wrote:
>>>> 
>>>>> On Tuesday 08 January 2013, Lee Jones wrote:
>>>>>>> If there is not, there is no way to automatically load the overlays; you can always
>>>>>>> use the kernel command line, or have the a user space application to request the loading
>>>>>>> of a specific board's overlay.
>>>>>> 
>>>>>> Unfortunately, there is no way to probe the UIBs. :(
>>>>> 
>>>>> I thought that some of the newer UIBs had it, just not the old ones.
>>>>> As Pantelis says, we could at least detect the ones that have an EEPROM
>>>>> on them, and use a command line option or device tree attribute for the others.
>>>>> 
>>>>>      Arnd
>>>> 
>>>> So I gather the new ones have an eeprom?
>>> 
>>> I don't remember the details unfortunately. Lee should be the one who can find out.
>>> IIRC there was at least a single integeger number on them.
>> 
>> Not as far as I can remember. There was (is?) a crude method of
>> identifying UIBs, but attempting to obtain certain I2C lines and
>> testing which ones were accessible. However, if there is an issue
>> with I2C, the wrong UIB was 'probed'.
> 
> Right, so the UIBs had different GPIO expanders on some I2C addresses,
> so we attempt to communicate with the expander to see if it's board type A,
> and if it doesn't respond it's deemed to be board type B.
> 
> This is the code:
> arch/arm/mach-ux500/board-mop500-uib.c
> 
> /*
> * Detect the UIB attached based on the presence or absence of i2c devices.
> */
> int __init mop500_uib_init(void)
> {
>        struct uib *uib = mop500_uib;
>        struct i2c_adapter *i2c0;
>        int ret;
> 
>        if (!cpu_is_u8500_family())
>                return -ENODEV;
> 
>        if (uib) {
>                __mop500_uib_init(uib, "from uib= boot argument");
>                return 0;
>        }
> 
>        i2c0 = i2c_get_adapter(0);
>        if (!i2c0) {
>                __mop500_uib_init(&mop500_uibs[STUIB],
>                                "fallback, could not get i2c0");
>                return -ENODEV;
>        }
> 
>        /* U8500-UIB has the TC35893 at 0x44 on I2C0, the ST-UIB doesn't. */
>        ret = i2c_smbus_xfer(i2c0, 0x44, 0, I2C_SMBUS_WRITE, 0,
>                        I2C_SMBUS_QUICK, NULL);
>        i2c_put_adapter(i2c0);
> 
>        if (ret == 0)
>                uib = &mop500_uibs[U8500UIB];
>        else
>                uib = &mop500_uibs[STUIB];
> 
>        __mop500_uib_init(uib, "detected");
> 
>        return 0;
> }
> 
> Not elegant but better than e.g. passing a kernel command line option.
> 
> As you say it has the downside of detecting the wrong UIB if there is
> some (other) problem with the I2C block. But in that case the system is
> likely borked anyway so I wonder if it matters...
> 
> Even with the device tree approach we'd be into trouble if say, the UIB
> was unplugged (which is perfectly possible). The device tree cannot
> detect that.
> 
> The larger question is how to handle, at runtime, hardware that may
> or may not be present, in a device tree world.
> 
> Compare this other case: the Integrator has pluggable daughterboards,
> (called LMs, logic modules) and in that case we have specific registers
> to detect them, and register the daughter board on this specific bus
> that Russell came up with in arch/arm/mach-integrator/lm.c,
> the actual board detection is in arch/arm/mach-integrator/integrator_ap.c:
> 
> static void __init ap_init(void)
> {
>        unsigned long sc_dec;
>        int i;
> 
>        platform_device_register(&cfi_flash_device);
> 
>        sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
>        for (i = 0; i < 4; i++) {
>                struct lm_device *lmdev;
> 
>                if ((sc_dec & (16 << i)) == 0)
>                        continue;
> 
>                lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
>                if (!lmdev)
>                        continue;
> 
>                lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
>                lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
>                lmdev->resource.flags = IORESOURCE_MEM;
>                lmdev->irq = IRQ_AP_EXPINT0 + i;
>                lmdev->id = i;
> 
>                lm_device_register(lmdev);
>        }
> 
>        integrator_init(false);
> }
> 
> In this case I think the autodetect is so nice that device tree probing
> is mostly pointless. If it wasn't for the fact that we get a
> cross-depenency to defined interrupts and clocks and whatever that
> are coming from the device tree. Which is where DT shows its
> all-or-nothing face.
> 
> So to get an elegant DT probing in this case I *guess* the right thing
> to do is to dynamically add nodes to the device tree from the board
> code, or have all alternatives inside the DT marked "disable" and then
> mark them as "okay" from the board code by modifying the DT at
> runtime.
> 
> Ideas welcome.
> 

Your problems are not all that different than the ones we have with the 
beaglebone. Your UIBs seem to be exactly like beaglebone capes without
a reliable probing mechanism, which the LMs seem to have a register where a
bit is turn on for each board present.

Let me try to make a list about the kind of boards the DT overlay stuff 
might be applicable, and the different probe methods.

Beaglebone:	I2C EEPROM read (standard format)
Beagleboard:	I2C EEPROM read (standard format - sometimes)
Pandaboard	N/A (not quite sure there)
ux500:		I2C probe of device at known address
integrator:	Memory read of system config register 
pengutronix:	N/A (maybe some kind of known device probe would work)

I've also heard in passing of some boards that just have an area in NAND
where a list of plugged in boards is stored. It can be simplified by
having the bootloader pass a command line argument.

Other than the different probe method (and possible future hot-plug capability)
I don't see anything different.  

What do you think?

Regards

-- Pantelis


> Yours,
> Linus Walleij
