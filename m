From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 09:13:26 -0800
Message-ID: <20131205171326.GA26766@atomide.com>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
 <CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
 <52A04E75.3010609@corscience.de>
 <alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43134 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756945Ab3LERNb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 12:13:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Andreas =?utf-8?B?Qmllw59tYW5u?= <andreas.biessmann@corscience.de>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org

* Peter Meerwald <pmeerw@pmeerw.net> [131205 08:13]:
> > >> I'd like to be able to update MLO and u-boot from within a booted Linux
> > >> system on the device (I have to resort to u-boot for that where I can
> > >> control the ECC scheme used)
> 
> > > Meanwhile, to do this we use a small userspace program created by
> > > Javier Martinez in order to flash the MLO in our OMAP3 boards. See
> > > http://git.isee.biz/?p=pub/scm/writeloader.git;a=summary
> 
> > we used another aproach here. See
> > http://article.gmane.org/gmane.linux.drivers.mtd/43804
> 
> pretty much what I have been looking for, thanks!

Hmm well both methods should work, but is there anything stopping us
merging the module param patch to the mainline tree?

Regards,

Tony
