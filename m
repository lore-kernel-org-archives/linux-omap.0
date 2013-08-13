From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1 CPU
 devices
Date: Tue, 13 Aug 2013 12:19:43 +0100
Message-ID: <20130813111943.GE30280@mudshark.cambridge.arm.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
 <51FBC610.9030900@arm.com>
 <51FBCEC3.4030207@ti.com>
 <51FBD42A.9040901@arm.com>
 <20130802154857.GD5292@mudshark.cambridge.arm.com>
 <52092AA5.3090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35635 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757287Ab3HMLUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 07:20:13 -0400
Content-Disposition: inline
In-Reply-To: <52092AA5.3090005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Mon, Aug 12, 2013 at 07:34:13PM +0100, Santosh Shilimkar wrote:
> On Friday 02 August 2013 11:48 AM, Will Deacon wrote:
> > I think this an A9-specific register, which reads as 0 on UP A9 and reads as
> > some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
> > is zero.
> > 
> What do we do here ? Should we document this in the code and proceed ?
> Mostly there is no platform with PERIPH_BASE = 0, so its should be fine but
> I am open for any other alternative.

The only other alternative I can think of is forcing people to have
CONFIG_SMP=n, but that blows away single zImage for your platform.

Will
