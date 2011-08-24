From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Wed, 24 Aug 2011 15:46:13 +0300
Message-ID: <CAK=WgbZAMbPhDuXZ2NwTTSDv2doT6WBSzCCaD0F02mybNEZyeA@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-2-git-send-email-ohad@wizery.com> <20110823140746.GP2079@amd.com>
 <CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52680 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab1HXMqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 08:46:35 -0400
Received: by wyg24 with SMTP id 24so801880wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 05:46:34 -0700 (PDT)
In-Reply-To: <CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Tue, Aug 23, 2011 at 5:59 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Aug 23, 2011 at 5:07 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
>> Can this be easily converted to a spin_lock?
>
> Sure, thanks for reviewing.

Taking a second look, I don't think it's necessary - the mutex isn't
used to protect the page table. The page table is protected by a spin
lock, so map/unmap operations can be called from an atomic context.

The mutex is only part of the attach/deattach operations, which are
already used today in process context, so I guess it's safe.
