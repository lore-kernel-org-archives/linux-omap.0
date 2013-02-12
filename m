From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
Date: Tue, 12 Feb 2013 06:39:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302120638580.14983@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com> <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>  <DC88CAD03C0052499C1907B327FC63229B966E@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302111538430.8260@utopia.booyaka.com> <DC88CAD03C0052499C1907B327FC63229B989B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37834 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3BLGj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 01:39:29 -0500
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229B989B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 12 Feb 2013, J, KEERTHY wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Monday, February 11, 2013 9:10 PM
> > To: J, KEERTHY
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
> > 
> > On Mon, 11 Feb 2013, J, KEERTHY wrote:
> > 
> > > Can I pull the other patches and rebase this patch on top of them?
> > > I need the branch where I can pull the other clock related patches.
> > > I will rebase this patch on top, Verify the PM suspend on OMAP4460
> > > And post it.
> > 
> > It's based on Tony's omap-for-v3.9/pm branch.
> > 
> 
> I am on the above branch. I am not seeing retention with/without the patch.

Sounds like you get to do some bisecting :-)


- Paul
