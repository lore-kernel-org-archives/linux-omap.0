From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v9 4/9] mtd: nand: omap: enable auto-detection of
 bus-width for omap-nand drivers
Date: Sat, 19 Oct 2013 09:11:39 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA28D68@DBDE04.ent.ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-5-git-send-email-pekon@ti.com>
 <20131016222248.GZ23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA27917@DBDE04.ent.ti.com>
 <20131017183016.GG23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA280A4@DBDE04.ent.ti.com>
 <20131017214349.GH23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab3JSJM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 05:12:29 -0400
In-Reply-To: <20131017214349.GH23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Brian,

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> On Thu, Oct 17, 2013 at 09:00:27PM +0000, Pekon Gupta wrote:
> > > From: Brian Norris [mailto:computersforpeace@gmail.com]
> > > > On Thu, Oct 17, 2013 at 04:42:23AM +0000, Pekon Gupta wrote:
 [...]

> > > But the real point: you need to clearly communicate what you are
> > > choosing in this patch. Either you want to
> > >
> > >  (1) strictly follow the buswidth provided by the platform or
> > >
> > >  (2) use the nand_base.c BUSWIDTH_AUTO automatic configuration.
> > >
> > Ideally, I would like to go with (2), but that would need other changes
> > in-order to re-configure GPMC with newly parsed ONFI data, which
> > can be a separate patch-set.
> 
> What exactly needs changed to support this? It looks like this omap2
> NAND driver doesn't make assumptions about 8-bit vs. 16-bit until after
> nand_scan_ident(). But maybe there is something I missed.
> 
The GPMC driver will be touched by NAND_BUSWIDTH_AUTO change.
There are two set of configurations in GPMC controller..
(a) device based configurations:
  These are static configurations derived on DT bindings for each
  chip-select (like NAND signal timings, etc). These done on GPMC probe.
(b) ecc-scheme based configurations:
  These are dynamic configurations done in NAND driver in
  chip->ecc.hwctl() and are refreshed at each NAND accesss.

However, 'nand-bus-width' configuration is part of both (1) and (2).
Thus, both 'OMAP NAND driver' and 'GPMC driver' need to be
consistent in programming  'nand-bus-width' otherwise ecc-engine
would not work.
Thus, I'm proceeding with (1) DT based parsing of 'nand-bus-width'.


> > Thus, I would drop this patch for now. And go with (1),
> 
> OK, but to drop this patch entirely would still not be (1); it would
> still leave the possibility of calling nand_scan_ident() twice, and it
> puts you in a middle ground between (1) and (2). That's fine if it works
> for you, but I just want to acknowledge that now: this driver requires
> changes to become either (1) or (2).
> 
I have re-posted [PATCH v10 4/10] with this updates. However, please
take into account that some limitation of dual programming require
such probe. New patch also call nand_scan_ident() twice, but only
on certain pre-determined conditions, not in all failure.
Once I convert to NAND_BUSWIDTH_AUTO these should get clean,
 as I would update both GPMC and NAND driver for this.
(Till then this was most optimal solution I could think of)..


> Does your series need a rebase if we're removing this patch? Or you're
> rewriting/simplifying it to the following two points? (Perhaps it's
> best to separate this portion to its own patch (set) and discussion,
> since it is independent of your ECC rewrite.)
> 
> > with following
> > updates in  omap_nand_probe().
> >
> > (a) perform nand_scan_ident() in "x8" mode, so that ONFI params are
> >     read and device-info (chip->writesize, chip->oobsize) are populated.
> 
> OK.
> 
> > (b) Then switch to "x8" or "x16" mode based on "nand-bus-width"
> >     as passed from GPMC driver to NAND driver via platform-data.
> >    And re-populate mtd->byte, mtd-read_buf, mtd->write_buf.
> 
> I'm not sure if switching buswidth after nand_scan_ident() is really
> supported, but I'll hold off until I see the code you're proposing.
> 
I have re-posted [PATCH v10 4/10] with this updates.
Please accept this ...


with regards, pekon
