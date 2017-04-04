From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v4 0/8] mfd: Add OF device table to I2C drivers that are
 missing it
Date: Tue, 4 Apr 2017 20:38:17 +0300
Message-ID: <20170404173817.gizxme3fgd6nwzbp@raspberrypi-3.musicnaut.iki.fi>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Apr 04, 2017 at 11:30:28AM -0400, Javier Martinez Canillas wrote:
> This series add OF device ID tables to mfd I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.

For patches 1-5 you can add:

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
