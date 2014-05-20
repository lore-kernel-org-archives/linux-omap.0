From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: edma: Clean up and simplify the code around irq
 request
Date: Mon, 19 May 2014 22:57:41 -0700
Message-ID: <20140520055741.GR18956@quad.lixom.net>
References: <1399965961-23739-1-git-send-email-peter.ujfalusi@ti.com>
 <5374AD6D.8090002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58938 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaETF5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 01:57:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so6717322pab.5
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 22:57:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5374AD6D.8090002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com, linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arm@kernel.org

On Thu, May 15, 2014 at 05:35:01PM +0530, Sekhar Nori wrote:
> + ARM SoC team
> 
> On Tuesday 13 May 2014 12:56 PM, Peter Ujfalusi wrote:
> > Get the two interrupt line number at the same time by merging the two
> > instance of if(node){}else{} places.
> > replace the &pdev->dev with the already existing dev which makes it possible
> > to collapse lines with devm_request_irq()
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> Arnd, Olof, Kevin,
> 
> Do you mind applying this directly for v3.16? I do not have anything
> else queued ATM so not sending a pull request.

I see it was reposted today as part of a larger patch set with some
question as to what it applies to.

Sekhar, if you just have one patch for us to apply, then feel free to
resend it to use (git send-email --to=arm@kernel.org) and make it clear
(below the --- separator) that you want us to apply it directly, and
we'll be happy to do so.


-Olof
