From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Tue, 23 Oct 2012 08:24:36 -0400
Message-ID: <20121023122436.GC1855@beef>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
 <50857444.9080308@ti.com>
 <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com>
 <50859505.5010306@ti.com>
 <20121023015346.GB1855@beef>
 <alpine.DEB.2.00.1210230311490.31118@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49331 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299Ab2JWMYh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 08:24:37 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5134456iea.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 05:24:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210230311490.31118@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Oct 23, 2012 at 03:15:44AM +0000, Paul Walmsley wrote:
> On Mon, 22 Oct 2012, Matt Porter wrote:
> 
> > I've mentioned this a few times in various threads...no need to use
> > appended DTB on a current U-Boot. Some of us are indeed booting this way
> > with the DTB properly passed separately from the bootloader and chosen
> > filled out by the bootloader. And yes, am335x_evm_config applies to all
> > AM33xx TI EVMs and the BeagleBone board. There's an EEPROM onboard all
> > that is used to determine what board is present so a single
> > MLO/u-boot.img can be used.
> 
> As Kevin mentioned earlier, this is unfortunately not true for those of us 
> with earlier BeagleBoards:
> 
>    http://marc.info/?l=linux-omap&m=135094296931913&w=2

Yes, we spoke about this a bit.
 
> Do you know what the minimum board revision is that you all are 
> supporting in U-boot?

It's not so much a revision as it is getting the right contents in the
EEPROM. As it's a community board, it's generally only supported over at
beagleboard@googlegroups.com. Jason Kridner recommends posting support
questions there (like why isn't my A2 supported in U-Boot?). If there
isn't some solution suggested there for updating the A2 I would contact
him directly. I have an A1 Bone here that also doesn't work with
mainline U-Boot even after configuring the EEPROM. You can try this
procedure if you want to write the proper contents in, an A2 may work
but for some reason there's no available history on Bone revisions prior
to A3. I vaguely recall a lot of chatter around the phy and so forth in
the A1 to A2 timeframe so it's entirely possible that your A2 will work
with just the eeprom contents programmed. Without it, it's guaranteed to
fail as the pin muxing is tied to detecting the board this way. Also,
you may need to change <offset>.1 in the below example to <offset>.2 for
your eeprom i/o to work as A2 may require an address length of 2.

-Matt

U-Boot 2012.10-00286-gfe27b3b (Oct 22 2012 - 16:40:21)

I2C:   ready
DRAM:  256 MiB
WARNING: Caches not enabled
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Using default environment

Net:   PHY reset timed out
cpsw
Hit any key to stop autoboot:  0
U-Boot# i2c dev 0
Setting bus to 0
U-Boot# i2c md 50 0.1
0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
................
U-Boot# mm.b 84000000
84000000: 55 ? aa
84000001: 51 ? 55
84000002: 16 ? 33
84000003: 00 ? ee
84000004: 40 ? 41
84000005: 94 ? 33
84000006: 28 ? 33
84000007: 41 ? 35
84000008: 11 ? 42
84000009: 55 ? 4f
8400000a: 80 ? 4e
8400000b: 8e ? 45
8400000c: 03 ? 30
8400000d: 5d ? 30
8400000e: 44 ? 41
8400000f: a0 ? 32
84000010: 46 ? .
U-Boot# i2c write 84000000 50 0.1 10
U-Boot# i2c md 50 0.1 10
0000: aa 55 33 ee 41 33 33 35 42 4f 4e 45 30 30 41 32
.U3.A335BONE00A2
U-Boot#

