From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: OMAP baseline test results for v3.19-rc1
Date: Sun, 04 Jan 2015 17:46:31 +0100
Message-ID: <3902724.ayWKVuEiEg@wuerfel>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com> <8629693.mvYldWiixb@wuerfel> <20150103134437.GO582@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60041 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbbADQqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2015 11:46:45 -0500
In-Reply-To: <20150103134437.GO582@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, kernel-build-reports@lists.linaro.org

On Saturday 03 January 2015 15:44:38 Aaro Koskinen wrote:
> 
> On Sat, Jan 03, 2015 at 01:51:53PM +0100, Arnd Bergmann wrote:
> > On Saturday 03 January 2015 07:21:49 Paul Walmsley wrote:
> > > Another ~300KB kernel object size increase for omap2plus_defconfig 
> > > kernels.
> > 
> > 300kb seems like a lot for a single release. Have you looked into
> > where this is coming from?
> 
> In 3.19-rc1, all initrd decompressors are by default enabled...
> 
>  CONFIG_RD_GZIP=y
> -# CONFIG_RD_BZIP2 is not set
> -# CONFIG_RD_LZMA is not set
> -# CONFIG_RD_XZ is not set
> -# CONFIG_RD_LZO is not set
> -# CONFIG_RD_LZ4 is not set
> +CONFIG_RD_BZIP2=y
> +CONFIG_RD_LZMA=y
> +CONFIG_RD_XZ=y
> +CONFIG_RD_LZO=y
> +CONFIG_RD_LZ4=y
> 

Interesting, this seems to be the opposite of the intention of the
change that caused it, which tried to let you disable the algorithms
without selecting CONFIG_EXPERT. For some reason that is impossible
to know now, they already defaulted to 'n' when EXPERT was set, but
now they default to 'y'.

Does this indeed cause the entire change in size?

	Arnd
