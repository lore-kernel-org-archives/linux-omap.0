From: Ben Gamari <bgamari.foss@gmail.com>
Subject: McSPI questions pertaining to GPIO chip select support
Date: Wed, 27 Jan 2010 23:10:26 -0500
Message-ID: <1264651770-sup-5197@ben-laptop>
References: <1264016711-sup-309@ben-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:35592 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0A1EKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 23:10:31 -0500
Received: by qw-out-2122.google.com with SMTP id 8so58710qwh.37
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 20:10:30 -0800 (PST)
In-reply-to: <1264016711-sup-309@ben-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael

Hey all!

Recently I've been thinking about adding support to the McSPI driver for
using GPIO pins as chip selects. As a starting point, I've browsed the
driver source trying to identify what changes would be necessary to add
this support. It seems like the rough idea is,

  a) add a cs_gpio field to the device struct (omap2_mcspi)
  b) modify omap2_mcspi_force_cs() to use cs_gpio instead of the
     CHxCONF[FORCE] bit if cs_gpio is valid

Unfortunately, I'm having a bit of difficulty seeing how the existing
configuration works. In master mode, it seems that the controller is
configured in single forced channel mode (MCSPI_MODULECTRL_SINGLE).  As
far as I can tell, this means that the driver is responsible for
managing the chip selects through the MCSPI_CHxCONF[FORCE] bits. It
seems that this is ideal as little will need to be changed to
incorporate GPIO CS support.

Nevertheless, the timing of the various operations isn't making sense to
me. As far as I understand it, the callgraph is as follows,


omap2_mcspi_work():
  loop over messages
    omap2_mcspi_set_enable(1)
    loop over transfers:
      configure bus parameters
      if (!cs_active) cs = 1
      if (dma):
        omap2_mcspi_txrx_dma()
      else:
        omap2_mcspi_txrx_pio()
      if (cs_change) cs = 0
    end loop
  
    if (cs_active) cs = 0
    omap2_mcspi_set_enable(0)
  end loop


It seems that omap2_mcspi_set_enable() is called to enable the channel
(MCSPI_CHCTRLx[EN] is set) before force_cs() is called. If I'm
interpreting the hardware documentation correctly, the enable bit (among
other things) starts the SPI clock, meaning that the chip will begin
clocking out zeros to the device before CS is brought high.
Furthermore, even after CS is brought high, it seems there could be a
fair amount of time before the chip begins actually clocking out valid
data.

As I am writing this, it now occurs to me that perhaps the chip doesn't
start SPI_CLK until it has data to send. It seems that if this were the
case my concerns would be resolved. However, it is not at all clear that
this is the case from the documentation. When exactly does the
controller start the bus clock? Is this stated explicitly anywhere in
the documentation?

Any input you could offer would be greatly appreciated.
Thanks for your time.

- Ben


P.S. The more and more I think about it, it seems like my hypothesis is
the only logical behavior. It would be great if someone could confirm my
suspicions, however. It really seems like this should be in the
documentation either way.

P.P.S. I apologize if this is something someone familiar with SPI should
just know. My knowledge is a little spotty on this sort of thing.
