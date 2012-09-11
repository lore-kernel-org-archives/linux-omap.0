From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd: nand: omap2: fix error path
Date: Tue, 11 Sep 2012 11:20:06 -0700
Message-ID: <20120911182006.GJ23092@atomide.com>
References: <1347344934-28103-1-git-send-email-afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E19C0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753831Ab2IKSUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 14:20:10 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E19C0@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "dedekind1@gmail.com" <dedekind1@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120910 23:31]:
> +Tony
> 
> On Tue, Sep 11, 2012 at 11:58:54, Mohammed, Afzal wrote:
> > Let probe return error value if gpmc terminal
> > count interrupt could not be obtained

Thanks I'll just fold my fix and this fix into your original
patch and push them to new devel-gpmc-fixed branch because
of the copy paste UTF-8 issues in my fix.

Regards,

Tony
