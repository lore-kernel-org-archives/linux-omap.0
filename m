From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Wed, 26 Feb 2014 23:29:27 +0200
Message-ID: <20140226212927.GB671@drone.musicnaut.iki.fi>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk>
 <20140226185331.GA17632@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:51495 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbaBZVaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 16:30:35 -0500
Content-Disposition: inline
In-Reply-To: <20140226185331.GA17632@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Leigh Brown <leigh@solinno.co.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Feb 26, 2014 at 07:53:32PM +0100, Sebastian Reichel wrote:
> On Wed, Feb 26, 2014 at 06:24:36PM +0000, Leigh Brown wrote:
> > Does anyone have a working .config that they could share with me?

Yes.

> > During my investigations I have discovered that the kernel
> > configuration has changed enormously in the last couple of years.  I
> > was worried that the N810 was no longer supported at allm especially
> > when I saw that a few of the old drivers (blizzard) had been
> > removed.  I was pleasantly surprised when I discovered that a lot of
> > the old drivers had been replaced by new ones.
> > 
> > I will document the latest state of play with the N810 once I have
> > got things going.  All I really want is a text console with working
> > keyboard and wifi, initially.

First the bad news: display support is not in the mainline kernel. Also
since linux-omap tree follows the mainline, it's not there either anymore.
Tomi removed the n8x0 panel driver some time ago (I don't know why), but
even then it wasn't working as the platform data failed to set up some
needed things properly. I was trying to get it working at but failed before
the driver got removed. Anyway, this is still on my "backlog" and at some
point I will try to reintroduce the display support. Meanwhile, the OMAP2
has been converted to DT so this is not going to be trivial so any help
in this effort is appreciated. (Read: please send patches :))

Good news: it's still possible to run current mainline Linux on N8x0.
But only basic functionality is there. You can interact with the device
at least over UART and USB (e.g. ssh connection with USB networking).
MMC and flash should work too. I haven't yet tested the WIFI. I'm booting
test kernels with 0xFFFF - the N8x0 has 2MB limitation for the kernel, so
I'm using kexec ("tiny kernel") to boot a full-featured kernel from MMC.
My kernel configs for 3.13 are available here:

	<http://www.iki.fi/aaro/comp/linux/v3.13/arm-testresults.html>.

Building a serial adapter to develop Linux on N8x0 isn't strictly necessary
as long as you get the USB is working. However it will ease things alot.
770/N800 are more friendly in this regard, as you can access the serial pins
without removing the battery.

A.
