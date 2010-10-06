From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to
 driver
Date: Wed, 6 Oct 2010 19:49:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234205060@dbde02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52391 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759023Ab0JFOTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 10:19:22 -0400
In-Reply-To: <1286363699-9614-13-git-send-email-svadivu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Guruswamy, Senthilvadivu
> Sent: Wednesday, October 06, 2010 4:45 PM
> To: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com; 
> paul@pwsan.com; Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Cc: Guruswamy, Senthilvadivu
> Subject: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move 
> init,exit to driver
> 
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Move init exit methods to its driver probe,remove.
> pdev member has to be maintained by its own drivers.

[sp] How is this change related to hwmod mentioned in the
     subject line?

~sanjeev

[snip]...[snip]
