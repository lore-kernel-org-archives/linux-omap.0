From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
Date: Thu, 19 Jul 2012 18:31:47 +0300
Message-ID: <1342711907.4672.153.camel@sokoban>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
	 <1342704392-23657-8-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46721 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2GSPbx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 11:31:53 -0400
In-Reply-To: <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-19 at 08:44 -0600, Paul Walmsley wrote:
> On Thu, 19 Jul 2012, Tero Kristo wrote:
> 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> This one needs at least some short description for the changelog.  Maybe 
> just a brief explanation that OSWR saves more energy that CSWR, but has 
> higher resume latency, and since resume from system suspend is considered 
> to be a high-latency operation, OSWR is appropriate here.

Yea, I can add one. How about this:

Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
suspend

Currently OMAP4 suspend puts all power domains to CSWR. OSWR is a deeper
state that saves more power, but has higher latencies also. As suspend
is considered a high-latency operation, OSWR is appropriate here.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---

I'll update this to next rev if one is requested.

(Kind of hoping this set would be reaching maturity already.)

-Tero


