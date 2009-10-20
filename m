From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2] ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel
	linking
Date: Tue, 20 Oct 2009 23:52:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB47F69A@dbde02.ent.ti.com>
References: <1255590416-11550-1-git-send-email-santosh.shilimkar@ti.com>
 <20091019172339.GR12576@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB37DB76@dbde02.ent.ti.com>
 <20091020181406.GI12576@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50010 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbZJTSWF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 14:22:05 -0400
In-Reply-To: <20091020181406.GI12576@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>

<snip>
> > > Hmm, I'm thinking it should be like this instead to also clear
> > > the dma_chan[lch].flags instead of returning before that.
> > >
> > > Can you try this with your testcase?
> > This works too. OMAP1 doesn't support channel linking so this is
> fine. In case it was, then it would have been an issue.
> 
> OK, I've updated your original patch with these changes, and
> will add it to omap-fixes.

Thanks Tony !!
