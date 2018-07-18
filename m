From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 19:03:52 +0200
Message-ID: <20180718170352.GF12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
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

> >> +#ifdef CONFIG_MTD
> >> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
> >> +     if (!addr) {
> >> +             struct mtd_info *mtd;
> >> +             int rv;
> >> +
> >> +             mtd = get_mtd_device_nm("MAC-Address");
> >
> > In order for this to go away, you need to keep backwards
> > compatibility. When using nvmem, you look for a cell called
> > "mac-address". Here you are looking for "MAC-Address". That is going
> > to make backwards compatibility harder. How do you plan to do it?
> >
> >    Andrew
> 
> I'm trying to adjust to already existing users. The only user of
> get_mtd_device_nm() who calls it to read the MAC address registers a
> partition called "MAC-Address". We can't change it since it's visible
> from user space. In the future we'd just have to have a list of
> supported string that we'd use to do the nvmem lookup.

Why not have the nvmem cell called "MAC-Address"? When you add nvmem
support to MTD, i assume you are going to map each MTD partition to an
nvmem cell?

    Andrew
