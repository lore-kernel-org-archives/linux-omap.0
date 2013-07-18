From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Thu, 18 Jul 2013 09:55:18 -0700
Message-ID: <1374166518.1949.122.camel@joe-AO722>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
	 <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, nm@ti.com, rnayak@ti.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-07-18 at 22:13 +0530, Sricharan R wrote:
> Some socs have a large number of interrupts/dma requests to service
> the needs of its many peripherals and subsystems. All of the
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt/dma controllers are preceded by an
> IRQ/DMA CROSSBAR that provides flexibility in muxing the device
> requests to the controller inputs.
[]
> diff --git a/drivers/misc/crossbar.c b/drivers/misc/crossbar.c
[]
> +int crossbar_unmap(struct device_node *cbdev_node, unsigned index)
[]
> +	list_for_each_entry(cbdev, &cb_devlist, node) {
> +		if (strcmp(cbdev->name, tmp.cb_name))
> +			continue;
[]
> +				dev_warn(cbdev->dev,
> +					 "unmapped int_no %x mapped to cb %x\n",
> +					 tmp.int_no, tmp.cb_no);
> +				return 0;
[]
> +	dev_warn(cbdev->dev, "%s cb entry %d not found\n",
> +		 __func__, tmp.cb_no);
> +	return -ENOENT;

Why does this function always emit a dev_warn
before return?  Maybe the first should be dev_info?
