From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAPDSS: Add support for panel ls037v7dw01
Date: Fri, 9 May 2014 08:55:43 -0700
Message-ID: <20140509155542.GF17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <20140505184138.GB15463@atomide.com>
 <536CA10B.9040702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46220 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaEIPzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 11:55:47 -0400
Content-Disposition: inline
In-Reply-To: <536CA10B.9040702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 02:34]:
> On 05/05/14 21:41, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [140429 16:53]:
> >> Hi all,
> >>
> >> Here are few patches to add devicetree support for panel ls037v7dw01
> >> that's found on many omap3 boards. They seem to be often mis-configured
> >> as various panel dpi entries, but really should be move to use panel
> >> ls037v7dw01 instead. This panel is found at least on the omap3 sdp,
> >> ldp, omap3 evm and few other development boards.
> > 
> > Tomi, assuming no more comments, do you want to pick up the first
> > three patches of this series? I can queue the .dts changes or you
> > can also set up a separate .dts changes branch for DSS that I can
> > merge in too.
> 
> If it's all the same to you, I'd like to collect all display related
> arch/arm/ patches into my tree, and I'll send you a merge request when
> it's stable.
> 
> I already have OMAP5 and AM43xx stuff there.

Yes that works well for me.

Tony
