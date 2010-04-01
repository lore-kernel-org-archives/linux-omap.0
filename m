From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Where did the twl4030 battery charging code go?
Date: Thu, 1 Apr 2010 13:47:22 +0300
Message-ID: <20100401104722.GJ16297@nokia.com>
References: <738b3f7e1003300859t633ace94h5945e9974109e176@mail.gmail.com>
 <20100401101620.GM31200@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32041 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab0DAKsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:48:09 -0400
Content-Disposition: inline
In-Reply-To: <20100401101620.GM31200@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Peter Barada <peter.barada@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 01, 2010 at 12:16:20PM +0200, ext Tony Lindgren wrote:
>If it's not in mainline, we don't have it queued anywhere else.
>The missing pieces should be sent via the MFD list after the
>necessary cleanups.

for this case, I suggest adding power_supply list and maintainers to the 
loop.

-- 
balbi
