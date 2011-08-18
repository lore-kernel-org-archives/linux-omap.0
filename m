From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 6/7] omap: iommu: remove unused exported API
Date: Thu, 18 Aug 2011 14:01:19 +0300
Message-ID: <CAK=Wgba0_4W=vODss4+ZKE=PQL266+W0+vb3MiwsTqQH4_1_LQ@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-7-git-send-email-ohad@wizery.com> <20110818.134947.522985871882962246.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64247 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1HRLBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 07:01:40 -0400
Received: by wwf5 with SMTP id 5so1953794wwf.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 04:01:39 -0700 (PDT)
In-Reply-To: <20110818.134947.522985871882962246.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: arnd@arndb.de, tony@atomide.com, Joerg.Roedel@amd.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Hiroshi,

On Thu, Aug 18, 2011 at 1:49 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> -extern void iommu_set_twl(struct iommu *obj, bool on);
>
> This function was introduced by "Hari Kanigeri" for some OMAP4 case,
> which is only using TLB, not H/W table walk.

We discussed that internally, and concluded it's not needed anymore. I
still kept the underlying plumbing mechanism, just in case it'd still
be needed for some hw quirks in the future, but removed the interface
(in case a future hw revision will seem to need it, it would probably
make more sense to invoke the relevant mechanism from the underlying
layers rather than from a higher layer).

>> -extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
>
> This function was introduced by "David Cohen" to specify the available
> ISP virtual address range.

Not sure if David or anyone is using this, but if someone is, it must
be out-of-tree.

In that case, even if it is needed, adding a mainline user for this
function at this point will most likely not be accepted anymore, and
instead, one will be suggested to use (and extend as necessary) the
DMA-API.

Thanks,
Ohad.
