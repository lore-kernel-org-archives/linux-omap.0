From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
 fault handling
Date: Mon, 21 Feb 2011 11:20:22 +0200
Message-ID: <20110221092022.GA4159@legolas.emea.dhcp.ti.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
 <1297884951-3019-3-git-send-email-dacohen@gmail.com>
 <20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
 <20110221082240.GL3094@legolas.emea.dhcp.ti.com>
 <AANLkTinTCGhH9HgGEr1ciHL5Vf+gQxecr17O6Z9OTOWv@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49817 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab1BUJU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 04:20:26 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so2250748bwz.1
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 01:20:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinTCGhH9HgGEr1ciHL5Vf+gQxecr17O6Z9OTOWv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: balbi@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi,

On Mon, Feb 21, 2011 at 10:57:45AM +0200, David Cohen wrote:
> >> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
> >> used for iommu but client needs the place to pass its info to its
> >> custom handler. Any better idea?
> >
> > I'm not sure if it makes sense as I don't know the mailbox block, but
> > maybe moving to GENIRQ ? Then IRQ subsystem would take care of the
> > "dev_id"
> 
> Not sure if it fits in this case. It's a different module (IOMMU user)
> which needs to get a callback from IOMMU when a fault happens.
> Is there any GENIRQ usage currently in this scenario?

No, that's not how GENIRQ is supposed to be used. You will need a
function pointer, like you added.

-- 
balbi
