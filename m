From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [RESEND/PATCHv3] arm: dts: omap5-evm: Add keypad support
Date: Mon, 29 Oct 2012 17:44:00 +0100
Message-ID: <508EB250.20607@ti.com>
References: <1351507226-10328-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351507226-10328-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

On 10/29/2012 11:40 AM, Sourav Poddar wrote:
> Add keypad data node in omap5-evm.
> 
> Based on I2C support patch for omap5, which has been
> already posted as a different series.
> 
> Tested on omap5430 evm with 3.7-rc1 kernel.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Tested on omap5430 sdp with 3.7-rc1 kernel.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  arch/arm/boot/dts/omap5-evm.dts |   95 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index c663eba..b812d6d 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -140,3 +140,98 @@
>  &mcbsp3 {
>  	status = "disabled";
>  };
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +
> +	smsc@38 {
> +		compatible = "smscece1099";
> +		reg = <0x38>;
> +		clock = <0x13>;

What does that "clock" mean?

I cannot find that in the binding documentation. BTW, did you add that
documentation in the driver patch?

Regards,
Benoit
