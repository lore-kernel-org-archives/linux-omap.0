From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] ARM:iommu support for OMAP4
Date: Mon, 19 Apr 2010 09:50:28 +0300 (EEST)
Message-ID: <20100419.095028.193685755.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16658 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab0DSGup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 02:50:45 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com, paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH] ARM:iommu support for OMAP4
Date: Fri, 16 Apr 2010 18:17:09 +0200

> From 708914e1a82a608d423b050cb31b4deb46eb8411 Mon Sep 17 00:00:00 2001
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Mon, 8 Mar 2010 17:55:21 -0600
> Subject: [PATCH] ARM:iommu support for OMAP4
> 
> This patch provides the iommu support for OMAP4 co-processors.

This looks ok for now mostly. some minor fix are pointed out by
Santosh, though.

In the long run, I guess that, this should be converted to "hwmod"?

ref: http://marc.info/?l=linux-omap&m=127012520411256&w=2
