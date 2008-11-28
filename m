From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 09:08:55 +0200
Message-ID: <20081128070855.GN23308@gandalf.research.nokia.com>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com> <20081128064615.GK23308@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E904EBB0@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63838 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbYK1HJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 02:09:33 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E904EBB0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 28, 2008 at 12:21:05PM +0530, Ajay Kumar Gupta wrote:
> > no.
> > 
> > I could even live with if (machine_is_xxx()) code, although I don't want
> > to. But ifdefs are an automatic NAK.
> 
> Felipe, this is temporary patch as described. I will submit the final one
> later. twl4030 dependency is bottleneck for TPS work on OMAP3EVM.  

Good, but still, let's not break multiomap ;-)

-- 
balbi
