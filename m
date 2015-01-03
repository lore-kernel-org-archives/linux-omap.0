From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.19-rc1
Date: Sat, 3 Jan 2015 15:44:38 +0200
Message-ID: <20150103134437.GO582@fuloong-minipc.musicnaut.iki.fi>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com>
 <8629693.mvYldWiixb@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:57227 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbbACNor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2015 08:44:47 -0500
Content-Disposition: inline
In-Reply-To: <8629693.mvYldWiixb@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel-build-reports@lists.linaro.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Sat, Jan 03, 2015 at 01:51:53PM +0100, Arnd Bergmann wrote:
> On Saturday 03 January 2015 07:21:49 Paul Walmsley wrote:
> > Another ~300KB kernel object size increase for omap2plus_defconfig 
> > kernels.
> 
> 300kb seems like a lot for a single release. Have you looked into
> where this is coming from?

In 3.19-rc1, all initrd decompressors are by default enabled...

 CONFIG_RD_GZIP=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
-# CONFIG_RD_XZ is not set
-# CONFIG_RD_LZO is not set
-# CONFIG_RD_LZ4 is not set
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_RD_XZ=y
+CONFIG_RD_LZO=y
+CONFIG_RD_LZ4=y

A.
