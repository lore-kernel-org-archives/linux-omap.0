From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
 fault handling
Date: Thu, 24 Feb 2011 10:35:19 +0200
Message-ID: <20110224083518.GC3528@legolas.emea.dhcp.ti.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
 <1297884951-3019-3-git-send-email-dacohen@gmail.com>
 <AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
 <AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
 <AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
 <4D656961.7080105@maxwell.research.nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39312 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130Ab1BXIfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 03:35:24 -0500
Received: by bwz16 with SMTP id 16so896902bwz.32
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 00:35:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D656961.7080105@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, David Cohen <dacohen@gmail.com>, hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi,

On Wed, Feb 23, 2011 at 10:09:05PM +0200, Sakari Ailus wrote:
> > In OMAP4 the cortex M3 is a double core processor and as each core is
> > running they own version of the RTOS we threat them independently. So
> > our driver which controls the remote processor sees two processor but
> > both use the same iommu hw. When a iommu fault happens, at this
> > moment, it is consider as a faltal error and it is no managed to
> > recover and continue, instead a restart of the processor is needed, if
> > the fault happens in core0 we need to reset core1 too and vice versa.
> > if the iommu would support several user callbacks, we can register the
> > callback which resets core0 and also the callback which resets core1
> > and treat them as totally independent processors. Also we have an
> > error event notifier driver, which is only in charge of notifying
> > error events to userspace, so we would have multiple callbacks we
> > could do this
> 
> The original purpose of the patch, as far as I understand, is to allow
> getting useful information for debugging purposes should an iommu fault
> happen.
> 
> Also, I'm not sure it's necessarily a good idea to just go and reset
> the M3 cores in case an iommu fault happens --- this is very probably a
> grave bug in the software running on those M3s. It should be fixed
> instead of just hiding it. There will be consequences to host side as

I have to agree here. Besides the fact that multiple callbacks is
outside the scope of this patch.

-- 
balbi
