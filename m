From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 11/11] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
Date: Tue, 10 Jul 2012 14:03:12 +0530
Message-ID: <4FFBE8C8.9090908@ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>	<1340884267-28908-12-git-send-email-kishon@ti.com>	<4FFBCBC0.5020603@ti.com>
 <CAAe_U6Ly3J90VMz5dP=p4wDauOf1v_K1JRB0Qp8nBYaQhcx==w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAAe_U6Ly3J90VMz5dP=p4wDauOf1v_K1JRB0Qp8nBYaQhcx==w@mail.gmail.com>
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
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 July 2012 01:46 PM, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>
> On Tue, Jul 10, 2012 at 11:59 AM, Rajendra Nayak<rnayak-l0cyMroinI0@public.gmane.org>  wrote:
>> On Thursday 28 June 2012 05:21 PM, Kishon Vijay Abraham I wrote:
>>>
>>> All the unnessary functions in omap-phy-internal is removed.
>>> These functionality are now handled by omap-usb2 phy driver.
>>>
>>> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
>>> Acked-by: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>>    arch/arm/mach-omap2/omap_phy_internal.c |  138
>>> -------------------------------
>>>    arch/arm/mach-omap2/twl-common.c        |    5 -
>>>    arch/arm/mach-omap2/usb-musb.c          |    3 -
>>>    3 files changed, 0 insertions(+), 146 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
>>> b/arch/arm/mach-omap2/omap_phy_internal.c
>>> index 4c90477..0c610b4 100644
>>> --- a/arch/arm/mach-omap2/omap_phy_internal.c
>>> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>>> @@ -31,144 +31,6 @@
>>>    #include<plat/usb.h>
>>>    #include "control.h"
>>>
>>> -/* OMAP control module register for UTMI PHY */
>>> -#define CONTROL_DEV_CONF               0x300
>>> -#define PHY_PD                         0x1
>>> -
>>> -#define USBOTGHS_CONTROL               0x33c
>>> -#define        AVALID                          BIT(0)
>>> -#define        BVALID                          BIT(1)
>>> -#define        VBUSVALID                       BIT(2)
>>> -#define        SESSEND                         BIT(3)
>>> -#define        IDDIG                           BIT(4)
>>> -
>>> -static struct clk *phyclk, *clk48m, *clk32k;
>>> -static void __iomem *ctrl_base;
>>> -static int usbotghs_control;
>>> -
>>> -int omap4430_phy_init(struct device *dev)
>>> -{
>>> -       ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>>> -       if (!ctrl_base) {
>>> -               pr_err("control module ioremap failed\n");
>>> -               return -ENOMEM;
>>> -       }
>>> -       /* Power down the phy */
>>> -       __raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>>
>>
>> Just checking, but I hope your new driver handles this too.
>> You might not see any issues with it now, but not doing this could
>> gate OMAP hitting low power in idle.
>
> I power down the phy during probe in omap-usb2 phy driver.

ok, thanks, good to know.

>
> Thanks
> Kishon
