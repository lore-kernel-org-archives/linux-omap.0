From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [REPOST PATCH 1/4] ARM: dts: DRA7: Add dsp1_system syscon node
Date: Mon, 12 Oct 2015 14:43:04 -0700
Message-ID: <20151012214304.GD23801@atomide.com>
References: <1443828205-18706-1-git-send-email-s-anna@ti.com>
	<1443828205-18706-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443828205-18706-2-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [151002 16:27]:
> The DSP_SYSTEM sub-module is a dedicated system control logic
> module present within a DRA7 DSP processor sub-system. This
> module is responsible for power management, clock generation
> and connection to the device PRCM module.
> 
> Add a syscon node for this module for the DSP1 processor
> sub-system. This is added as a syscon node as it is a common
> configuration module that can be used by the different IOMMU
> instances and the corresponding remoteproc device.
> 
> The node is added to the common dra7.dtsi file, as the DSP1
> processor sub-system is mostly common across all the variants
> of the DRA7 SoC family.
> 
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index e289c706d27d..62055094e8d5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -292,6 +292,11 @@
>  				#thermal-sensor-cells = <1>;
>  		};
>  
> +		dsp1_system: dsp_system@40d00000 {
> +			compatible = "syscon";
> +			reg = <0x40d00000 0x100>;
> +		};
> +
>  		sdma: dma-controller@4a056000 {
>  			compatible = "ti,omap4430-sdma";
>  			reg = <0x4a056000 0x1000>;

Hmm so why would you want to set up a complete device as a syscon
mapping rather than just doing ioremap on it?

What drivers will be sharing access to these registers?

Regards,

Tony
