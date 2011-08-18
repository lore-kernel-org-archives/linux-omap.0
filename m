From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Thu, 18 Aug 2011 12:05:01 +0300
Message-ID: <CAK=Wgbb6EWBr9ndCEGK2C6kK74B8vNFpezw-=ndEQ4bANhOB4g@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-2-git-send-email-ohad@wizery.com> <201108181101.57882.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48082 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1HRJFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 05:05:23 -0400
Received: by wwf5 with SMTP id 5so1857624wwf.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 02:05:22 -0700 (PDT)
In-Reply-To: <201108181101.57882.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org

Hi Laurent,

On Thu, Aug 18, 2011 at 12:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Just one small comment in case you resubmit the whole series for another
> reason.
..
> You can directly return -ENOMEM here, and remove the "out:" label.

Sure thing,

Thanks,
Ohad.
