From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] usb: host: f_usb20ho: add support for Fujitsu ehci/ohci USB 2.0 host controller
Date: Tue, 16 Dec 2014 10:06:15 +0100
Message-ID: <94603263.7VVvg5Qn7O@wuerfel>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com> <1418695828-605-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418695828-605-2-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sneeker Yeh <sneeker.yeh@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Grant Likely <grant.likely@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Paul Bolle <pebolle@tiscali.nl>, Hans de Goede <hdegoede@redhat.com>, Thomas Pugliese <thomas.pugliese@gmail.com>, David Mosberger <davidm@egauge.net>, Peter Griffin <peter.griffin@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Andrew Bresticker <abrestic@chromium.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.ker
List-Id: linux-omap@vger.kernel.org

On Tuesday 16 December 2014 10:10:26 Sneeker Yeh wrote:
> This patch adds support for EHCI compliant Host controller found
> on Fujitsu Socs.
> 
> Signed-off-by: Sneeker Yeh <Sneeker.Yeh@tw.fujitsu.com>
> ---
>  .../devicetree/bindings/usb/fujitsu-ehci.txt       |   22 ++
>  drivers/usb/host/Kconfig                           |   11 +
>  drivers/usb/host/Makefile                          |    1 +
>  drivers/usb/host/f_usb20ho_hcd.c                   |  306 ++++++++++++++++++++
>  drivers/usb/host/f_usb20ho_hcd.h                   |   35 +++
>  5 files changed, 375 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fujitsu-ehci.txt
>  create mode 100644 drivers/usb/host/f_usb20ho_hcd.c
>  create mode 100644 drivers/usb/host/f_usb20ho_hcd.h
> 
> diff --git a/Documentation/devicetree/bindings/usb/fujitsu-ehci.txt b/Documentation/devicetree/bindings/usb/fujitsu-ehci.txt
> new file mode 100644
> index 0000000..e180860
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fujitsu-ehci.txt
> @@ -0,0 +1,22 @@
> +FUJITSU GLUE COMPONENTS
> +
> +MB86S7x EHCI GLUE
> + - compatible : Should be "fujitsu,f_usb20ho_hcd"

Please try to use the binding from

Documentation/devicetree/bindings/usb/usb-ehci.txt and the respective
ohci binding first, and use two separate devic enodes.

> + - reg : Address and length of the register set for the device.
> + - interrupts : The irq number of this device that is used to interrupt the
> +   CPU
> + - clocks: from common clock binding, handle to usb clock.
> + - clock-names: from common clock binding.

You should always document the specific strings for a named property.

> + - #stream-id-cells : handle to use "arm,mmu-400" ARM IOMMU driver

Don't use that binding, we are trying to kill that off. Instead, use
an 'iommus' property.


> +	hci_res[0].start = ohci ? resource->start + F_OHCI_OFFSET :
> +		resource->start + F_EHCI_OFFSET;
> +	hci_res[0].end = ohci ?
> +			resource->start + F_OHCI_OFFSET + F_OHCI_SIZE - 1 :
> +			resource->start + F_EHCI_OFFSET + F_EHCI_SIZE - 1;
> +	hci_res[0].flags = IORESOURCE_MEM;
> +
> +	hci_res[1].start = irq;
> +	hci_res[1].flags = IORESOURCE_IRQ;
> +
> +	hci_dev = platform_device_alloc(ohci ? "ohci-platform" :
> +					"ehci-platform", 0);
> +	if (!hci_dev) {
> +		dev_err(&pdev->dev, "platform_device_alloc() failed\n");
> +		ret = -ENODEV;
> +		goto err_res;
> +	}

No need for playing games with child devices, just see how the other
drivers do it.

> +	ret = platform_device_add(hci_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "platform_device_add() failed\n");
> +		goto err_alloc;
> +	}
> +
> +	return hci_dev;
> +
> +err_alloc:
> +	platform_device_put(hci_dev);
> +err_res:
> +	return ERR_PTR(ret);
> +}
> +
> +static u64 f_usb20ho_dma_mask =  DMA_BIT_MASK(32);

The dma mask should come from the dma-ranges property of the parent bus,
as of_platform_populate now does.

	Arnd
