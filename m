From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCHv2 2/4] arm/dts: omap5-evm: Add tmp102 sensor support
Date: Tue, 14 Aug 2012 11:56:45 +0200
Message-ID: <502A20DD.5030707@ti.com>
References: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com> <1344852313-30484-3-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344852313-30484-3-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/13/2012 12:05 PM, Sourav Poddar wrote:
> Add tmp102 temperature sensor data in omap5 evm dts file.
> 
> Tested on omap5430 evm with 3.5 custom kernel.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  arch/arm/boot/dts/omap5-evm.dts |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index 200c39a..45a8aeb 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -18,3 +18,12 @@
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
>  	};
>  };
> +
> +&i2c4 {
> +	clock-frequency = <400000>;

Have you checked if we cannot run at faster speed? Reducing the speed
will impact every devices on the bus.
It might be needed, I just wanted to be sure.

You should maybe just add a small comment to explain what the device is
doing with potentially a link to the HW spec if available.

The same comments are applicable to the bmp085 patch.

Regards,
Benoit
