From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to
 driver
Date: Thu, 7 Oct 2010 11:46:41 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94AD49@dbde02.ent.ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
 <1286363699-9614-8-git-send-email-svadivu@ti.com>
 <1286363699-9614-9-git-send-email-svadivu@ti.com>
 <1286363699-9614-10-git-send-email-svadivu@ti.com>
 <1286363699-9614-11-git-send-email-svadivu@ti.com>
 <1286363699-9614-12-git-send-email-svadivu@ti.com>
 <1286363699-9614-13-git-send-email-svadivu@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB5930234205060@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0JGGRQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 02:17:16 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930234205060@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>



> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Wednesday, October 06, 2010 7:49 PM
> To: Guruswamy, Senthilvadivu; khilman@deeprootsystems.com;
> tomi.valkeinen@nokia.com; paul@pwsan.com; Hiremath, Vaibhav; linux-
> omap@vger.kernel.org
> Subject: RE: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to
> driver
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > Guruswamy, Senthilvadivu
> > Sent: Wednesday, October 06, 2010 4:45 PM
> > To: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com;
> > paul@pwsan.com; Hiremath, Vaibhav; linux-omap@vger.kernel.org
> > Cc: Guruswamy, Senthilvadivu
> > Subject: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move
> > init,exit to driver
> >
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > Move init exit methods to its driver probe,remove.
> > pdev member has to be maintained by its own drivers.
> 
> [sp] How is this change related to hwmod mentioned in the
>      subject line?
[Senthil] As part of the hwmod design, dispc is made as platform driver.
Hence the dispc_init and dispc_exit has to be moved from core "omapdisplay" 
Driver to "dss_dispc" platform driver.  Pdev is the platform device structure maintained in dss_dispc driver containing silicon specific info like baseaddr, irqs of DISPC HW.
> ~sanjeev
> 
> [snip]...[snip]
