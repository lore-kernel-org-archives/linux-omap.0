From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/7] omap: iommu: PREFETCH_IOTLB cleanup
Date: Thu, 18 Aug 2011 09:33:43 +0300
Message-ID: <CAK=WgbYv0dhBZGo+_sxU+hj-kJEc0E1dk_-Yc2JCDU6SwMeppw@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-5-git-send-email-ohad@wizery.com> <20110818.082716.383880091385751705.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37482 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab1HRGeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 02:34:04 -0400
Received: by wyg24 with SMTP id 24so1164960wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Aug 2011 23:34:03 -0700 (PDT)
In-Reply-To: <20110818.082716.383880091385751705.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, laurent.pinchart@ideasonboard.com, Joerg.Roedel@amd.com, arnd@arndb.de, iommu@lists.linux-foundation.org

Hi Hiroshi,

On Thu, Aug 18, 2011 at 8:27 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> While we're at it, rename load_iotlb_entry to prefetch_iotlb_entry
>> to better reflect the purpose of that function.
>
> Considering that, originally this function is the counterpart of
> "flush_iotlb_page()" among load_iotlb_/flush_iotlb_*() family and
> OMAP1 doesn't use H/W page table but only uses TLB(only
> prefetch/load_tlb), what about keeping the original function
> "load_iotlb_entry()", and make inline function
> "prefetch_iotlb_entry()" has it?

Sure, np (I have considered doing that, but decided to drop it for now
since there's no other user of load_iotlb_entry currently. Now that
you mention it too, I'll do that).

Thanks,
Ohad.
