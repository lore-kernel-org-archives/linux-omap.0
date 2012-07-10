From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v1 11/11] arm: omap: phy: remove unused functions from omap-phy-internal.c
Date: Tue, 10 Jul 2012 13:46:21 +0530
Message-ID: <CAAe_U6Ly3J90VMz5dP=p4wDauOf1v_K1JRB0Qp8nBYaQhcx==w@mail.gmail.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>
	<1340884267-28908-12-git-send-email-kishon@ti.com>
	<4FFBCBC0.5020603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52758 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab2GJIQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jul 2012 04:16:23 -0400
Received: by vbbfs19 with SMTP id fs19so15983931vbb.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Jul 2012 01:16:21 -0700 (PDT)
In-Reply-To: <4FFBCBC0.5020603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, b-cousson@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, hvaibhav@ti.com

Hi,

On Tue, Jul 10, 2012 at 11:59 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Thursday 28 June 2012 05:21 PM, Kishon Vijay Abraham I wrote:
>>
>> All the unnessary functions in omap-phy-internal is removed.
>> These functionality are now handled by omap-usb2 phy driver.
>>
>> Cc: Felipe Balbi<balbi@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> Acked-by: Tony Lindgren<tony@atomide.com>
>> ---
>>   arch/arm/mach-omap2/omap_phy_internal.c |  138
>> -------------------------------
>>   arch/arm/mach-omap2/twl-common.c        |    5 -
>>   arch/arm/mach-omap2/usb-musb.c          |    3 -
>>   3 files changed, 0 insertions(+), 146 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
>> b/arch/arm/mach-omap2/omap_phy_internal.c
>> index 4c90477..0c610b4 100644
>> --- a/arch/arm/mach-omap2/omap_phy_internal.c
>> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>> @@ -31,144 +31,6 @@
>>   #include<plat/usb.h>
>>   #include "control.h"
>>
>> -/* OMAP control module register for UTMI PHY */
>> -#define CONTROL_DEV_CONF               0x300
>> -#define PHY_PD                         0x1
>> -
>> -#define USBOTGHS_CONTROL               0x33c
>> -#define        AVALID                          BIT(0)
>> -#define        BVALID                          BIT(1)
>> -#define        VBUSVALID                       BIT(2)
>> -#define        SESSEND                         BIT(3)
>> -#define        IDDIG                           BIT(4)
>> -
>> -static struct clk *phyclk, *clk48m, *clk32k;
>> -static void __iomem *ctrl_base;
>> -static int usbotghs_control;
>> -
>> -int omap4430_phy_init(struct device *dev)
>> -{
>> -       ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>> -       if (!ctrl_base) {
>> -               pr_err("control module ioremap failed\n");
>> -               return -ENOMEM;
>> -       }
>> -       /* Power down the phy */
>> -       __raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>
>
> Just checking, but I hope your new driver handles this too.
> You might not see any issues with it now, but not doing this could
> gate OMAP hitting low power in idle.

I power down the phy during probe in omap-usb2 phy driver.

Thanks
Kishon
