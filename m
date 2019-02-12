From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x: Add support for Bosch Guardian
Date: Tue, 12 Feb 2019 10:49:15 -0800
Message-ID: <20190212184915.GN5720@atomide.com>
References: <20190211122727.5582-1-martyn.welch@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211122727.5582-1-martyn.welch@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Martyn Welch <martyn.welch@collabora.com> [190211 04:27]:
> The Bosch Guardian is a TI am335x based device.
> 
> It's hardware specifications are as follows:
> 
>  * 256 MB DDR3 memory
>  * 512 MB NAND Flash
>  * USB OTG
>  * RS232
>  * MicroSD external storage
>  * LCD Display interface

Thanks applying into omap-for-v5.1/dt.

Do you have some link for this device for more
information?

> +/include/ "tps65217.dtsi"

I'll update this to use #include "tps65217.dtsi"
while applying.

Regards,

Tony
