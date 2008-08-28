From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Enabling MUSB support
Date: Thu, 28 Aug 2008 13:28:42 +0300
Message-ID: <20080828102842.GK7354@gandalf.research.nokia.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net> <20080828090719.GG7354@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50292 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYH1K3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 06:29:18 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext David Brownell <david-b@pacbell.net>, ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Aug 28, 2008 at 03:49:17PM +0530, ext Gadiyar, Anand wrote:
> There's another issue we noticed today with the SDP and beagleboard.
> 
> MUSB in peripheral or OTG mode with g_ether causes a Windows PC to
> throw a blue-screen-of-death upon connect. g_file_storage/g_zero did
> not seem to have this problem. Regression, as 2.6.26 was working just fine.
> 
> Will look into it when I can find the time - a bisect should catch the bug.

would be worth trying other gadget controller to rule out the gadget
driver. If another controller doesn't give blue-screen-of-death it means
it's musb problem, otherwise, it's g_ether issue.

-- 
balbi
