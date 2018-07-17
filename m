From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Tue, 17 Jul 2018 21:37:36 +0200
Message-ID: <20180717213736.3cd0a747@bbrezillon>
References: <20180525222046.11200-1-jmkrzyszt@gmail.com>
        <20180709193850.20191-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709193850.20191-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Shreeya Patel <shreeya.patel23498@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

On Mon,  9 Jul 2018 21:38:50 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

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
> ---
> Changlog:
> v1: Fix handling of devm_gpiod_get_optional() return values - thanks to
>     Andy Shevchenko.
> v2: Remove problematic error code conversion, no longer needed if used
>     on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
>     devices back to init_machine") already in linux-next and commit
>     8853daf3b4ac ("gpiolib: Defer on non-DT find_chip_by_name()
>     failure") just applied to linux-gpio/devel.

Sorry, but we can't apply this patch now because of the dependency on
those 2 commits. I guess it's not a big issue if we defer it to 4.20.
Alternatively, we could consider queuing it to mtd/fixes after 4.19-rc1
is out, but we'll need a good reason to do that (like a regression
that this patch is supposed to fix). Note for your future contributions:
for this kind of cross-subsystem changes, it's better to let everything
go through a single tree (usually done by sending all patches in a
single series and explaining the dependencies between the patches in
the cover letter), but it's already too late here (I guess d08605a64e67
is in the omap tree and 8853daf3b4ac in the gpio one).

Regards,

Boris
