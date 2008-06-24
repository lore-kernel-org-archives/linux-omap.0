From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/4] usb: musb: musb on omap3 has 32 endpoints
Date: Tue, 24 Jun 2008 09:52:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46969@dbde02.ent.ti.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com>
 <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com>
 <20080623111009.GM7741@atomide.com>
 <20080623111455.GH4414@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37895 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbYFXEWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 00:22:17 -0400
In-Reply-To: <20080623111455.GH4414@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > > Fix hdrc_cnf.h for omap3 configuration.
> >
> > Does this break the configuration for omap2?
> >
> > We should set these dynamically if different for omap2 and omap3
> > so we can compile both into the same kernel.
>
> Should check omap2430 trm to be sure, maybe someone in TI
> could help us with it ?

It won't break the 2430. The 2430 has 32 endpoints as well.


> Maybe we could bring it via platform_data as well?

Yep. That would be good.

- Anand
