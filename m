From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/3] can: Add D_CAN raminit support to am335x-evm
Date: Tue, 20 Nov 2012 05:00:15 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA75C73@DBDE01.ent.ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352916505-12343-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
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
To: "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 14, 2012 at 23:38:22, AnilKumar, Chimata wrote:
> This patch series adds d_can raminit support to c_can/d_can driver,
> which is required to init/de-init D_CAN message RAM (holds message
> objects). Added corresponding DT changes to get resource of RAMINIT
> register and device instance.
> 
> These patches were tested on AM335x-EVM along with pinctrl data addition
> patch, which is not added to am335x-evm.dts (only supports CPLD profile#0)
> because d_can1 is supported under CPLD profile#1.

Hi Mark,

Gentle remainder to this series

Thanks
AnilKumar
 
> AnilKumar Ch (3):
>   can: c_can: Add d_can raminit support
>   ARM: dts: AM33XX: Add d_can instances to aliases
>   ARM: dts: AM33XX: Add memory resource to d_can node
> 
>  arch/arm/boot/dts/am33xx.dtsi          |    8 ++++++--
>  drivers/net/can/c_can/c_can.c          |   12 +++++++++++
>  drivers/net/can/c_can/c_can.h          |    3 +++
>  drivers/net/can/c_can/c_can_platform.c |   34 +++++++++++++++++++++++++++++++-
>  4 files changed, 54 insertions(+), 3 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> 
