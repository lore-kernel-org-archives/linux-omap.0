From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 10:49:08 +0300
Message-ID: <20080829074908.GR7354@gandalf.research.nokia.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net> <20080828090719.GG7354@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com> <20080828102842.GK7354@gandalf.research.nokia.com> <20080828112032.GL7354@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50936 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYH2HtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 03:49:22 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext David Brownell <david-b@pacbell.net>, ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 29, 2008 at 10:11:00AM +0530, ext Gupta, Ajay Kumar wrote:
> 
> I tested MUSB controller on OMAP35xx EVM (omap3_evm_defconfig) for g_ether gadget and it works fine with Windows XP. I am using v2.6.26-omap2 tag.

ehehe, cool. So looks like the problem is either on tusb6010 or in
g_ether itself.

I'll bisect since I know 2.6.24-omap1 was working.

-- 
balbi
