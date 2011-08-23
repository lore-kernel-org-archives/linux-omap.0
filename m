From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Tue, 23 Aug 2011 17:59:53 +0300
Message-ID: <CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-2-git-send-email-ohad@wizery.com> <20110823140746.GP2079@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59954 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab1HWPAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 11:00:18 -0400
Received: by wwf5 with SMTP id 5so204390wwf.1
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 08:00:17 -0700 (PDT)
In-Reply-To: <20110823140746.GP2079@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Tue, Aug 23, 2011 at 5:07 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Can this be easily converted to a spin_lock?

Sure, thanks for reviewing.
