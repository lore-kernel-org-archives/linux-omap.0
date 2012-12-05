From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 0/5] OMAP GPMC DT bindings
Date: Wed, 5 Dec 2012 13:22:32 -0600
Message-ID: <50BF9EF8.3060507@ti.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354734571-10774-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, avinashphilip-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 12/05/2012 01:09 PM, Daniel Mack wrote:
> This is a series of patches to support GPMC peripherals on OMAP boards.
> 
> Grant, Rob, could you have a look and give your Acked-by if
> appropriate?
> 
> 
> Many thanks again,
> Daniel
> 
> 
> Tested on Linus' master +
> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
> 
> Generated from linux-next as of today, resolving one trivial include
> file rebase conflict.
> 
> The only supported peripheral for now is NAND, but other types would be
> easy to add.
> 
> Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
> and Rob Herring:
> 
>  - add "reg" and "ti,hwmod" properties to Documentation
>  - use generic of_mtd functions and the property names defined by them,
>    namely "nand-bus-width" and "nand-ecc-mode"
>  - reduce the default register space size in the Documentation to 8K,
>    as found in the hwmod code
>  - switch to a DT layout based on ranges and address translation.
>    Although this property is not currently looked at as long as the
>    handling code still uses the runtime calculation methods, we now
>    have these values in the bindings, eventually allowing us to
>    switch the implementation with less pain.
> 
> Version 3 includes fixes pointed out by Jon Hunter:
> 
>  - better documentation of the 'ranges' property to describe the
>    fact that it's representing the CS lines
>  - GPMC_CS_CONFIGx -> GPMC_CONFIGx in comments
>  - drop interrupt-parent from example bindings
>  - add of_node_put() at the end of the child iteration
> 
> Version 4 fixes compilation for !CONFIG_MTD_NAND and includes more
> details from Jon Hunter and Avinash, Philip:
> 
>  - Add "num-cs" and "num-waitpins" properties, which will eventually
>    be used to get rid of GPMC_CS_NUM
>  - Better description of generic nand DT properties
>  - Dropped patch 3/4 as an equivalent fix was already merged
>  - Added ti,nand-ecc-use-elm property
> 
> Version 5 with regards to Avinash, Philip and Peter Korsgaard:
> 
>  - Re-add accidentially forgotten
>    Documentation/devicetree/bindings/bus/ti-gpmc.txt
>  - Rename "software" ecc mode to "sw"
>  - Initialize gpmc_nand_data->is_elm_used to 'true' rather than 1
>  - Drop ti,nand-ecc-use-elm binding in favor of a new ecc mode
>    named "bch8-am335xrbl-compatible"
>  - Add two more patches for section mismatch fixups
> 
> Version 6:
> 
>  - Dropped "bch8-am335xrbl-compatible" mode again. As discussed with
>    Avinash, the ELM issue will be solved subsequently in s separate
>    series.
>  - re-added a patch to bail out of automatic GPMC instanciation in
>    case of DT boot.
>  - re-added the "of_node" addition in mtd_nand_omap2.h in 2/5
> 
> Version 7: comments from Jon Hunter, all affecting the documentation:
> 
>  - add num-wait pins properties as they are marked 'required'
>  - make reg sizes consistent
>  - AM335x only has 2 wait-pins
> 
> Again, many thanks to everybody, in particular Avinash, for the long
> disussion about how to the these details right in the first place.
> 
> 
> Daniel
> 
> Daniel Mack (5):
>   ARM: OMAP: gpmc: don't create devices from initcall on DT
>   mtd: omap-nand: pass device_node in platform data
>   ARM: OMAP: gpmc-nand: drop __init annotation
>   ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs

Do you still need patch #4 now? Can't we drop this?

May be worth just including what is required for linux-next as this is
3.9 material.

Cheers
Jon
