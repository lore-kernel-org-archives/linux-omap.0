From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: DTS: OMAP/DRA7: dma property name correction
Date: Tue, 24 Feb 2015 10:02:47 -0800
Message-ID: <20150224180246.GE11056@atomide.com>
References: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150220 05:45]:
> Hi,
> 
> While working on the DMA crossbar support for DRA7 typo of devices I have
> noticed that the dma-channels and dma-requests properties of sdma wrongly
> has # at the beginning.
> According to the documentation, it should not have:
> Documentation/devicetree/bindings/dma/dma.txt
> 
> Since these properties are not in use at the moment, but it is going to be needed
> for the crossbar driver it is better to fix it right now so we do not need to
> patch .dtsi and .c files at the same time later.
> 
> Tony: I would really appreciate if this could go in within the current merge
> window.

Yeah applying into omap-for-v4.0/fixes, let's get it out of the
way to avoid more cut-n-paste errors.

Regards,

Tony
 
> Peter Ujfalusi (5):
>   ARM: DTS: omap2: Correct the dma controller's property names
>   ARM: DTS: omap3: Correct the dma controller's property names
>   ARM: DTS: omap4: Correct the dma controller's property names
>   ARM: DTS: omap5: Correct the dma controller's property names
>   ARM: DTS: dra7: Correct the dma controller's property names
> 
>  arch/arm/boot/dts/dra7.dtsi  | 4 ++--
>  arch/arm/boot/dts/omap2.dtsi | 4 ++--
>  arch/arm/boot/dts/omap3.dtsi | 4 ++--
>  arch/arm/boot/dts/omap4.dtsi | 4 ++--
>  arch/arm/boot/dts/omap5.dtsi | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.3.0
> 
