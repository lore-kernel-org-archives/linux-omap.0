From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: AM335x BeagleBone SPI Issues
Date: Fri, 04 Jan 2013 15:46:41 +0100
Message-ID: <1357310801.23039.24.camel@coredoba.hi.pengutronix.de>
References: <50C5E23D.5040605@communistcode.co.uk>
	 <20121210135337.GA10219@arwen.pp.htv.fi>
	 <50C5F6A8.5060701@communistcode.co.uk>
	 <20121210145947.GK11038@arwen.pp.htv.fi>
	 <50C5FD73.1000408@communistcode.co.uk>
	 <20121210183500.GB14303@arwen.pp.htv.fi>
	 <50C70846.7010207@communistcode.co.uk> <87y5h4r4ul.fsf@gmail.com>
	 <50C75E54.2080805@communistcode.co.uk> <50C7671B.80504@communistcode.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43762 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab3ADOqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 09:46:46 -0500
In-Reply-To: <50C7671B.80504@communistcode.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ml@communistcode.co.uk
Cc: Ben Gamari <bgamari.foss@gmail.com>, balbi@ti.com, linux-omap@vger.kernel.org

Hi,

On Tue, 2012-12-11 at 17:02 +0000, Jack Mitchell wrote:
> On 11/12/12 16:24, Jack Mitchell wrote:
> > On 11/12/12 15:22, Ben Gamari wrote:
> >> Jack Mitchell <ml@communistcode.co.uk> writes:
> >>> Thank you, the reordering dma patch fixed the dma issue I was having!
> >>> However, the bad news, I now get the same results for the dma and
> >>> non-dma spidev test. While the scope shows the SPI clk and data is 
> >>> fine,
> >>> the reading from the program still shows 0x00 for all words.
> >>>
> >> Just to make sure this has been thought of: I've seen this sort of
> >> behavior in the past when the CLK pin wasn't configured as an input.

*snip*

> My bad! The jumper bridge had come loose, it works now! Yippee!
> 
> root@beaglebone:~# ./spidev -D /dev/spidev2.0
> spi mode: 0
> bits per word: 16
> max speed: 24000000 Hz (24000 KHz)
> 
> FF FF FF FF FF FF
> 40 00 00 00 00 95
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> FF FF FF FF FF FF
> DE AD BE EF BA AD
> F0 0D
> root@beaglebone:~#
> 
> Thanks everyone, and do I need to submit any patches to clear this all up?
> 
> Currently all I see is changing the clk pins from output to input (if 
> this is a valid change?).

I just stumbled over the same problem and have not seen any patch for
this fix. Have I missed something or should I send a patch? Which would
be the correct base for such a patch?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

