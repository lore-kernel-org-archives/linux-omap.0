From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/3 v4] mtd: rawnand: ams-delta: use GPIO lookup
 table
Date: Wed, 18 Jul 2018 09:20:41 +0200
Message-ID: <20180718092041.1d49094a@xps13>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
        <20180717231448.14958-1-jmkrzyszt@gmail.com>
        <20180717231448.14958-3-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717231448.14958-3-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Shreeya Patel <shreeya.patel23498@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Halasa <khalasa@piap.pl>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.>
List-Id: linux-omap@vger.kernel.org

Hi Janusz, Tony

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Wed, 18 Jul 2018
01:14:47 +0200:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
> 
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents.
> 
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

As suggested by Boris, we expect this series to go through the OMAP
tree so we'll need an immutable tag, there are more changes on this
driver coming in.

Thanks!
Miquèl
