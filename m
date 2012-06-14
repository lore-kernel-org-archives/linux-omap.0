From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
Date: Wed, 13 Jun 2012 23:34:12 -0700
Message-ID: <20120614063412.GA12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com>
 <20120613120457.GO12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998CF2@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998EFD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58711 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2FNGeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 02:34:16 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998EFD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120613 06:50]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 17:48:15, Mohammed, Afzal wrote:
> > On Wed, Jun 13, 2012 at 17:34:58, Tony Lindgren wrote:
>  
> > > There should no longer be any need to initialize GPMC early. It should
> > > behave like any other device driver, and also work as a loadable module.
> > 
> > Once driver migration is complete for all the boards, we can remove the
> > initcall and make it loadable.
> > 
> > But till that time as we need to support both old & new interface,
> > I feel this is necessary as old interface would happen in arch initcall,
> > and old gpmc_init is now gpmc_probe, and hence it needs to get executed
> > before arch initcall, necessitating this.
> 
> Seems you missed this in the flood of mails, please let me know your
> comments on this. This is a commit that has to be reverted once driver
> migration is complete for all boards.

Yes sounds good to me.

Tony
