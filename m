From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 4/4] arm:omap:am33xx: Add low level debugging support
Date: Mon, 7 Nov 2011 10:16:55 -0800
Message-ID: <20111107181655.GV31337@atomide.com>
References: <hvaibhav@ti.com>
 <1316529142-27564-5-git-send-email-hvaibhav@ti.com>
 <20111006230904.GA6324@atomide.com>
 <79CD15C6BA57404B839C016229A409A8023D3A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14801 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab1KGSQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 13:16:58 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8023D3A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [111107 06:42]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, October 07, 2011 4:39 AM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org; Hilman, Kevin; paul@pwsan.com; linux-arm-
> > kernel@lists.infradead.org; Mohammed, Afzal
> > Subject: Re: [PATCH-V3 4/4] arm:omap:am33xx: Add low level debugging
> > support
> > 
> > * hvaibhav@ti.com <hvaibhav@ti.com> [110920 06:59]:
> > > From: Afzal Mohammed <afzal@ti.com>
> > >
> > > Add support for low level debugging on AM335X EVM (AM33XX family).
> > > Currently only support for UART1 console, which is used on AM335X EVM
> > > is added.
> > 
> > Let's wait a bit on this one as there are other DEBUG_LL patches
> > pending from Nico.
> > 
> Tony,
> 
> Is there any branch or repo against which I can rebase my patches?

I recommend the current fixes branch.

Tony
