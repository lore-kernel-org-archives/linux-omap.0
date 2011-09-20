From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Tue, 20 Sep 2011 23:34:43 +0200
Message-ID: <201109202334.43213.arnd@arndb.de>
References: <20110917014623.GC2937@atomide.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zbQeOWHOFO85sX8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1ITVeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 17:34:50 -0400
In-Reply-To: <20110917014623.GC2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--Boundary-00=_zbQeOWHOFO85sX8
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Saturday 17 September 2011, Tony Lindgren wrote:
> Hi Arnd,
> 
> Please pull the first part of omap cleanup from:
> 
> git://github.com/tmlind/linux.git cleanup
> 
> This series cleans up early_init functions and removes
> CHIP_IS macro usage. This makes it easier to have SoC
> specific init functions so adding support for new omap
> variants does not require patching all over the place.

One more thing: my randconfig tests are running now and
have spit out a new error after merging lost of stuff
today:

arch/arm/mach-omap2/built-in.o: In function `omap_zoom_init':
/home/arnd/linux-arm/arch/arm/mach-omap2/board-zoom.c:117: undefined reference to `board_nand_init'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Target `_all' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `_all' not remade because of errors.

It's not clear to me if this is actually caused by one of your
changes, or just a mismerge of some sort. I've attached
the defconfig that was used for your reference.

Also, I've got a branch with lots of omap specific randconfig
patches at

git://git.linaro.org/people/arnd/linux.git randconfig/omap

Probably not all of them are correct, but it would be nice
if you could take a look and cherry-pick the ones you like.

	Arnd

--Boundary-00=_zbQeOWHOFO85sX8
Content-Type: application/x-gzip;
  name="defconfig.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="defconfig.gz"

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
JZiIC/w/QLE7plcmAAA=

--Boundary-00=_zbQeOWHOFO85sX8--
