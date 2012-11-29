From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH RESEND v5 0/4] OMAP GPMC DT bindings
Date: Thu, 29 Nov 2012 15:08:34 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA0BB6B@DBDE01.ent.ti.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3EA07317@DBDE01.ent.ti.com>
 <50B74DCC.5060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50B74DCC.5060808-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
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
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 29, 2012 at 17:28:04, Daniel Mack wrote:
> Hi Avinash,
> 
> On 29.11.2012 06:24, Philip, Avinash wrote:
> > On Wed, Nov 28, 2012 at 22:28:55, Daniel Mack wrote:
> >> [Resending +devicetree-discuss, +Rob, +Grant]
> >>
> >>
> >> This is a series of patches to support GPMC peripherals on OMAP boards.
> >>
> >> Depends on Linus' master +
> >> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
> > 
> > Can you resend this series on top of linux_next?
> 
> The only branch these patches depend on is the
> "omap-for-v3.8/cleanup-headers-gpmc" branch from omap_next. Are you
> actually seeing any merge conflicts with my series? If so, which branch
> are you referring to exactly?
> 
> > Some of the missing items I seen 
> > 1. Of_node not populated in  omap_nand_platform_data structure.
> 
> Hmm - gpmc_probe_nand_child() from 4/4 adds
> 
>   gpmc_nand_data->of_node = child;
> 
> Do I miss anything?

I didn't found definition for of_node member in omap_nand_platform_data
structure. This also might be missing in liniux-next?

> 
> > 2. Remove platform device creation from hwmod as GPMC DT is populating.
> >    Currently GPMC device creaing from DT & HWMOD.
> 
> This is already addressed in cd00b0530 ("ARM: OMAP2+: gpmc: Fix kernel
> BUG for DT boot mode") by Vaibhav Hiremath, which I got via Afzal's USB
> branch:

Purpose of VH's patch was to get beagle bone booting, but Jon sent another
patch that made beagle bone boot and it has reached mainline by v3.7-rc2,
hence the patch you are referring to is currently not going upstream. Still to
have GPMC DT work, we need that patch as other wise there would be two GPMC
devices. In earlier versions of your series, you had a similar patch, it is
required, can you please add it to your series as otherwise with your series
GPMC DT won't work.

> 
> 
> https://gitorious.org/x0148406-public/linux-kernel/commit/cd00b053082a5cabbb1a35e072b0c044e17e8ec2/diffs
> 
> As that fix is on the way, I dropped my version which did the same thing.
> 
> > Also can you address how this patch series depends on
> > mtd: nand: OMAP: ELM error correction support for BCH ecc
> 
> I have your ELM patches on top of mine, and they apply cleanly. But I
> believe it shouldn't be an issue if you base mine on top of yours.

Yes they are independent. So go ahead and submit GPMC DT binding support.

> 
> Let me know if you want me to rebase anything again. The best solution
> probably if I make sure the series applies cleanly to whatever tree it
> will be merged trough - but I don't know which that would be eventually.

My intention was just to tell you to test on linux-next not to resend (mistake).

Thanks
Avinash

> 
> 
> Thanks for the continuing feedback,
> Daniel
> 
> 
> >>
> >> The only supported peripheral for now is NAND, but other types would be
> >> easy to add.
> >>
> >> Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
> >> and Rob Herring:
> >>
> >>  - add "reg" and "ti,hwmod" properties to Documentation
> >>  - use generic of_mtd functions and the property names defined by them,
> >>    namely "nand-bus-width" and "nand-ecc-mode"
> >>  - reduce the default register space size in the Documentation to 8K,
> >>    as found in the hwmod code
> >>  - switch to a DT layout based on ranges and address translation.
> >>    Although this property is not currently looked at as long as the
> >>    handling code still uses the runtime calculation methods, we now
> >>    have these values in the bindings, eventually allowing us to
> >>    switch the implementation with less pain.
> >>
> >> Version 3 includes fixes pointed out by Jon Hunter:
> >>
> >>  - better documentation of the 'ranges' property to describe the
> >>    fact that it's representing the CS lines
> >>  - GPMC_CS_CONFIGx -> GPMC_CONFIGx in comments
> >>  - drop interrupt-parent from example bindings
> >>  - add of_node_put() at the end of the child iteration
> >>
> >> Version 4 fixes compilation for !CONFIG_MTD_NAND and includes more
> >> details from Jon Hunter and Avinash, Philip:
> >>
> >>  - Add "num-cs" and "num-waitpins" properties, which will eventually
> >>    be used to get rid of GPMC_CS_NUM
> >>  - Better description of generic nand DT properties
> >>  - Dropped patch 3/4 as an equivalent fix was already merged
> >>  - Added ti,nand-ecc-use-elm property
> >>
> >> Version 5 with regards to Avinash, Philip and Peter Korsgaard:
> >>
> >>  - Re-add accidentially forgotten
> >>    Documentation/devicetree/bindings/bus/ti-gpmc.txt
> >>  - Rename "software" ecc mode to "sw"
> >>  - Initialize gpmc_nand_data->is_elm_used to 'true' rather than 1
> >>  - Drop ti,nand-ecc-use-elm binding in favor of a new ecc mode
> >>    named "bch8-am335xrbl-compatible"
> >>  - Add two more patches for section mismatch fixups
> >>
> >> Daniel Mack (4):
> >>   mtd: omap-nand: pass device_node in platform data
> >>   ARM: OMAP: gpmc-nand: drop __init annotation
> >>   ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
> >>   ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
> >>
> >>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  76 +++++++++
> >>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  81 +++++++++
> >>  arch/arm/mach-omap2/gpmc-nand.c                    |  15 +-
> >>  arch/arm/mach-omap2/gpmc.c                         | 181 ++++++++++++++++++++-
> >>  drivers/mtd/nand/omap2.c                           |   4 +-
> >>  5 files changed, 348 insertions(+), 9 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> >>
> >> -- 
> >> 1.7.11.7
> >>
> >>
> > 
> 
> 
