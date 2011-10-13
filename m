From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] arm: omap: Fix errors and warnings when building for
	one board
Date: Thu, 13 Oct 2011 20:36:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257A57F4E@dbde02.ent.ti.com>
References: <1318517623-16066-1-git-send-email-premi@ti.com>
 <20111013145615.GB22076@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35909 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab1JMPGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Oct 2011 11:06:34 -0400
In-Reply-To: <20111013145615.GB22076@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Thursday, October 13, 2011 8:26 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] arm: omap: Fix errors and warnings when 
> building for one board
> 
> On Thu, Oct 13, 2011 at 08:23:43PM +0530, Sanjeev Premi wrote:
> > +#if defined(CONFIG_ARCH_OMAP4)
> 
> Please use #ifdef unless you're intending to expand the condition.
> 

I tried to be consistent with existing use of #if defined() in the
file(s). Will change it.

Should I change the other instances as well?

~sanjeev
