From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Wed, 13 Jun 2012 23:32:19 -0700
Message-ID: <20120614063218.GZ12766@atomide.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998D51@DBDE01.ent.ti.com>
 <20120613124215.GT12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998F70@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48202 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2FNGcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 02:32:24 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998F70@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120613 07:09]:
> Hi Tony,
> 
> On Wed, Jun 13, 2012 at 18:12:15, Tony Lindgren wrote:
> 
> > > Or should additional timings be achieved without affecting old
> > > interface, but that it seems would necessitate more code
> > > duplication.
> > 
> > We should just keep the same timings as before, with values
> > added for the newly added registers.
> 
> What I understood from above is to get values bootloader used to
> set for those new timings & put in Kernel, right ?

Yeah and eventually to the .dts files.

Tony
