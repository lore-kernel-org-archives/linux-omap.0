From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/3] usb: dwc3: use extcon fwrk to receive
 connect/disconnect notification
Date: Fri, 31 May 2013 08:45:31 +0900
Message-ID: <51A7E49B.1010704@samsung.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com>
 <1369405896-30246-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1369405896-30246-4-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: myungjoo.ham@samsung.com, balbi@ti.com, ldewangan@nvidia.com, gg@slimlogic.co.uk, lgirdwood@gmail.com, broonie@kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, george.cherian@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org


On 05/24/2013 11:31 PM, Kishon Vijay Abraham I wrote:
> Modified dwc3-omap to receive connect and disconnect notification using
> extcon framework. Also did the necessary cleanups required after
> adapting to extcon framework.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-omap.c  | 80 +++++++++++++++++++++++++++++++++----------
>  include/linux/usb/dwc3-omap.h | 30 ----------------
>  2 files changed, 62 insertions(+), 48 deletions(-)
>  delete mode 100644 include/linux/usb/dwc3-omap.h

Hi Kishon,

Thi patch is suspended until fix following build error.
(If kernel builds extcon fwr as module, dwc3-omap.c happen error message)

---
tree:   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon extcon-next
head:   30f5d6ea2561c2a54e40b1e8e8f9bb30e064e01b
commit: 30f5d6ea2561c2a54e40b1e8e8f9bb30e064e01b [3/3] usb: dwc3: use extcon fwrk to receive connect/disconnect notification
config: i386-randconfig-x14-0530 (attached as .config)

All error/warnings:

   drivers/built-in.o: In function `dwc3_omap_remove':
   dwc3-omap.c:(.text+0x8c0fa): undefined reference to `extcon_unregister_interest'
   dwc3-omap.c:(.text+0x8c102): undefined reference to `extcon_unregister_interest'
   drivers/built-in.o: In function `dwc3_omap_probe':
   dwc3-omap.c:(.text+0x8c5e6): undefined reference to `extcon_get_extcon_dev'
   dwc3-omap.c:(.text+0x8c6a4): undefined reference to `extcon_register_interest'
   dwc3-omap.c:(.text+0x8c6c9): undefined reference to `extcon_register_interest'
   dwc3-omap.c:(.text+0x8c831): undefined reference to `extcon_get_cable_state'
   dwc3-omap.c:(.text+0x8c851): undefined reference to `extcon_get_cable_state'
---

Also, I missed a issue of this patch. If h/w target use other USB device
instead of "palmas-usb", dwc-omap.c driver won't be operating.
So, I propose two method about this issue.
First, we can get extcon device name through platform data or dt.
Two, When use extcon_register_interest() to register notifier block,
NULL pointer pass to extcon_register_interest() instead of specific extcon
device name(palmas-usb). If extcon_register_interest() check NULL
pointer of extcon device name parameter, extcon fwr will find previous
registered extcon device and then register notifier block of consumer
device driver(dwc3-omap.c) to previous registered extcon device.

> +	edev = extcon_get_extcon_dev("palmas-usb");
> +	if (!edev) {
> +		dev_dbg(dev, "couldn't get extcon device\n");
> +		return -EPROBE_DEFER;
> +	}
> +
>  	spin_lock_init(&omap->lock);
>  
>  	omap->dev	= dev;
>  	omap->irq	= irq;
>  	omap->base	= base;
> +	omap->vbus_nb.notifier_call = dwc3_omap_vbus_notifier;
> +	extcon_register_interest(&omap->extcon_vbus_dev, "palmas-usb", "USB",
> +		&omap->vbus_nb);
> +	omap->id_nb.notifier_call = dwc3_omap_id_notifier;
> +	extcon_register_interest(&omap->extcon_id_dev, "palmas-usb", "USB-HOST",
> +		&omap->id_nb);
>  	dev->dma_mask	= &dwc3_omap_dma_mask;
>  
> +

Thanks,
Chanwoo Choi

