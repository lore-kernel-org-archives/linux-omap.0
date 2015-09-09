From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RESEND PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Wed, 09 Sep 2015 16:35:16 -0700
Message-ID: <7h4mj3kvyj.fsf@deeprootsystems.com>
References: <1441368795-21420-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1441368795-21420-1-git-send-email-kishon@ti.com> (Kishon Vijay
	Abraham, I's message of "Fri, 4 Sep 2015 17:43:15 +0530")
Sender: linux-mmc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: arm@kernel.org, ulf.hansson@linaro.org, tony@atomide.com, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Kishon Vijay Abraham I <kishon@ti.com> writes:

> PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
> OMAP5 and DRA7 SoCs. Enable it here.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, added to our next/late branch.

Kevin
