From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/5] gpio: omap: check gpiochip_add() return value
Date: Thu, 10 Apr 2014 13:36:10 -0400
Message-ID: <5346D68A.2090502@ti.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk> <1396796297-13002-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1396796297-13002-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sunday 06 April 2014 10:58 AM, Javier Martinez Canillas wrote:
> The gpiochip_add() function can fail if the chip cannot
> be registered so the return value has to be checked and
> the error propagated in case it happens.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


