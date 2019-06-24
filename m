From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V2 08/15] ARM: mmp: cleanup cppcheck shifting errors
Date: Mon, 24 Jun 2019 14:59:32 +0100
Message-ID: <20190624135931.kvf4xddxfcaisnq5@shell.armlinux.org.uk>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190624135105.15579-9-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624135105.15579-9-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pieralisi@arm
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 08:50:58PM +0700, Phong Tran wrote:
>  #define MPMU_PLL2_CTRL1				MPMU_REG(0x0414)
>  #define MPMU_CGR_PJ				MPMU_REG(0x1024)
>  #define MPMU_WUCRM_PJ				MPMU_REG(0x104c)
> -#define MPMU_WUCRM_PJ_WAKEUP(x)			(1 << (x))
> -#define MPMU_WUCRM_PJ_RTC_ALARM			(1 << 17)
> +#define MPMU_WUCRM_PJ_WAKEUP(x)			BIT((x))

Extra parens not required.

> +#define MPMU_AWUCRM_WAKEUP(x)			BIT(((x) & 0x7))

Ditto.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
