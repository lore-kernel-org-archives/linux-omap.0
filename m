From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 22:06:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF8141@dbde02.ent.ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>,<87k4m3jpus.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33198 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675Ab0I3Qh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 12:37:58 -0400
In-Reply-To: <87k4m3jpus.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Kevin,

> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 

<<snip>>

> > With OMAP2PLUS watchdog implemented in hwmod fw way, the
> > module is reset during init.
> 
> Please drop this sentence, as it's not directly related to hwmod, but
> related to hardware reset, and was previously masked by most bootloaders.
> 

Okay, will modify accordingly.

> > After a watchdog timer module reset, the WDTs are enabled. The
> > default time for a system reset after a watchdog module reset
> > is ~10s as per the default value of the WDT registers. Hence
> > the system would be reset after 10s, if watchdog is not disabled
> > within 10s.
> >
> > This patch fixes the above issue by disabling the watchdog timer
> > after reset during initialization of devices.
> 
> Should also describe what happends if/when the watchdog driver is
> loaded.  

Okay. Will add it to the description.

> 
> Kevin
> 
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Reported-by: Kevin Hilman <khilman@deeprootsystems.com>

<<snip>>