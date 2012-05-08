From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Mon, 7 May 2012 23:32:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205072332120.9984@utopia.booyaka.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-3-git-send-email-r.sricharan@ti.com> <20120504223933.GX5613@atomide.com> <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com> <20120507191847.GJ5088@atomide.com>
 <20120507193500.GK5088@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43076 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab2EHFcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:32:48 -0400
In-Reply-To: <20120507193500.GK5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: R Sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

On Mon, 7 May 2012, Tony Lindgren wrote:

> Of course we could make this finer grained based on features
> like SOC_HAS_XYZ or SOC_HAS_OMAP3PLUS_PRMXYZBITS if you have some
> grouping like that in mind.

Yep, I like that idea.


- Paul
