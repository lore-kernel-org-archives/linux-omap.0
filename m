From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 9/10] omap mailbox: OMAP4 Mailbox Patch to change the
 IRQ flag from IRQF_DISABLED to IRQF_SHARED
Date: Wed, 23 Sep 2009 13:39:24 +0300 (EEST)
Message-ID: <20090923.133924.28790906.Hiroshi.DOYU@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E7@dbde02.ent.ti.com>
	<20090923095814.GB29765@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65464 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZIWKmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 06:42:50 -0400
In-Reply-To: <20090923095814.GB29765@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: subramaniam.ca@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, grgupta@ti.com, h-kanigeri2@ti.com

Hi Russell,

From: ext Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 9/10] omap mailbox: OMAP4 Mailbox Patch to change the IRQ flag from IRQF_DISABLED to IRQF_SHARED
Date: Wed, 23 Sep 2009 11:58:15 +0200

> On Tue, Sep 22, 2009 at 08:05:09PM +0530, C.A, Subramaniam wrote:
> > Currently, this facilitates both the tesla and ducati
> > sides to request for the same irq through an
> > omap_mbox_get() call.
> 
> You're dropping IRQF_DISABLED - is this safe?  Why was the original code
> using it?  Do you need IRQF_DISABLED|IRQF_SHARED ?

I don't remember why IRQF_DISABLED was used and it might not be
necessary from the beginning. Anyway it's not necessay now since
there's no risk that other ISRs touch mailbox contents at least.
