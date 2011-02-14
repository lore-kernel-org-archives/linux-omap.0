From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Pandaboard boot problem
Date: Mon, 14 Feb 2011 16:38:15 +0200
Message-ID: <20110214163815.d488841f.jhnikula@gmail.com>
References: <AANLkTikCjuhHJbvK6YL40mYq2Yt99UCob4bHKRqPRToW@mail.gmail.com>
	<20110204015301.GQ3322@atomide.com>
	<AANLkTinJPPDH6bWQ-Q14k6vgx8iGQvUmPFbrWqQX1JJ5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63796 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab1BNOiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 09:38:19 -0500
Received: by ewy5 with SMTP id 5so2248423ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 06:38:18 -0800 (PST)
In-Reply-To: <AANLkTinJPPDH6bWQ-Q14k6vgx8iGQvUmPFbrWqQX1JJ5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, 14 Feb 2011 15:01:30 +0100
Jean Pihet <jean.pihet@newoldbits.com> wrote:

> > If so, I've seen this same issue few times after having my panda
> > powered off for a while, for example over the weekend.
> >
> > What I've noticed is that leaving just u-boot prompt running
> > for a few minutes cures the problem somehow.. After that the
> > kernel will boot just fine.
> Unfortunately that is not helping.
> I am still investigating. For the moment the pandaboard is pretty useless ;(
> 
Try to heat TWL6030 a little. My board seems to suffer some soldering
fault around it and the device keeps running if I warm up the chip with
a 40 W light bulb ~1-2 cm distance.

It keeps running fine by using the Ubuntu kernel but I think reason is
that the EHCI is initialized there and the TWL draws more current and
thus heats up.

No idea why the u-boot runs fine.

-- 
Jarkko
