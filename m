From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Date: Fri, 24 Aug 2018 17:27:40 +0200
Message-ID: <20180824152740.GD27483@lunn.ch>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180824170848.29594318@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 24, 2018 at 05:08:48PM +0200, Boris Brezillon wrote:
> Hi Bartosz,
> 
> On Fri, 10 Aug 2018 10:04:58 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > +struct nvmem_cell_lookup {
> > +	struct nvmem_cell_info	info;
> > +	struct list_head	list;
> > +	const char		*nvmem_name;
> > +};
> 
> Hm, maybe I don't get it right, but this looks suspicious. Usually the
> consumer lookup table is here to attach device specific names to
> external resources.
> 
> So what I'd expect here is:
> 
> struct nvmem_cell_lookup {
> 	/* The nvmem device name. */
> 	const char *nvmem_name;
> 
> 	/* The nvmem cell name */
> 	const char *nvmem_cell_name;
> 
> 	/*
> 	 * The local resource name. Basically what you have in the
> 	 * nvmem-cell-names prop.
> 	 */
> 	const char *conid;
> };
> 
> struct nvmem_cell_lookup_table {
> 	struct list_head list;
> 
> 	/* ID of the consumer device. */
> 	const char *devid;
> 
> 	/* Array of cell lookup entries. */
> 	unsigned int ncells;
> 	const struct nvmem_cell_lookup *cells;
> };
> 
> Looks like your nvmem_cell_lookup is more something used to attach cells
> to an nvmem device, which is NVMEM provider's responsibility not the
> consumer one.

Hi Boris

There are cases where there is not a clear providier/consumer split. I
have an x86 platform, with a few at24 EEPROMs on it. It uses an off
the shelf Komtron module, placed on a custom carrier board. One of the
EEPROMs contains the hardware variant information. Once i know the
variant, i need to instantiate other I2C, SPI, MDIO devices, all using
platform devices, since this is x86, no DT available.

So the first thing my x86 platform device does is instantiate the
first i2c device for the AT24. Once the EEPROM pops into existence, i
need to add nvmem cells onto it. So at that point, the x86 platform
driver is playing the provider role. Once the cells are added, i can
then use nvmem consumer interfaces to get the contents of the cell,
run a checksum, and instantiate the other devices.

I wish the embedded world was all DT, but the reality is that it is
not :-(

    Andrew
