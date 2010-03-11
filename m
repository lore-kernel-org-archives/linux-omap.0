From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 15:33:04 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD32B8D@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
	 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B51@dbde02.ent.ti.com>
	 <1268299850.28571.92.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B73@dbde02.ent.ti.com>
 <1268300631.28571.94.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43291 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab0CKKDS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 05:03:18 -0500
In-Reply-To: <1268300631.28571.94.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, March 11, 2010 3:14 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
> file
> 
> On Thu, 2010-03-11 at 10:39 +0100, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Thursday, March 11, 2010 3:01 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org; tony@atomide.com
> > > Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM
> board
> > > file
> > >
> > > > [Hiremath, Vaibhav] Tomi,
> > > >
> > > > Also, there are few patches which still are not merged to main-line,
> like
> > > >
> > > > commit 98d31bf6566be9e716f6dfdce8eb39d1c1097b7c
> > > > Author: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > Date:   Wed Jan 13 17:17:10 2010 +0530
> > > >
> > > >     OMAP: AM3517: Enable DSS2 for AM3517EVM board
> > > >
> > > >     Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > >     [tomi.valkeinen@nokia.com: removed the board file changes]
> > > >     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > > >
> > > > commit bb8a88ac57564e2e7ccc813be1d74c45bb467549
> > > > Author: Vaibhav Hiremath <hvaibhav@ti.com>
> > > > Date:   Mon Jan 4 15:34:16 2010 +0100
> > > >
> > > >     OMAP: Enable DSS2 for OMAP3EVM board
> > > >
> > > >     Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > >     [tomi.valkeinen@nokia.com: removed the board file changes]
> > > >     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > > >
> > > >
> > > > Any specific reason why are holding this back?
> > >
> > > Board file patches go through linux-omap. Those patches seem to be in
> > > linux-omap/master, so I guess they'll go through at some point soon.
> > >
> > [Hiremath, Vaibhav] No, they are not part of linux-omap/master.
> 
> Yes, they are =)
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commit;h=c3d33329f400587976613c0224ffa2e266677cfb
> 
[Hiremath, Vaibhav] Tomi, the above patch has already present in main-line. The patch I am talking about is defconfig update for DSS on both OMAP3EVM and AM3517EVM.
It happened to be the same commit description at your repository when you split it.

Thanks,
Vaibhav


>  Tomi
> 

