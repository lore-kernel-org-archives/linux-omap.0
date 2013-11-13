From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V3 4/7] ARM: DTS: DRA: Replace peripheral interrupt numbers
 with crossbar inputs
Date: Wed, 13 Nov 2013 10:29:08 -0500
Message-ID: <52839AC4.5090103@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com> <1383657257-3458-5-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1383657257-3458-5-git-send-email-r.sricharan@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, galak@codeaurora.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 05 November 2013 08:14 AM, Sricharan R wrote:
> Now with the crossbar IP in picture, the peripherals do not have the
> fixed interrupt lines. Instead they rely on the crossbar irqchip to
> allocate and map a free interrupt line to its crossbar input. So replacing
> all the peripheral interrupt numbers with its fixed crossbar input lines.
> 
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi |   86 +++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
You probably need to split the series with dts and drivers/irqchip/*
changes.

For patch itself,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

