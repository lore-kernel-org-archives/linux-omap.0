From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
Date: Thu, 25 Oct 2012 11:37:33 +0530
Message-ID: <CAFp+6iG1SuJ=wO61=D_pTdRzkM+t62mN3b7=3cZiom8tigyaBQ@mail.gmail.com>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
	<1350377157-28465-2-git-send-email-gautam.vivek@samsung.com>
	<20121016095333.GD5548@arwen.pp.htv.fi>
	<507D31B3.40707@ti.com>
	<20121016100838.GC17416@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:39908 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab2JYGHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 02:07:35 -0400
In-Reply-To: <20121016100838.GC17416@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, rob.herring@calxeda.com
Cc: kishon <kishon@ti.com>, av.tikhomirov@samsung.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, Vivek Gautam <gautam.vivek@samsung.com>, linux-omap@vger.kernel.org

Hi,

On Tue, Oct 16, 2012 at 3:38 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Oct 16, 2012 at 03:36:43PM +0530, kishon wrote:
>> Hi,
>>
>> On Tuesday 16 October 2012 03:23 PM, Felipe Balbi wrote:
>> >On Tue, Oct 16, 2012 at 02:15:56PM +0530, Vivek Gautam wrote:
>> >>This patch adds support to parse probe data for
>> >>dwc3-exynos driver using device tree.
>> >>
>> >>Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> >>---
>> >>  drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
>> >>  1 files changed, 20 insertions(+), 0 deletions(-)
>> >>
>> >>diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>> >>index ca65978..d11ef49 100644
>> >>--- a/drivers/usb/dwc3/dwc3-exynos.c
>> >>+++ b/drivers/usb/dwc3/dwc3-exynos.c
>> >>@@ -21,6 +21,7 @@
>> >>  #include <linux/clk.h>
>> >>  #include <linux/usb/otg.h>
>> >>  #include <linux/usb/nop-usb-xceiv.h>
>> >>+#include <linux/of.h>
>> >>
>> >>  #include "core.h"
>> >>
>> >>@@ -87,6 +88,8 @@ err1:
>> >>    return ret;
>> >>  }
>> >>
>> >>+static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
>> >>+
>> >>  static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>> >>  {
>> >>    struct dwc3_exynos_data *pdata = pdev->dev.platform_data;
>> >>@@ -103,6 +106,14 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>> >>            goto err0;
>> >>    }
>> >>
>> >>+   /*
>> >>+    * Right now device-tree probed devices don't get dma_mask set.
>> >>+    * Since shared usb code relies on it, set it here for now.
>> >>+    * Once we move to full device tree support this will vanish off.
>> >>+    */
>> >>+   if (!pdev->dev.dma_mask)
>> >>+           pdev->dev.dma_mask = &dwc3_exynos_dma_mask;
>> >
>> >says who ?
>> >
>> >$ git grep -e dma_mask drivers/of/
>> >drivers/of/platform.c:  dev->dev.dma_mask = &dev->archdata.dma_mask;
>> >drivers/of/platform.c:  dev->archdata.dma_mask = 0xffffffffUL;
>> >drivers/of/platform.c:  dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> >drivers/of/platform.c:  dev->dev.coherent_dma_mask = ~0;
>> >drivers/of/platform.c:  dev->dma_mask = ~0;
>> >
>> >-ECONFUSED
>>
>> dma_mask is set under some ifdef except for "dev->dma_mask = ~0;".
>> However I agree with you for coherent_dma_mask case.
>
> indeed. Should we try to patch that instead ?
>
> Rob, should we set dma_mask at the driver or do you have a nicer way to
> handle it ??
>
Can i have suggestions here please ? :)

> --
> balbi
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>

Thanks & Regards
Vivek
