From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 0/3] Add device tree support for NAND flash in
 am335x-evm
Date: Thu, 31 Jan 2013 09:36:10 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA68A6D@DBDE01.ent.ti.com>
References: <cover.1359007746.git.avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1359007746.git.avinashphilip-l0cyMroinI0@public.gmane.org>
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
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Benoit,

On Thu, Jan 24, 2013 at 13:32:26, Philip, Avinash wrote:
> This patch series adds device tree support for NAND flash in am335x-evm.
> Also ELM node is populated in device tree and been used for BCH error
> correction in NAND flash part. Also this patch series ensures RBL ecc
> layout maintained in Linux kernel with BCH8 ecc scheme.
> 
> This patch series based on [1] and depends on [2].
> 
> 1. http://git.kernel.org/?p=linux/kernel/git/bcousson/linux-omap-dt.git;a=tree;h=refs/heads/for_3.9/dts;hb=refs/heads/for_3.9/dts
> 
> 2.mtd: devices: elm: Removes <xx> literals in elm DT node
>   https://lkml.org/lkml/2013/1/24/30
> 

Can you accept this patch series so that NAND flash with BCH support
for am335x-evm available in 3.9.

Thanks
Avinash


> Philip Avinash (1):
>   ARM: dts: AM33XX: Add NAND flash device tree data to am335x-evm
> 
> Philip, Avinash (2):
>   ARM: dts: AM33XX: Add ELM node
>   ARM: dts: AM33XX: Add GPMC node
> 
>  arch/arm/boot/dts/am335x-evm.dts |   98 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/am33xx.dtsi    |   20 ++++++++
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.9.5
> 
> 
