From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 12:21:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904EBB0@dbde02.ent.ti.com>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
 <20081128064615.GK23308@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37964 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYK1GvR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 01:51:17 -0500
In-Reply-To: <20081128064615.GK23308@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> no.
> 
> I could even live with if (machine_is_xxx()) code, although I don't want
> to. But ifdefs are an automatic NAK.

Felipe, this is temporary patch as described. I will submit the final one
later. twl4030 dependency is bottleneck for TPS work on OMAP3EVM.  

> 
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

