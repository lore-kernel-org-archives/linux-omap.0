From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 9/10] omap mailbox: OMAP4 Mailbox Patch to change the
	IRQ flag from IRQF_DISABLED to IRQF_SHARED
Date: Wed, 23 Sep 2009 10:58:15 +0100
Message-ID: <20090923095814.GB29765@flint.arm.linux.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53840 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZIWJ6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 05:58:20 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Tue, Sep 22, 2009 at 08:05:09PM +0530, C.A, Subramaniam wrote:
> Currently, this facilitates both the tesla and ducati
> sides to request for the same irq through an
> omap_mbox_get() call.

You're dropping IRQF_DISABLED - is this safe?  Why was the original code
using it?  Do you need IRQF_DISABLED|IRQF_SHARED ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
