From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP3505 revisions?
Date: Wed, 14 Sep 2011 07:49:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109140746410.27954@utopia.booyaka.com>
References: <alpine.DEB.2.00.1109131157520.1885@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB593025750A2A5@dbde02.ent.ti.com> <alpine.DEB.2.00.1109140539230.27954@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB59302575A00A6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46672 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1INNtI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 09:49:08 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302575A00A6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "notasas@gmail.com" <notasas@gmail.com>, "tony@atomide.com" <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 14 Sep 2011, Premi, Sanjeev wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com] 
> > Sent: Wednesday, September 14, 2011 5:11 PM
> > To: Premi, Sanjeev
> > Cc: notasas@gmail.com; tony@atomide.com; linux-omap@vger.kernel.org
> > Subject: RE: OMAP3505 revisions?
> > 
> > Thanks.  Could you try a test boot of the 'id_3517_cleanup_3.2' branch 
> > of git://git.pwsan.com/linux-2.6 on an AM3517/3505, or ask someone to 
> > try that out?
> 
> Sure I will get this tested.

I just repushed this branch with changes to fix a bug that Igor found. 
If you've pulled it already, could you re-pull?  I'm particularly 
interested in a test on a 3505 board.


- Paul
