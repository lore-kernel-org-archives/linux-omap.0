From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: Add SHAM data and documentation for
 AM33XX
Date: Thu, 22 Aug 2013 15:08:48 +0100
Message-ID: <20130822140848.GD23152@e106331-lin.cambridge.arm.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
 <1374078222-12883-2-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1374078222-12883-2-git-send-email-mgreer@animalcreek.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 17, 2013 at 05:23:41PM +0100, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Add the generic AM33XX SHAM module's device tree data and
> enable it for the am335x-evm, am335x-evmsk, and am335x-bone
> platforms.  Also add Documentation file describing the data
> for the SHAM module.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  .../devicetree/bindings/crypto/omap-sham.txt       | 33 ++++++++++++++++++++++
>  arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
>  arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
>  arch/arm/boot/dts/am335x-evmsk.dts                 |  4 +++
>  arch/arm/boot/dts/am33xx.dtsi                      | 10 +++++++
>  5 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
> new file mode 100644
> index 0000000..c6d1202
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
> @@ -0,0 +1,33 @@
> +OMAP SoC SHA crypto Module
> +
> +Required properties:
> +
> +- compatible : Should contain entries for this and backward compatible
> +  SHAM versions:
> +  - "ti,omap2-sham" for OMAP2 & OMAP3.
> +  - "ti,omap4-sham" for OMAP4 and AM33XX.
> +  Note that these two versions are incompatible.
> +- ti,hwmods: Name of the hwmod associated with the SHAM module
> +- reg : Offset and length of the register set for the module
> +- interrupt-parent : the phandle for the interrupt controller that
> +  services interrupts for this module.
> +- interrupts : the interrupt number for the SHAM module.
> +
> +Optional properties:
> +- dmas: DMA controller phandle and DMA request ordered pair.
> +	Only one rx pair is valid per SHAM module.

This may be a little late, but...

Nit: A dma specifier may have many cells, so calling it "pair" is not
necessarily correct:

dmas = <&dma0 432 7 5>,
       <&dma1 3>,
       <&dma0 212 1 13>;

You could instead say:

- dmas: DMA specifier for the rx dma. See the DMA client binding,
        Documentation/devicetree/bindings/dma/dma.txt

> +- dma-names: DMA request name. This string corresponds 1:1 with
> +	the ordered pair in dmas. The string naming is to be
> +	"rx" for RX request.

Similarly:

 - dma-names: DMA request name. Should be "rx" if a dma is present.

It would be nice to get the bindings using consistent terminology so we
don't confuse everyone further.

Thanks,
Mark.
