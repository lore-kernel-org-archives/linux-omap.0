From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: 3.5-rc3: PM/DSS broken (was vdd_mpu_iva warnings)
Date: Thu, 05 Jul 2012 08:58:46 +0100
Message-ID: <WC20120705075846.490440@terrafix.co.uk>
References: <WC20120618103957.6103F2@terrafix.co.uk> <87zk7h5096.fsf@ti.com> <WC20120703083759.980337@terrafix.co.uk> <4FF2B476.6000900@ti.com> <WC20120703091232.480345@terrafix.co.uk> <4FF2D089.8030507@ti.com> <WC20120703135255.990389@terrafix.co.uk> <87vci339rw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:48040 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557Ab2GEH7L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 03:59:11 -0400
In-Reply-To: <87vci339rw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, jaswinder.singh@linaro.org

> Already debugged and fixed. The exact solution is still under
> discussion, but while waiting for the right fix, you can use this patch
> and you should see CORE hitting retention:
> 
>    http://marc.info/?l=linux-omap&m=134000053229888&w=2
> 
> >
> > Also, why is it now saing "sh: write error: Operation not permitted"
> after waking, this never happened with 3.4?
> 
> I have seen this here and there and have never looked into why that is
> happening.  Clearly the write actually worked because the suspend
> happened, so I'm not sure what's going on there.
> 
> Kevin

Thanks!

That does indeed fix it...

Cheers,
Joe


