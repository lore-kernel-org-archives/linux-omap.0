From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
Date: Tue, 26 Jun 2018 10:38:23 +0200
Message-ID: <20180626083823.GA28068@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch>
 <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 26, 2018 at 09:44:19AM +0200, Bartosz Golaszewski wrote:
> 2018-06-25 20:02 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> >> With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
> >> the nvmem provider is not yet registered. Will that help in your case?
> >
> > I don't think so. My driver instantiates the AT24 device. So if i get
> > -EPROBE_DEFER, i need to cleanup the probe, and return -EPROBDE_DEFER
> > to the code. Which means i need to remove the AT24 device...
> >
> >        Andrew
> 
> Are you sure this is the correct approach? I understand that you want
> to use something like board files for your machine? Wouldn't it be
> better to register a platform device for at24, register a cell lookup
> and then depend on that cell from your driver?

Hi Bartosz

The machine is based around a Kontron Com Express module, with an
intel Ivy Bridge CPU. This is then placed into a custom carrier board,
which has a number of i2c devices.

I have a platform driver which matches on the DMI system ID for the
Kontron module.

The Com Express module has a PLD which implements i2c, gpio,
etc. There is an MFD for this, which instantiates the i2c-kempld i2c
bus driver.

My platform driver finds this i2c-kempld bus driver. If it does not
exist yet, it return -EPROBE_DEFER. If it is found it instantiates an
at24 device on it. I need to look at the content of the EEPROM to
determine the hardware revision, plus do a checksum.  From that, i
need to instantiates 1 or 2 additional AT24, up to 4 GPIO expanders,
and i2c to spi converter, add some gpio-leds on the gpio expanders,
create a bit-banging MDIO bus, instantiate an Ethernet switch on the
MDIO bus, maybe add an Ethernet switch to the SPI bus, etc.

As you can see, i have a chain of events. I cannot move onto the next
part of the chain until i know the probe for the previous part has
finished. e.g. i cannot add gpio-leds until i know the gpio expander
has probed. But the gpio expander provides a call back, similar to the
at24 setup(). The MDIO bus and the SPI bus has a mechanism to register
an info structure, just like you have done for NVMEM cells. So that
works out.

The weak link in this chain is that first at24 probe, and knowing when
i can access the nvmem cells for the revision and checksum
information. -EPROBE_DEFER does not help me here. I need either some
sort of blocking wait for the cells to become available, or a callback
in a context which allows me to instantiate more devices.

I also have some steps which cannot be undone. You don't provide a
mechanism to unregister the nvmem info structure. The I2C and MDIO
equivalent also does not provide an unregister for bus info. So once i
register the first info structure, i'm past the point of no return. I
cannot return -EPROBE_DEFER because i cannot unregister the info
structures, so that i can register them again the next time the
platform driver gets probed.

	 Andrew
