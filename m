From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.19-rc1
Date: Sun, 4 Jan 2015 21:55:51 +0200
Message-ID: <20150104195550.GP582@fuloong-minipc.musicnaut.iki.fi>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com>
 <8629693.mvYldWiixb@wuerfel>
 <20150103134437.GO582@fuloong-minipc.musicnaut.iki.fi>
 <3902724.ayWKVuEiEg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:59200 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbbADT4A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2015 14:56:00 -0500
Content-Disposition: inline
In-Reply-To: <3902724.ayWKVuEiEg@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, kernel-build-reports@lists.linaro.org

Hi,

On Sun, Jan 04, 2015 at 05:46:31PM +0100, Arnd Bergmann wrote:
> On Saturday 03 January 2015 15:44:38 Aaro Koskinen wrote:
> > On Sat, Jan 03, 2015 at 01:51:53PM +0100, Arnd Bergmann wrote:
> > > On Saturday 03 January 2015 07:21:49 Paul Walmsley wrote:
> > > > Another ~300KB kernel object size increase for omap2plus_defconfig 
> > > > kernels.
> > > 
> > > 300kb seems like a lot for a single release. Have you looked into
> > > where this is coming from?
> > 
> > In 3.19-rc1, all initrd decompressors are by default enabled...
> 
> Interesting, this seems to be the opposite of the intention of the
> change that caused it, which tried to let you disable the algorithms
> without selecting CONFIG_EXPERT. For some reason that is impossible
> to know now, they already defaulted to 'n' when EXPERT was set, but
> now they default to 'y'.
> 
> Does this indeed cause the entire change in size?

Actually, no. It seems a bigger contributor is enabling SATA
in omap2plus_defconfig. But there still something else... Below is some
data based on quick checks.

v3.18 / omap2plus_defconfig:

	text     data   bss     dec             hex     filename
	8811980  790500 8423536 18026016        1130e20 vmlinux

v3.19-rc1 / omap2plus_defconfig:

	text     data   bss     dec             hex     filename
	9093858  800316 8419072 18313246        117701e vmlinux

v3.19-rc1 / omap2plus_defconfig + revert ec72c666fb34 ("usr/Kconfig: make
initrd compression algorithm selection not expert"):

	text     data   bss     dec             hex     filename
	9070939  800260 8419072 18290271        117165f vmlinux

v3.19-rc1 / omap2plus_defconfig + revert 661ea91b676b ("ARM:
omap2plus_defconfig: Enable AHCI_PLATFORM driver"):

	text     data   bss     dec             hex     filename
	8928148  792700 8414784 18135632        114ba50 vmlinux

v3.19-rc1 / omap2plus_defconfig + revert ec72c666fb34 & 661ea91b676b:

	text     data   bss     dec             hex     filename
	8901129  792644 8414784 18108557        114508d vmlinux

A.
