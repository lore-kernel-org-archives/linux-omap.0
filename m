From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Mon, 24 Jan 2011 16:44:57 +0530
Message-ID: <c51db1b07546a34c74311392880d66de@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com> <20110124110609.GJ16202@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55436 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251Ab1AXLPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 06:15:04 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so4753751fxm.40
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 03:15:00 -0800 (PST)
In-Reply-To: <20110124110609.GJ16202@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, January 24, 2011 4:36 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> ccross@android.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
> On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> > In CPU low power state, local timer looses its register context.
> This
> > patch adds context save restore hooks which can be used by
> platforms
> > appropriately.
>
> I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the
> generic
> timer stuff wouldn't rely on it being kept alive?
>
> Hmm, it looks like we bypass the clockevents code by only setting
> the
> TWD load value at initialization time, not when we switch to
> periodic
> mode.  We really ought to rewrite it whenever we switch back to
> periodic
> mode.
>
Idea looks good though am not sure the one shot mode.

> I suspect fixing that means you won't need this save/restore
> support.
Will try it out.

Regards,
Santosh
