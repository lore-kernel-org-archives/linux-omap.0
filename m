From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
Date: Thu, 3 Jun 2010 14:56:18 +0300
Message-ID: <20100603115618.GT11078@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
 <20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
 <20100603114726.GC7127@n2100.arm.linux.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39149 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0FCL5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 07:57:21 -0400
Content-Disposition: inline
In-Reply-To: <20100603114726.GC7127@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Jun 03, 2010 at 01:47:26PM +0200, ext Russell King - ARM Linux wrote:
>I think folk need to read this:
>
>	http://lkml.org/lkml/2010/6/2/472
>
>and consider what it means for the future, and what can be done to reduce
>the amount of "churn".

I believe Linus is considering more the amount of files not the amount 
of patches. Personally, I consider trivial cleanup patches the best way 
to start off with a new code (not saying that Felipe C. is new to mbox 
driver) and those patches are as needed as a brand new feature.

One thing to decrease the amount of lines of code in arch/arm is to move 
the drivers to they're proper locations on the tree. Only on omap we 
have 6 platform_drivers that could (should) be moved to proper 
locations after a 'trivial cleanups'.

gpio.c mcbsp.c timer drivers (for clocksource) etc, which alone would 
mean a decrease of 6237 lines out of arch/arm/*omap* only. And I'm not 
even counting the drivers which aren't platform_drivers.

The thing is that ARM is really different than x86 and there's no 
standardization among different SoCs, so other than moving drivers out 
of arch/arm, there isn't much we can do. Or do you have any ideas ?

-- 
balbi

DefectiveByDesign.org
