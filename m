From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V6 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Thu, 3 May 2012 08:06:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA12328@DBDE01.ent.ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
	<1335967014-11937-4-git-send-email-hvaibhav@ti.com> <87mx5qfhb4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab2ECIGu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 04:06:50 -0400
In-Reply-To: <87mx5qfhb4.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Thu, May 03, 2012 at 02:09:59, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Ming Lei <tom.leiming@gmail.com>
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> tested on OMAP3530/Overo with default 32k timer and cmdline override for
> GPtimer.
> 

Thanks Kevin, I have submitted V7 version of this series with your ack and 
tested-by.

Tony,
Can you queue it for v3.5?

Thanks,
Vaibhav

