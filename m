From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap3: l3: Temporary fix to avoid the kernel hang with
 beagle board.
Date: Mon, 01 Aug 2011 09:01:19 +0300
Message-ID: <1312178479.2075.12.camel@deskari>
References: <1304952352-27837-1-git-send-email-r.sricharan@ti.com>
	 <alpine.DEB.2.00.1107091615000.15984@utopia.booyaka.com>
	 <4E18F0D1.3080704@ti.com>
	 <alpine.DEB.2.00.1107091828310.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47194 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753350Ab1HAGBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 02:01:25 -0400
Received: by mail-fx0-f45.google.com with SMTP id b27so4857169fxb.32
        for <linux-omap@vger.kernel.org>; Sun, 31 Jul 2011 23:01:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107091828310.15984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, sricharan <r.sricharan@ti.com>, linux-omap@vger.kernel.org

On Sat, 2011-07-09 at 18:30 -0600, Paul Walmsley wrote:
> Hi Santosh,
> 
> On Sat, 9 Jul 2011, Santosh Shilimkar wrote:
> 
> > Sorry for not closing the loop on this thread but I thought Tomi
> > root-caused the DSS timeout issue to incorrect reset sequence of
> > DSS IP. With that fixed I though we shouldn't see that issue.
> 
> OK great, happy to hear that it was tracked down!
> 
> Tomi, do you have patches to fix the reset bug?

I have to say I'm not sure what this is about... I haven't seen any
hangs.

There was (or perhaps still is) problems with the hwmod code resetting
DSS. This was because the hwmod code didn't enable all the DSS clocks
before doing the reset. However, this shouldn't cause any problems in
the current mainline kernel, as the DSS driver there does a reset
itself. This will change then the DSS starts using pmruntime.

 Tomi


