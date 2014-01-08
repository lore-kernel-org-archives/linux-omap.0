From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding information
Date: Wed, 8 Jan 2014 12:35:40 +0100
Message-ID: <201401081235.40927.arnd@arndb.de>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com> <3761842.HRY1CDBF4z@wuerfel> <52CD324D.3020701@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52CD324D.3020701@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Roger Quadros <rogerq@ti.com>, Sebastian Reichel <sre@debian.org>, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, "Kristo, Tero" <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 08 January 2014, Roger Quadros wrote:
> OK. I'll update the binding information to reflect all the clocks.
> 
> But what about clk_get() vs of_clk_get_by_name() ?

I think the convention these days is to just use clk_get(), which calls
of_clk_get_by_name() internally. Not sure if that's what you are asking.

	Arnd
