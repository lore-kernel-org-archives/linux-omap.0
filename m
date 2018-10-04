From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
Date: Thu, 4 Oct 2018 10:35:08 -0400
Message-ID: <20181004143508.GG13299@oracle.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com>
 <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
 <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linux I2C <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, Bartosz Golaszewski <brgl@bgdev.pl>, Brian Norris <briannorris@chromium.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Marek Vasut <marek.vasut@gmail.com>, pabeni@redhat.com, Dan Carpenter <dan.carpenter@oracle.com>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, svendev@arcx.com, Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap
List-Id: linux-omap@vger.kernel.org

Just catching up on this thread, so please excuse any unintentional
misquotes here.

> > > > David: I couldn't find a place in sparc code where any ethernet device
> > > > would be registered, so is there a chance that nobody is using it?
> > >
> > > SPARC uses a true Open Firmware implementation, so it would register
> > > drivers through the CONFIG_OF infrastructure.

correct

> The calls are not even that old, and clearly added intentionally for sparc,
> see commit ba94272d08a7 ("i40e: use eth_platform_get_mac_address()")
> which added the first one.

Yes, correct again. Wouldn't PPC also end up doing the same thing?

See also commit c762dff24c06 (for ixgbe) - without this fix sparc systems
will come up with a bogus mac address and then you end up having to
manually fix this in ugly ways.

--Sowmini



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
