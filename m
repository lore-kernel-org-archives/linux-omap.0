From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] Revert "arm/dts: Add support for TI AM335x EVM
 board"
Date: Tue, 3 Jul 2012 04:18:30 -0700
Message-ID: <20120703111830.GK1122@atomide.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
 <1340358050-29560-2-git-send-email-anilkumar@ti.com>
 <20120702084021.GF1122@atomide.com>
 <4FF15F7D.1090108@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9E911E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25121 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab2GCLSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 07:18:33 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9E911E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* AnilKumar, Chimata <anilkumar@ti.com> [120703 03:34]:
> Hi Tony,
> 
> On Mon, Jul 02, 2012 at 14:14:45, Hiremath, Vaibhav wrote:
> > 
> > 
> > On 7/2/2012 2:10 PM, Tony Lindgren wrote:
> > > * AnilKumar Ch <anilkumar@ti.com> [120622 02:45]:
> > >> This reverts commit 6c54bbb42678c99685c8e7fd09267e1cb8c2ae40.
> > > 
> > > As that has not been merged yet, I'll just drop it and set up
> > > a new devel-dt branch. Applying the reset into devel-dt.
> > > 
> > 
> > Yeah, that's better.
> > 
> > Care to include it into you next pull request.

Yes that's the plan.
 
> devel-dt branch is created but these patches are not pushed yet.
> 
> Let me know do you have any comments on the patches.

Oops, sorry yes looks like I only dropped the one you wanted
to revert but forgot to apply the new ones. Applied now to
devel-dt and pushed out.

Regards,

Tony
