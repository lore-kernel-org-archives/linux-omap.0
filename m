From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: am33xx: add DMA properties for tscadc
Date: Wed, 9 Nov 2016 15:23:50 -0700
Message-ID: <20161109222349.GH2428@atomide.com>
References: <20161005090443.24576-1-mugunthanvnm@ti.com>
 <20161005090443.24576-4-mugunthanvnm@ti.com>
 <1a339132-9dd9-6f29-dd66-3125f0e90555@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a339132-9dd9-6f29-dd66-3125f0e90555@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, John Syne <john3909@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Jonathan Cameron <jic23@kernel.org> [161105 10:35]:
> On 05/10/16 10:04, Mugunthan V N wrote:
> > Add DMA properties for tscadc
> > 
> > Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> The support in the driver is now working it's way through iio.git towards
> linux-next. I'm guessing this and the next patch will ultimately go through
> arm-soc.
> 
> Shout if you'd rather I took them through the iio tree.

Applying the dts related patches 3 and 4 into omap-for-v4.10/dt thanks.

Tony
