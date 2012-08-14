From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCHv2 0/4] Add device tree data for omap5
Date: Tue, 14 Aug 2012 12:24:00 +0200
Message-ID: <502A2740.9000206@ti.com>
References: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

On 08/13/2012 12:05 PM, Sourav Poddar wrote:
> The following patch series add i2c support for omap5.
> As well as enable I2C based devices like pressure and temperature
> through device tree. Also add onchip keypad dts data.

That series does not seems to apply on top of 3.6-rc1, what based did
you use?

Benoit


> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Sourav Poddar (4):
>   arm/dts: omap5-evm: Add I2C support
>   arm/dts: omap5-evm: Add tmp102 sensor support
>   arm/dts: omap5-evm: Add keypad data
>   arm/dts: omap5-evm: Add bmp085 sensor support
> 
>  arch/arm/boot/dts/omap5-evm.dts |   30 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 0 deletions(-)
> 
