From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB on OMAP3530
Date: Wed, 18 Feb 2009 19:20:56 +0200
Message-ID: <20090218172055.GD32125@frodo>
References: <E1LZpYv-0003FK-Ae@amazonia.comcast.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47923 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZBRRVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 12:21:01 -0500
Content-Disposition: inline
In-Reply-To: <E1LZpYv-0003FK-Ae@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 18, 2009 at 08:46:17AM -0800, Rick Bronson wrote:
> Hello,
> 
>   I've got a new board with a OMAP3530 that's wired to a "ULPI Hi-Speed
> USB host and peripheral transceiver" (NXP ISP1505) on UH0-D0-7,
> UH0-CLK, UH0-STP, UH0-DIR, UH0-NXT.  There is also a mux to switch
> from host to device on GPIO_140.
> 
>   What set of kernel configs should I enable?  Here's what I have:

you need to enable CONFIG_USB_EHCI_HCD

-- 
balbi
