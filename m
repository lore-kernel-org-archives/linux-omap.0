From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] gpio: pca953x: Add support for TI PCA9536
Date: Fri, 20 May 2016 16:44:07 -0500
Message-ID: <20160520214407.GA18432@rob-hp-laptop>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
 <1463640450-16762-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463640450-16762-2-git-send-email-vigneshr@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 19, 2016 at 12:17:29PM +0530, Vignesh R wrote:
> TI PCA9536 is 4-Bit I2C GPIO expander without interrupt support[1].
> Add support for the same.
> 
> [1] TRM: http://www.ti.com/lit/ds/symlink/pca9536.pdf
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
>  drivers/gpio/gpio-pca953x.c                             | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
