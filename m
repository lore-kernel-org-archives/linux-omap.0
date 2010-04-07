From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 3/3] arm: omap1/2/3/4: convert clocksource to a
 platform_driver
Date: Wed, 7 Apr 2010 10:21:02 +0300
Message-ID: <20100407072102.GU16297@nokia.com>
References: <1270033995-12516-1-git-send-email-felipe.balbi@nokia.com>
 <1270033995-12516-4-git-send-email-felipe.balbi@nokia.com>
 <87d3ycmfej.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44780 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab0DGHVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 03:21:20 -0400
Content-Disposition: inline
In-Reply-To: <87d3ycmfej.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Apr 06, 2010 at 11:37:08PM +0200, ext Kevin Hilman wrote:
>There is some standardized naming happening for devices based on
>Benoits work of auto-generating hwmod data.  As part of this, this
>device will now be called counter_32k instead of '32k sync timer'
>since it's just a simple counter and nobody really knew what the 'sync'
>was intended to mean.  To that end, renaming things to use counter_32k
>instead of sync timer would be helpful.

I'll do that soon.

>It's more common to just not assign these and leave them as zero.

will fix this too.

-- 
balbi
