From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: omapfb problem on 3430sdp
Date: Wed, 27 Aug 2008 12:43:18 +0300
Message-ID: <20080827094318.GB9340@gandalf.research.nokia.com>
References: <1219829316.15818.77.camel@localhost>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34741 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbYH0JnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 05:43:18 -0400
Content-Disposition: inline
In-Reply-To: <1219829316.15818.77.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Wed, Aug 27, 2008 at 05:28:36PM +0800, ext stanley.miao wrote:
> Hardware: 
> 	Mainboard: 750-2094-001(C)
> 	Display board: 750-2081-101(B)
> 
> Software: 
> 	the lastest kernel from linux-omap-2.6 and from omapzoom.org.
> 
> The linux bootup logo is green, and LCD is dark. It looks like backlight
> disabled. 
> 
> I commented the following two sentences in lcd_2430.c, there is still
> the same thing. It seems these two sentences doesn't work.
> 
>  96         omap_set_gpio_dataout(enable_gpio, 1);
>  97         omap_set_gpio_dataout(backlight_gpio, 1);
> 
> Both the the latest kernels from omapzoom.org and linux-omap-2.6 have
> this problem.  However, the old version in linux-omap-2.6, 2.6.21,
> doesn't have this problem.

Cool could you bisect and try to find the commit that broke it ?

$ git bisect start
$ git bisect good v2.6.21-omap1
$ git bisect bad

Should help you. Read git help bisect for more information. When you
find the exact commit that broke lcd_2430.c, report here with the commit
id.

Just a note, if you can't build the bisect point, reset to some points
before and try again until you find a commit that builds, do not mark
them as bad.

-- 
balbi
