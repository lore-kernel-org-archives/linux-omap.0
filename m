From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Date: Mon, 27 Aug 2018 15:37:23 +0200
Message-ID: <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon> <20180824152740.GD27483@lunn.ch>
 <20180825082722.567e8c9a@bbrezillon> <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827110055.122988d0@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-doc <linux-doc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Marek Vasut <marek.vasut@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Sven Van Asbroeck <svendev@arcx.com>, ope
List-Id: linux-omap@vger.kernel.org

2018-08-27 11:00 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Mon, 27 Aug 2018 10:56:29 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>> 2018-08-25 8:27 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>> > On Fri, 24 Aug 2018 17:27:40 +0200
>> > Andrew Lunn <andrew@lunn.ch> wrote:
>> >
>> >> On Fri, Aug 24, 2018 at 05:08:48PM +0200, Boris Brezillon wrote:
>> >> > Hi Bartosz,
>> >> >
>> >> > On Fri, 10 Aug 2018 10:04:58 +0200
>> >> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> >> >
>> >> > > +struct nvmem_cell_lookup {
>> >> > > + struct nvmem_cell_info  info;
>> >> > > + struct list_head        list;
>> >> > > + const char              *nvmem_name;
>> >> > > +};
>> >> >
>> >> > Hm, maybe I don't get it right, but this looks suspicious. Usually the
>> >> > consumer lookup table is here to attach device specific names to
>> >> > external resources.
>> >> >
>> >> > So what I'd expect here is:
>> >> >
>> >> > struct nvmem_cell_lookup {
>> >> >     /* The nvmem device name. */
>> >> >     const char *nvmem_name;
>> >> >
>> >> >     /* The nvmem cell name */
>> >> >     const char *nvmem_cell_name;
>> >> >
>> >> >     /*
>> >> >      * The local resource name. Basically what you have in the
>> >> >      * nvmem-cell-names prop.
>> >> >      */
>> >> >     const char *conid;
>> >> > };
>> >> >
>> >> > struct nvmem_cell_lookup_table {
>> >> >     struct list_head list;
>> >> >
>> >> >     /* ID of the consumer device. */
>> >> >     const char *devid;
>> >> >
>> >> >     /* Array of cell lookup entries. */
>> >> >     unsigned int ncells;
>> >> >     const struct nvmem_cell_lookup *cells;
>> >> > };
>> >> >
>> >> > Looks like your nvmem_cell_lookup is more something used to attach cells
>> >> > to an nvmem device, which is NVMEM provider's responsibility not the
>> >> > consumer one.
>> >>
>> >> Hi Boris
>> >>
>> >> There are cases where there is not a clear providier/consumer split. I
>> >> have an x86 platform, with a few at24 EEPROMs on it. It uses an off
>> >> the shelf Komtron module, placed on a custom carrier board. One of the
>> >> EEPROMs contains the hardware variant information. Once i know the
>> >> variant, i need to instantiate other I2C, SPI, MDIO devices, all using
>> >> platform devices, since this is x86, no DT available.
>> >>
>> >> So the first thing my x86 platform device does is instantiate the
>> >> first i2c device for the AT24. Once the EEPROM pops into existence, i
>> >> need to add nvmem cells onto it. So at that point, the x86 platform
>> >> driver is playing the provider role. Once the cells are added, i can
>> >> then use nvmem consumer interfaces to get the contents of the cell,
>> >> run a checksum, and instantiate the other devices.
>> >>
>> >> I wish the embedded world was all DT, but the reality is that it is
>> >> not :-(
>> >
>> > Actually, I'm not questioning the need for this feature (being able to
>> > attach NVMEM cells to an NVMEM device on a platform that does not use
>> > DT). What I'm saying is that this functionality is provider related,
>> > not consumer related. Also, I wonder if defining such NVMEM cells
>> > shouldn't go through the provider driver instead of being passed
>> > directly to the NVMEM layer, because nvmem_config already have a fields
>> > to pass cells at registration time, plus, the name of the NVMEM cell
>> > device is sometimes created dynamically and can be hard to guess at
>> > platform_device registration time.
>> >
>>
>> In my use case the provider is at24 EEPROM driver. This is where the
>> nvmem_config lives but I can't image a correct and clean way of
>> passing this cell config to the driver from board files without using
>> new ugly fields in platform_data which this very series is trying to
>> remove. This is why this cell config should live in machine code.
>
> Okay.
>
>>
>> > I also think non-DT consumers will need a way to reference exiting
>> > NVMEM cells, but this consumer-oriented nvmem cell lookup table should
>> > look like the gpio or pwm lookup table (basically what I proposed in my
>> > previous email).
>>
>> How about introducing two new interfaces to nvmem: one for defining
>> nvmem cells from machine code and the second for connecting these
>> cells with devices?
>
> Yes, that's basically what I was suggesting: move what you've done in
> nvmem-provider.h (maybe rename some of the structs to make it clear
> that this is about defining cells not referencing existing ones), and
> add a new consumer interface (based on what other subsystems do) in
> nvmem-consumer.h.
>
> This way you have both things clearly separated, and if a driver is
> both a consumer and a provider you'll just have to include both headers.
>
> Regards,
>
> Boris

I didn't notice it before but there's a global list of nvmem cells
with each cell referencing its owner nvmem device. I'm wondering if
this isn't some kind of inversion of ownership. Shouldn't each nvmem
device have a separate list of nvmem cells owned by it? What happens
if we have two nvmem providers with the same names for cells? I'm
asking because dev_id based lookup doesn't make sense if internally
nvmem_cell_get_from_list() doesn't care about any device names (takes
only the cell_id as argument).

This doesn't cause any trouble now since there are no users defining
cells in nvmem_config - there are only DT users - but this must be
clarified before I can advance with correctly implementing nvmem
lookups.

BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
instance even if the cell for this node was already added to the nvmem
device.

Bart
