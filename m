From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 0/6] Added DSS2/FBDEV support for OMAP3EVM & AM3517EVM
Date: Mon, 11 Jan 2010 11:07:25 +0200
Message-ID: <1263200845.2087.7.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1262615657-22723-1-git-send-email-hvaibhav@ti.com>
	 <19F8576C6E063C45BE387C64729E7394044A3982CC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59409 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0AKJGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 04:06:35 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A3982CC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Mon, 2010-01-11 at 07:33 +0100, ext Hiremath, Vaibhav wrote:
> \
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Monday, January 04, 2010 8:04 PM
> > To: linux-omap@vger.kernel.org
> > Cc: tomi.valkeinen@nokia.com; tony@atomide.com; Hiremath, Vaibhav
> > Subject: [PATCH 0/6] Added DSS2/FBDEV support for OMAP3EVM &
> > AM3517EVM
> > 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > This patch added DSS2 + OMAPFB support for OMAP3EVM and AM3517/05
> > EVM along
> > with sharp LQ043T1DG01 panel support.
> > 
> > Vaibhav Hiremath (4):
> >   OMAP: DSS2: Fix compile warning
> >   OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
> >   OMAP: Enable DSS2 for OMAP3EVM board
> >   OMAP: AM3517: Enable DSS2 for AM3517EVM board
> > 
> [Hiremath, Vaibhav] Tomi,
> 
> Do you see any issues with this patch-series? It has been reviewed multiple times. Can we merge these patches?
> You had only taken warning fix patch, any specific reason?

They look ok to me. The reason I took only the warning fix patch was
that I'm going to send only bug fixes in the next pull request. I will
merge the other patches to my tree soon, I just haven't had time for
that yet.

 Tomi


