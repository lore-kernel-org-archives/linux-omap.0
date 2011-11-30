From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via
 hwmod mux
Date: Wed, 30 Nov 2011 14:57:52 +0530
Message-ID: <3968ef2671e202d1cefdf4a7c5d32ec6@mail.gmail.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com><87pqh3qvkt.fsf@ti.com><1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com><a480ee86d60a9db484d3baa0faf2477f@mail.gmail.com>
 <87k46izb8b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37049 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753450Ab1K3J1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 04:27:54 -0500
Received: by mail-iy0-f169.google.com with SMTP id q3so658749iaq.14
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 01:27:53 -0800 (PST)
In-Reply-To: <87k46izb8b.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

---
> >> > Can you refresh this against Tony's 'fixes' branch and re-test.
> >> >
> >> > I tested this on OMAP3430/n900 and noticed that it no longer
> hit
> >> off
> >> > mode from idle.
> >> >
> >> > IOW, If I enable UART timeouts and then enable off mode, I
> don't
> >> > actually ever hit off during idle.  However, if I do a
> >> > suspend/resume I
> >> > see it hits off mode, then subsequent attempts to hit off
> during
> >> > idle work.
> >> >
> >> > Can you investigate this?
> >> OK. Let me check that.
> > I rebased these patches against latest Tony's fixes branch and
> tested it
> > on OMAP3430 SDP. I see that Core enters off mode in idle path
> after
> > setting UART timeout w/o having to suspend the system.
>
> OK, sounds good.
>
> Do you have a branch that I can test as well?
Sure. It's available at
git://gitorious.org/omap-pm/linux.git for_3.3/io_daisy_chain

Regards
Vishwa
>
> Kevin
