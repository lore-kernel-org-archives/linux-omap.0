From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] omap: iommu: fix pte attributes for super section
Date: Mon, 16 May 2011 10:11:57 +0300 (EEST)
Message-ID: <20110516.101157.344277473342871979.Hiroshi.DOYU@nokia.com>
References: <BANLkTinqPkftv7KmghCCBpEdULh0cNivHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:63799 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab1EPHMJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 03:12:09 -0400
In-Reply-To: <BANLkTinqPkftv7KmghCCBpEdULh0cNivHg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: s-anna@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: "ext Anna, Suman" <s-anna@ti.com>
Subject: [PATCH] omap: iommu: fix pte attributes for super section
Date: Tue, 10 May 2011 10:25:17 -0700

> From 5796d8d8a0ea5aee342b78ca6ead229971cff6c5 Mon Sep 17 00:00:00 2001
> From: Suman Anna <s-anna@ti.com>
> Date: Wed, 4 May 2011 17:45:37 -0500
> Subject: [PATCH] omap: iommu: fix pte attributes for super section
> 
> The PTE programming causes a 16MB entry to be interpreted
> as a 4K entry because of the bitwise check, and therefore does
> not set the attributes properly in the first-level descriptor
> table. The bitwise check has been replaced appropriately.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Thanks, checked with OMAP2/3 TRM.
