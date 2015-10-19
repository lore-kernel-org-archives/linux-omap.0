From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: AM43x-epos-evm: Add AM438x compatible
 string for epos
Date: Mon, 19 Oct 2015 09:06:07 -0700
Message-ID: <20151019160606.GC22043@atomide.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
 <1444885808-6306-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1444885808-6306-3-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [151014 22:14]:
> Add AM438x compatible property to identify the SoCs on epos evms.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Rebased to latest 4.3-rc5
> 
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 5 ++++-
>  arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 9f4e513..dc3b5f2 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -100,6 +100,9 @@ SoCs:
>  - AM4372
>    compatible = "ti,am4372", "ti,am43"
>  
> +- AM438x
> +  compatible = "ti,am438x", "ti,am43"
> +

The compatible strings should not have x, this should be
"ti,am438" instead. But my guess is that we are better off
adding proper SoC detection to avoid needing a separate dts
file for each SoC revision. Ideally booting with "ti,am43"
should be enough and we can initialize the rest during
runtime.

Regards,

Tony
