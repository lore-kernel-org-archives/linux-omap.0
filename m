From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: OMAP baseline test results for v3.19-rc1
Date: Sat, 03 Jan 2015 13:51:53 +0100
Message-ID: <8629693.mvYldWiixb@wuerfel>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56906 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbbACMv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2015 07:51:59 -0500
In-Reply-To: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kernel-build-reports@lists.linaro.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 03 January 2015 07:21:49 Paul Walmsley wrote:
> Another ~300KB kernel object size increase for omap2plus_defconfig 
> kernels.

300kb seems like a lot for a single release. Have you looked into
where this is coming from?

	Arnd
