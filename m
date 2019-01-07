From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DTS: N950/N9: fix onenand timings
Date: Mon, 7 Jan 2019 08:08:52 -0800
Message-ID: <20190107160852.GE5544@atomide.com>
References: <20181223182413.29123-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181223182413.29123-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181223 10:24]:
> Commit a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")
> started using DT specified timings for GPMC, and as a result the
> OneNAND stopped working on N950/N9 as we had wrong values in the DT.
> Fix by updating the values to bootloader timings that have been tested
> to be working on both Nokia N950 and N9.
> 
> Fixes: a758f50f10cf ("mtd: onenand: omap2: Configure driver from DT")

Applying into omap-for-v5.0/fixes thanks.

Tony
