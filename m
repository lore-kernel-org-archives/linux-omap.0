From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv6 2/2] mfd: motorola-cpcap: Add audio-codec support
Date: Mon, 16 Apr 2018 13:58:49 +0100
Message-ID: <20180416125849.sfiphqylcyea7wjg@dell>
References: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
 <20180330125824.21418-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330125824.21418-3-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> From: Sebastian Reichel <sre@kernel.org>
> 
> Add support for the audio-codec node by converting from
> devm_of_platform_populate() to devm_mfd_add_devices().
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/motorola-cpcap.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
