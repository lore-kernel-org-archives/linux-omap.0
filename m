From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: VDD1 voltage after resume from idle
Date: Fri, 20 Nov 2009 21:24:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5C0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012B438C7E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41647 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbZKTPyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 10:54:09 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKFsAjf028796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 09:54:14 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAKFsArB002480
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 21:24:10 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012B438C7E@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, November 20, 2009 9:19 PM
> To: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: RE: VDD1 voltage after resume from idle
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> > Sent: Friday, November 20, 2009 9:47 AM
> > To: linux-omap@vger.kernel.org
> > Subject: VDD1 voltage after resume from idle
> > 
> > Hi,
> > 
> > I am facing a strange problem on OMAP3EVM after resuming from idle.
> > When using OPP5, the VDD1 voltage ramps to 1.35V.
> > 
> > However, when i go thru the idle/wakeup cycle, the voltage never
> > ramps back to 1.35V but stays at 1.20V.
> > 
> > I don't notice many changes in smartreflex.c since 2.6.31-rc7 but
> > this problem is not observed there. Actually, here the voltage
> > did not drop during suspend at all.
> > 
> > While I continue to debug, any suggestions?
> 
> Look for retention voltage setup (they should be OPP dependent).. 
> this was one of my plans of cleanups anyways..

So far the problem seems to be optimizations in the enable_smartreflex and
disable_smartreflex.

On resume path, enable_smartreflex() is called, but doesn't do anything
unless autocomp flag is on. This is different from the boot-time where
the current freq is looked at and appropriate voltage is set.

I am currently trying to get rid of optimizations and see the result.
We do need the optimizations; but may be different ones.

~sanjeev

> 
> > 
> > Best regards,
> > Sanjeev
> 
> Regards,
> Nishanth Menon
> 
> 