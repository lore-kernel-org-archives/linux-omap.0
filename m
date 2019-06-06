From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] ARM: config: Remove left-over BACKLIGHT_LCD_SUPPORT
Date: Thu, 6 Jun 2019 10:00:09 +0800
Message-ID: <20190606020008.GT29853@dragon>
References: <1559633061-28003-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1559633061-28003-1-git-send-email-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Russell King <linux@armlinux.org.uk>, Vladimir Zapolskiy <vz@mleia.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, arm@kernel.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 04, 2019 at 09:24:21AM +0200, Krzysztof Kozlowski wrote:
> The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
> ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
> symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
> available directly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Change also mini2440_defconfig.
> ---
...
>  arch/arm/configs/mxs_defconfig            | 1 -

Acked-by: Shawn Guo <shawnguo@kernel.org>
