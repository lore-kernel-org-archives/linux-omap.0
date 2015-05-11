From: Michael Welling <mwelling@ieee.org>
Subject: Re: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Mon, 11 May 2015 13:54:51 -0500
Message-ID: <20150511185451.GA16240@deathray>
References: <5550DDCB.8010303@ti.com>
 <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38827 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbbEKSzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 14:55:53 -0400
Content-Disposition: inline
In-Reply-To: <5550F47C.1030902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-spi@vger.kernel.org

On Mon, May 11, 2015 at 01:27:08PM -0500, Nishanth Menon wrote:
> On 05/11/2015 12:07 PM, Michael Welling wrote:
> > On Mon, May 11, 2015 at 11:50:19AM -0500, Nishanth Menon wrote:
> >> Hi,
> >>
> >> SDP4430 uses a SPI based network chip ks8851.
> >>
> >> next-20150508:
> >> https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt
> >>
> >> However, next-20150511:
> >> https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt
> >>
> > 
> > I will look into this but it is going to be difficult to debug with access to the hardware.
> > This is what I get for changing a driver that effects so many SoCs.
> > 
> 
> Let me know if there is any test patch you'd want me to run. The board
> is on a remote "board farm" which most of TI folks have access to as
> well.. So, if you need anything run, just send out a debug patch OR a
> potential fix and we can help try it out and provide logs back for
> your debug.
>

So it appears that I have broken the native chip select support.

I have a serial flash at spi0cs0 and if I use the GPIO for chip select
it detects:
m25p80 spi1.0: n25q128a13 (16384 Kbytes)

If I use the native chip select it does not:
m25p80 spi1.0: unrecognized JEDEC id bytes: ff, ff, ff

This allows me to find the issue and provide a follow up patch.
I will provide it when I have it ready to see if it fixes your issue.

If I cannot find a fix, we may have to revert these changes.

> 
> -- 
> Regards,
> Nishanth Menon
