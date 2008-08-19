From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
 linux-omap
Date: Tue, 19 Aug 2008 08:53:22 +0300 (EEST)
Message-ID: <20080819.085322.166725193.Hiroshi.DOYU@nokia.com>
References: <13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
	<20080818091305.GA23078@kos.to>
	<8F7AF80515AF0D4D93307E594F3CB40E0B312145@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36753 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbYHSFx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 01:53:56 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E0B312145@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: riku.voipio@iki.fi, r-woodruff2@ti.com, felipe.contreras@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, soni.trilok@gmail.com, x00omar@ti.com, grgupta@ti.com, felipe.contreras@nokia.com, vpasam@ti.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Mon, 18 Aug 2008 10:53:28 -0500

> > Focusing on checkpatch errors is a bit deceptive. It is
> > perfectly possible to be "checkpatch clean" yet the code
> > has lots of issues left. For example checkpatch cannot tell
> > that CSL_Strlen() can be replaced with strlen() from kernel.
> 
> -- CSL module is worked on. We will send this patch this week.

You can find the latest patchset from:

    http://www.muru.com/linux/tidspbridge

which has been updated with the latest omapzoom patches, too.

      Hiroshi DOYU

