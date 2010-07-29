From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() with sysfs_streq()
 in overlay_manager_store()
Date: Thu, 29 Jul 2010 16:42:37 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A5A0@dbde02.ent.ti.com>
References: <'> <1280298118-4295-1-git-send-email-archit@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F08@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EAB90@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A025@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EAC8F@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A20D@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EADBE@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A577@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703060EB03D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab0G2LMq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 07:12:46 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703060EB03D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Taneja, Archit 
> Sent: Thursday, July 29, 2010 4:40 PM
> To: Premi, Sanjeev; tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH resend] OMAP: DSS2: Replace strncmp() 
> with sysfs_streq() in overlay_manager_store()
> 
>  
> [snip]
> > > 
> > 
> > [sp] This explains. And my earlier comment was to update the
> >      description with need for change. I believe quick summary
> >      the discussion above will be good for the patch.
> >
> 
> Okay, will do. But what am is supposed to add more in the summary?
> Should I add how sysfs_streq is a better choice over strcmp? Or
> should I emphasize more how the false positive scenario
> can occur with strncmp?

I believe it should indicate problem being fixed. sysfs_streq() vs
strncmp() is means of arriving at solution.

> 
> Thanks,
> 
> Archit