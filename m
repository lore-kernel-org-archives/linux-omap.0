From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Sun, 21 Oct 2012 14:36:52 +0200
Message-ID: <20121021123652.GA15421@netboy.at.omicron.at>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121021073551.GA4735@netboy.at.omicron.at>
 <C8443D0743D26F4388EA172BF4E2A7A93EA012D8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33150 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab2JUMhD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 08:37:03 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1505877wgb.1
        for <linux-omap@vger.kernel.org>; Sun, 21 Oct 2012 05:37:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA012D8@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Oct 21, 2012 at 12:29:26PM +0000, Mohammed, Afzal wrote:
> Hi Richard,
> 
> * Richard Cochran, October 21, 2012 1:05 PM:
> 
> > People keep saying, the beaglebone works fine with v3.7-rc1, but it
> > isn't true. Now v3.7-rc2 is out, and the gpmc issue still has not been
> > fixed, and no one is doing anything about it either.
> 
> A fix to resolve the gpmc issue has been merged recently, so I am
> expecting beagle bone to boot on -rc2 (I don't have hardware to test,
> on vacation now), can you please try with -rc2.

I am happy to report that v3.7-rc2 boots via the modern DT method,
using Paul's am33xx_only config and U-Boot 2012.10-rc1-00148-g4668a08.

Thanks, and have a nice vacation,
Richard
