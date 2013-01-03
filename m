From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Thu, 3 Jan 2013 17:10:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301031704460.8721@utopia.booyaka.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1354530053.30168.183.camel@sauron.fi.intel.com> <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com> <50E40336.2080008@parrot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43722 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3ACRKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 12:10:18 -0500
In-Reply-To: <50E40336.2080008@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Wed, 2 Jan 2013, Matthieu CASTET wrote:

> I put a warning in order we fix drivers instead of a silent failure.
> 
> The omap driver was fixed in the same series with
> http://article.gmane.org/gmane.linux.ports.arm.omap/88551 and

... which got merged by Artem.

> http://article.gmane.org/gmane.linux.ports.arm.omap/88549

... which did not get merged because Tony requested that it should be 
based on top of his cleanup work (which takes priority over adding new 
features):

http://thread.gmane.org/gmane.linux.ports.arm.omap/88550/focus=88549

Could you please update this "omap3 nand : use NAND_BUSWIDTH_AUTO" patch 
on v3.8-rc2 and repost?

> For drivers that can't support ONFI, I don't know what to do.
> May we should be replace the WARN_ON by a printk and early return.

That sounds like a good idea to me.  The traceback seems excessive, since 
the NAND was usable before this series.


- Paul
