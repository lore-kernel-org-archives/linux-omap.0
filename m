From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel
	linking
Date: Fri, 16 Oct 2009 10:37:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37D34C@dbde02.ent.ti.com>
References: <1255500862-29847-1-git-send-email-santosh.shilimkar@ti.com>
 <20091014170625.GH12700@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CC9F@dbde02.ent.ti.com>
 <20091015184016.GI14531@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZJPFHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 01:07:50 -0400
In-Reply-To: <20091015184016.GI14531@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

<snip> 
> > > This fix should be tested in linux-omap before we send this to
> mainline.
> > Yes ofcourse. That what I meant by merge.
> 
> Yeah, we should still have enough time to get it into mainline kernel
> as a fix during this -rc cycle.

OK. Also please merge other two patches in linux-omap master since omap4 needs those two patches to boot.
