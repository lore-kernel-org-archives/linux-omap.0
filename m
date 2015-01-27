From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider
 infrastructure to clock driver
Date: Tue, 27 Jan 2015 08:50:16 -0800
Message-ID: <20150127165016.GJ28663@atomide.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
 <54C61938.8000303@ti.com>
 <20150126154936.GC28663@atomide.com>
 <54C777CE.1070900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.ore.mailhop.org ([54.186.10.118]:50896 "EHLO
	smtp5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbbA0Qx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 11:53:29 -0500
Content-Disposition: inline
In-Reply-To: <54C777CE.1070900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150127 03:37]:
> On 26/01/15 17:49, Tony Lindgren wrote:
> 
> >> I'm not sure if I miss something, but regmap_write does not protect from
> >> problems if there are multiple users for the same registers. You need to
> >> use regmap_update_bits() to get a protected read/write sequence, in
> >> which you can change only the bits that you want to change.
> > 
> > To me it seems that issue can be fixed by making all the code use regmap.
> > AFAIK that should work for the legacy code too.
> 
> Even if everybody uses regmap, doing
> 
> v = regmap_read()
> modify v
> regmap_write(v)
> 
> is racy. regmap_update_bits() has to be used to protect the read/write
> sequence. Which may be somewhat challenging at times with some strange
> registers, the like Roger Q encountered recently related to CAN.

Yeah that's a good point.

Regards,

Tony
