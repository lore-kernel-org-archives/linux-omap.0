From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 3/3] phy: Group vendor specific phy drivers
Date: Fri, 12 May 2017 14:15:52 +0530
Message-ID: <5fe76bcc-5ff7-0bf1-7fdd-c141211d86dc@ti.com>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Stephen Boyd <stephen.boyd@linaro.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kerne
List-Id: linux-omap@vger.kernel.org

Hi Vivek,

On Thursday 11 May 2017 12:17 PM, Vivek Gautam wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Also updated the MAINTAINERS file to reflect the correct
> directory structure for phy drivers.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> 
> Changes since v4:
>  - Reprepared the patch based on latest torvalds/master.
>  - Added new directory for amlogic, since there's a new patch [1]
>    coming in for amlogic platforms.

I don't prefer placeholder directories but this is not a placeholder directory
since phy-meson8b-usb2.c is already added in amlogic.

Btw, thank you for sending this patch. Will queue this once -rc1 is tagged.

Cheers
Kishon
