From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] mtd: rawnand: ams-delta: Drop board specific
 partition info
Date: Wed, 17 Apr 2019 11:40:10 +0200
Message-ID: <20190417114010.774693cf@xps13>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com>
        <20190324223344.24590-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190324223344.24590-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Sun, 24 Mar 2019
23:33:44 +0100:

> After recent modifications, only a hardcoded partition info makes
> the driver device specific.  Other than that, the driver uses GPIO
> exclusively and can be used on any hardware.
> 
> Drop the partition info and use MTD partition parser with default list
> of parser names instead.  For the OF parser to work correctly, pass
> device of_node to mtd.
> 
> Amstrad Delta users should append the following partition info to their
> kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> 
> mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).
> 
> For their convenience, CONFIG_MTD_CMDLINE_PARTS symbol is selected
> automatically from that board Kconfig if this NAND driver is also
> selected.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---

FYI I am okay with the change but I am waiting for acks before applying
it.

Thanks,
Miquèl
