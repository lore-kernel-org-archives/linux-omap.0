From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 0/8] mfd: Add OF device table to I2C drivers that are
 missing it
Date: Tue, 4 Apr 2017 11:54:58 -0500
Message-ID: <CAL_Jsq+FMrCOyjKXDBFR07AsD5nzSA2cRoBBix24NSBHiepo7A@mail.gmail.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 4, 2017 at 10:30 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello,
>
> This series add OF device ID tables to mfd I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.

For the series,

Acked-by: Rob Herring <robh@kernel.org>
