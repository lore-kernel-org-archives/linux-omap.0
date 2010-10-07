From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to
 driver
Date: Thu, 7 Oct 2010 14:14:06 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94AE77@dbde02.ent.ti.com>
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
 <FCCFB4CDC6E5564B9182F639FC356087034B94AD49@dbde02.ent.ti.com>
 <4CAD73EE.2040802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52922 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab0JGIoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 04:44:18 -0400
In-Reply-To: <4CAD73EE.2040802@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, October 07, 2010 12:47 PM
> 
> Hi Senthil,
> 
> On 10/7/2010 8:16 AM, Guruswamy, Senthilvadivu wrote:
> >
> >> From: Premi, Sanjeev
> >>
> >>> From: linux-omap-owner@vger.kernel.org
> >>>
> >>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
> >>>
> >>> Move init exit methods to its driver probe,remove.
> >>> pdev member has to be maintained by its own drivers.
> >>
> >> [sp] How is this change related to hwmod mentioned in the
> >>       subject line?
> > [Senthil] As part of the hwmod design, dispc is made as platform driver.
> > Hence the dispc_init and dispc_exit has to be moved from core
> "omapdisplay"
> > Driver to "dss_dispc" platform driver.  Pdev is the platform device
> structure maintained in dss_dispc driver containing silicon specific info
> like baseaddr, irqs of DISPC HW.
> 
> It is still not a reason to put hwmod in the subject. That is valid for
> most patches of this series.
> You have to put the plaform name then the subsystem if this is related
> to the OMAP arch directory, which is DSS, not hwmod DSS.
> 
> In the case of DSS driver changes, then you should start with video:
> DSS:, or maybe DSS is enough if there is no possible confusion.
> 
> The goal of that is just to highlight in the subject what part of the
> kernel you are changing, since the maintainers are not necessarily the
> same.
[Senthil] If "hwmod" is creating confusion, it could be removed.
Is it an ack for this patch series considering that "change in the header" is the only comment to be incorporated?

 
> Benoit
