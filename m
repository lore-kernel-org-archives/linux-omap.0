From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Thu, 12 Dec 2013 21:59:13 +0000
Message-ID: <20131212215913.GB29072@muru.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <20131205170514.GY26766@atomide.com>
 <52A5BB65.5050109@ti.com>
 <2364383.8GWpsWSoJu@avalon>
 <52A9760A.3000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:34959 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab3LLV6E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 16:58:04 -0500
Content-Disposition: inline
In-Reply-To: <52A9760A.3000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

On Thu, Dec 12, 2013 at 10:38:34AM +0200, Tomi Valkeinen wrote:
> On 2013-12-12 01:44, Laurent Pinchart wrote:
> 
> So, are they independent? I don't know =). I think they lean on the
> independent side. dss_core is always needed for the submodules to work,
> but for example DSI could be used without DISPC, using system DMA to
> transfer data from memory to DSI. Not a very useful thing to do, but
> still, there are dedicated DMA channels for that.

If they have separate hwmod entries, they should be considered separate
independent devices for sure.

To summarize, here are few reasons why they need to be treated as
separate devices:

1. The modules maybe clocked/powered/idled separately and can have their
   own idle configuration so they can do the hardware based idling
   separately.

2. Doing a readback after a write to one module will not flush the write
   to the other modules on the (bus depending on the SoC version AFAIK).
   That can lead to nasty bugs caused by the ordering.

3. If the devices are described in a different way in the .dts files
   from the hwmod data, we will not have 1-to-1 mapping and will never
   be able to replace ti,hwmods with just the compatible string.

Regards,

Tony
