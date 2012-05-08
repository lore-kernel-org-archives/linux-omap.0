From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2 3.4-rc6] MTD: NAND: ams-delta: fix request_mem_region() failure
Date: Tue, 08 May 2012 20:46:25 +0200
Message-ID: <13373590.4hsHpBS0MY@acer>
References: <20120504171125.GD5613@atomide.com> <1336460605.23308.8.camel@sauron.fi.intel.com> <1336461106.23308.12.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336461106.23308.12.camel@sauron.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dedekind1@gmail.com
Cc: David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Dnia wtorek, 8 maja 2012 10:11:46 Artem Bityutskiy pisze:
> On Tue, 2012-05-08 at 10:03 +0300, Artem Bityutskiy wrote:
> > On Mon, 2012-05-07 at 22:51 +0200, Janusz Krzysztofik wrote:
> > > A call to request_mem_region() has been introduced in the omap-
gpio
> > > driver recently (commit 96751fcbe5438e95514b025e9cee7a6d38038f40,
> > > "gpio/omap: Use devm_ API and add request_mem_region"). This 
change
> > > prevented the Amstrad Delta NAND driver, which was doing the same 
in
> > > order to take control over OMAP MPU I/O lines that the NAND device 
hangs
> > > off, from loading successfully.
> > 
> > Aiaiai found out that your patch adds this gcc warning:
> > 
> > 
--------------------------------------------------------------------------------
> > 
> > Successfully built configuration "l2_omap1_defconfig,arm,arm-unknown-
linux-gnueabi-", results:
> > 
> > --- before_patching.log
> > +++ after_patching.log
> > @@ @@
> > +drivers/mtd/nand/ams-delta.c: In function 'ams_delta_cleanup':
> > +drivers/mtd/nand/ams-delta.c:285:19: warning: unused variable 'res' 
[-Wunused-variable]
> > 
> > 
--------------------------------------------------------------------------------
> 
> But I've fixed this up and pushed to l2-mtd.git.

Many thanks for this.

> From the commit message
> I have an impression that you are not going to implement that longer
> term plan.

I just didn't state 'I'll do it for the next merge window' because my 
spare time resources are limited, and I've at least one set of changes 
to the Amstrad Delta code still waiting on my todo list.

I'll try to implement that long term plan as my spare time permits.

Thanks,
Janusz
