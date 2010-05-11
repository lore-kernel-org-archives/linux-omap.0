From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save
	support
Date: Tue, 11 May 2010 22:27:19 +0100
Message-ID: <20100511212719.GC32186@n2100.arm.linux.org.uk>
References: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com> <1259847353-22725-2-git-send-email-tero.kristo@nokia.com> <AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58914 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab0EKV1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 17:27:36 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilyji16JTT1Oe8fOT6Oz5tzopQNc-3AIQ3UprCO@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>

On Tue, May 11, 2010 at 11:15:13AM +0800, ye janboe wrote:
> Is this patch ignored by you? I do not see any ack for this patch.

Patch is fine, shame some of the people on the Cc haven't acked it though.
Can we get acks from anyone of those, and then submit it to the patch
system?

> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> > Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Richard Woodruff <r-woodruff2@ti.com>
> > Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
