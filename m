From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 3/3] phy: Group vendor specific phy drivers
Date: Tue, 16 May 2017 15:40:18 +0530
Message-ID: <16fc3965-d250-6c3d-7a62-ab8da1f034fc@ti.com>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Stephen Boyd <stephen.boyd@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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
> 
> Changes since v3:
>  - Added 'Acked-by' and 'Reviewed by' tags received for this patch.
>  - No functional change.
> 
> Changes since v2:
>  - Rebased on linux-phy/next.
>  - Took care of drivers added/removed for each vendors since v2.
>  - Updated the 'Signed-off-by' tag with my current email id.
> 
> Changes from v1:
>  - Updated the MAINTAINERS file to reflect the same change
>    in directory structure.
>  - Removed PHY_PLAT config as pointed out by Kishon.
>    So we don't require the second patch in the v1 of this series:
>    [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
>  - Renamed sunxi --> allwinner; rcar --> renesas.
>  - Fixed error coming with qcom Makefile.
> 
> * Build tested multi_v7_defconfig.
> * Build tested arm64 defconfig with all the involved configs enabled.
> 
> [1] https://patchwork.kernel.org/patch/9684303/
>
.
.
<snip>
.
.
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index afaf7b643eeb..b353ac603ea0 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -15,73 +15,6 @@ config GENERIC_PHY
>  	  phy users can obtain reference to the PHY. All the users of this

.
.
<snip>
.
.
> -
> +menu "Platform Phy drivers"

I don't think creating a new menu is required. I removed it and merged into
linux-phy.

Thanks
Kishon
