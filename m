From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap iommu: print module name on error messages
Date: Thu, 17 Feb 2011 15:57:13 -0800
Message-ID: <20110217235713.GM20795@atomide.com>
References: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
 <20110214.154130.1019130951550611673.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13328 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1BQX5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 18:57:19 -0500
Content-Disposition: inline
In-Reply-To: <20110214.154130.1019130951550611673.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: dacohen@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [110214 05:39]:
> From: ext David Cohen <dacohen@gmail.com>
> Subject: [PATCH] omap iommu: print module name on error messages
> Date: Sat, 12 Feb 2011 12:02:29 +0200
> 
> > OMAP IOMMU generic layer doesn't need ot print function name during
> > error messages. Print module name instead which is more useful.
> 
> Agree. This makes more sense.

Applying to devel-iommu-mailbox for the upcoming merge window.

Tony
