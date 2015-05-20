From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: Beaglebone i2c definitions
Date: Wed, 20 May 2015 11:17:08 -0700
Message-ID: <20150520181708.GL10274@atomide.com>
References: <1431504274-32084-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150514153822.GJ15563@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514153822.GJ15563@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Robert Nelson <robertcnelson@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150514 08:40]:
> * Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150513 01:05]:
> > The beaglebone family of boards contain two I2C busses enabled.
> > The first one with a baseboard identification EEPROM and a
> > cape I2C bus.
> 
> This seems safe to apply as the i2c2 pins are listed in the cape
> specification.
> 
> These pins could be used for other devices too.. But in that case
> the cape would not follow the cape standard.

So applying this one into omap-for-v4.2/dt thanks.

Tony
