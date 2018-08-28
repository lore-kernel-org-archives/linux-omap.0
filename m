From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Date: Tue, 28 Aug 2018 11:15:12 +0100
Message-ID: <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl> <20180824170848.29594318@bbrezillon>
 <20180824152740.GD27483@lunn.ch> <20180825082722.567e8c9a@bbrezillon>
 <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
 <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-doc <linux-doc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Marek Vasut <marek.vasut@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Sven Van Asbroeck <svendev@arcx.com>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


On 27/08/18 14:37, Bartosz Golaszewski wrote:
> I didn't notice it before but there's a global list of nvmem cells

Bit of history here.

The global list of nvmem_cell is to assist non device tree based cell 
lookups. These cell entries come as part of the non-dt providers 
nvmem_config.

All the device tree based cell lookup happen dynamically on 
request/demand, and all the cell definition comes from DT.

As of today NVMEM supports both DT and non DT usecase, this is much simpler.

Non dt cases have various consumer usecases.

1> Consumer is aware of provider name and cell details.
	This is probably simple usecase where it can just use device based apis.

2> Consumer is not aware of provider name, its just aware of cell name.
	This is the case where global list of cells are used.

> with each cell referencing its owner nvmem device. I'm wondering if
> this isn't some kind of inversion of ownership. Shouldn't each nvmem
> device have a separate list of nvmem cells owned by it? What happens
This is mainly done for use case where consumer does not have idea of 
provider name or any details.

First thing non dt user should do is use "NVMEM device based consumer APIs"

ex: First get handle to nvmem device using its nvmem provider name by 
calling nvmem_device_get(); and use nvmem_device_cell_read/write() apis.

Also am not 100% sure how would maintaining cells list per nvmem 
provider would help for the intended purpose of global list?

> if we have two nvmem providers with the same names for cells? I'm
Yes, it would return the first instance.. which is a known issue.
Am not really sure this is a big problem as of today! but am open for 
any better suggestions!


> asking because dev_id based lookup doesn't make sense if internally
> nvmem_cell_get_from_list() doesn't care about any device names (takes
> only the cell_id as argument).

As I said this is for non DT usecase where consumers are not aware of 
provider details.

> 
> This doesn't cause any trouble now since there are no users defining
> cells in nvmem_config - there are only DT users - but this must be
> clarified before I can advance with correctly implementing nvmem
> lookups.
DT users should not be defining this to start with! It's redundant and 
does not make sense!

> 
> BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
> instance even if the cell for this node was already added to the nvmem
> device.
I hope you got the reason why of_nvmem_cell_get() always allocates new 
instance for every get!!

thanks,
srini
