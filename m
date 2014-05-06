From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [TEMP PATCH 17/17] ARM: dts: dra7: Add *resets* property for
 PCIe dt node
Date: Tue, 6 May 2014 08:40:40 -0500
Message-ID: <5368E658.1040209@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-18-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399383244-14556-18-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
Cc: balajitk@ti.com, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

On 05/06/2014 08:34 AM, Kishon Vijay Abraham I wrote:
> Added *resets* and *reset-names* properies for PCIe dt node.
> The documention for this node can be found @ ../bindings/pci/ti-pci.txt.
>
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 20b1a09..7bc0555 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1031,6 +1031,8 @@
>  			ti,hwmods = "pcie1";
>  			phys = <&pcie1_phy>;
>  			phy-names = "pcie-phy";
> +			resets = <&prm_resets &device_reset>;

If you look @ v2 of the reset framework patchset your phandle should be

resets = <&prm_resets &pcie1_reset>;

If you call the device_reset phandle you will reset the SoC.


> +			reset-names = "reset";

This needs to be more descriptive.

>  		};
>  
>  		sata: sata@4a141100 {


-- 
------------------
Dan Murphy
