From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
Date: Mon, 20 May 2013 04:44:31 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9C5629@DBDE04.ent.ti.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
 <517F5126.5000509@ti.com> <20130508235404.GX32546@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9C320D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9C320D@DBDE04.ent.ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Philip, Avinash" <avinashphilip@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "zonque@gmail.com" <zonque@gmail.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

 
> > > >
> > > >  	am33xx_pinmux: pinmux@44e10800 {
> > > >  		pinctrl-names = "default";
> > > > -		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
> > > > +		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0
> > > > +			&nandflash_pins_s0>;
> > >
> > > Why add this to the board level fallback (called pinctrl hogs, I think)?
> > > This can be part of nand node you added below so that the pinctrl will
> > > take effect when nand gets probed instead of all the time.
> >
> > Yes we should have all the pinctrl entries under the related drivers.
> > This makes it easy remux pins during runtime if needed, and also
> > allows unloading pinctrl-single.ko for development.
> >
> Yes, accepted. This has been already fixed in v3 of this patch set.
> If all fine, then please pull this for next merge..
> 
> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046712.html
> 
> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046814.html
> 
> http://lists.infradead.org/pipermail/linux-mtd/2013-May/046710.html
> 
> 
> with regards, pekon

Request you to please accept | provide feedbacks on this patch series.
These are waiting acceptance since Jan-2013, and are necessary for 
DT based configs for board having NAND support.

with regards, pekon
