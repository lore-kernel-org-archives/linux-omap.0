From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 17:12:23 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net> <CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com> <52A04E75.3010609@corscience.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42409 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402Ab3LEQM0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Dec 2013 11:12:26 -0500
In-Reply-To: <52A04E75.3010609@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas.biessmann@corscience.de>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org

> >> I'd like to be able to update MLO and u-boot from within a booted Linux
> >> system on the device (I have to resort to u-boot for that where I can
> >> control the ECC scheme used)

> > Meanwhile, to do this we use a small userspace program created by
> > Javier Martinez in order to flash the MLO in our OMAP3 boards. See
> > http://git.isee.biz/?p=pub/scm/writeloader.git;a=summary

> we used another aproach here. See
> http://article.gmane.org/gmane.linux.drivers.mtd/43804

pretty much what I have been looking for, thanks!

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
