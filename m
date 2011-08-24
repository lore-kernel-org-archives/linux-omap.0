From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Wed, 24 Aug 2011 17:46:37 +0300
Message-ID: <CAK=WgbYtTvCi4yLBJphvni4XiZLwm_Rj9aZFXaTwg44J1BDGsw@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-2-git-send-email-ohad@wizery.com> <20110823140746.GP2079@amd.com>
 <CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
 <CAK=WgbZAMbPhDuXZ2NwTTSDv2doT6WBSzCCaD0F02mybNEZyeA@mail.gmail.com> <20110824131527.GI2079@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63080 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1HXOq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 10:46:58 -0400
Received: by wwf5 with SMTP id 5so1293112wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 07:46:57 -0700 (PDT)
In-Reply-To: <20110824131527.GI2079@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Wed, Aug 24, 2011 at 4:15 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Yes, it should be safe in your context. But the iommu-api is generic and
> I would prefer that all functions it provides can be called from any
> context.

Not a problem.

I thought you only cared about map/unmap, but if you prefer
attach/deattach to be atomic too, I'll migrate the driver to use a
spin lock.

> Or is the time required for attaching/detaching too long so that it
> makes sense to put secondary threads to sleep?

It doesn't look like it. I think a mutex was originally chosen at that
point because those functions were used in a process context.

Thanks,
Ohad.
