From: Greg KH <greg@kroah.com>
Subject: Re: [BACKPORT 4.14.y 04/18] usb: dwc3: Allow disabling of
 metastability workaround
Date: Tue, 10 Sep 2019 15:36:01 +0100
Message-ID: <20190910143601.GD3362@kroah.com>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
 <20190905161759.28036-5-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905161759.28036-5-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 05, 2019 at 10:17:45AM -0600, Mathieu Poirier wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> commit 42bf02ec6e420e541af9a47437d0bdf961ca2972 upstream
> 
> Some platforms (e.g. TI's DRA7 USB2 instance) have more trouble
> with the metastability workaround as it supports only
> a High-Speed PHY and the PHY can enter into an Erratic state [1]
> when the controller is set in SuperSpeed mode as part of
> the metastability workaround.
> 
> This causes upto 2 seconds delay in enumeration on DRA7's USB2
> instance in gadget mode.
> 
> If these platforms can be better off without the workaround,
> provide a device tree property to suggest that so the workaround
> is avoided.
> 
> [1] Device mode enumeration trace showing PHY Erratic Error.
>      irq/90-dwc3-969   [000] d...    52.323145: dwc3_event: event (00000901): Erratic Error [U0]
>      irq/90-dwc3-969   [000] d...    52.560646: dwc3_event: event (00000901): Erratic Error [U0]
>      irq/90-dwc3-969   [000] d...    52.798144: dwc3_event: event (00000901): Erratic Error [U0]

Does the DT also need to get updated with this new id for this?  Is that
a separate patch somewhere?

thanks,

greg k-h
