From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: am335x-icev2: Add DT node for TI PCA9536
Date: Thu, 26 May 2016 10:40:43 +0200
Message-ID: <CACRpkdbRt4Vi=kzs_gZDkR14KBmFsKKZawbT25PW0sMpuX7LkQ@mail.gmail.com>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
	<1463640450-16762-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463640450-16762-3-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 19, 2016 at 8:47 AM, Vignesh R <vigneshr@ti.com> wrote:

> AM335x ICE board has a TI PCA9536 chip connected to I2C0 at address
> 0x41. Add DT entry for the same.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls take this through the ARM SoC TI git tree.

Yours,
Linus Walleij
