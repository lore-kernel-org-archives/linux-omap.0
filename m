From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
 read/write
Date: Thu, 7 Oct 2010 07:17:08 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
 <1285063280-4057-10-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306Ab0JGMRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 08:17:37 -0400
In-Reply-To: <1285063280-4057-10-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
> Sent: Tuesday, September 21, 2010 5:01 AM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-mtd@lists.infradead.org
> Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
> read/write
> 
> Following sparse warnings exists due to use of writel/w and readl/w
> functions.
> 
> This patch fixes the sparse warnings by converting readl/w functions usage
> into
> __raw_readl/__raw_readw functions.

Apologies on bringing up an old topic here -> Is'nt it better to fix readl/w or writel/w than replacing it with __raw_readl/w etc?



Regards,
Nishanth Menon

[...]
