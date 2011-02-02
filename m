From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] IOMMU error message cleanup
Date: Wed, 2 Feb 2011 11:54:23 -0800
Message-ID: <20110202195423.GC3322@atomide.com>
References: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52793 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1BBTy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 14:54:28 -0500
Content-Disposition: inline
In-Reply-To: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <david.cohen@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi David,

* David Cohen <david.cohen@nokia.com> [110131 09:24]:
> From: David Cohen <david@dhcppc2.(none)>
> 
> Hi,
> 
> OMAP IOMMU prints error messages twice. These patches remove the error
> message from the OMAP2,3 specific implementation and let them to be
> printed on the above layer only.

Can you also please Cc linux-arm-kernel list when sending arch/arm/*omap*/
patches? That way I don't need to repost them before applying.

Regards,

Tony
