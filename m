From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP3530 vs DM3730
Date: Mon, 23 Jan 2012 05:06:21 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317AF070@DBDE01.ent.ti.com>
References: <4F1AE4E6.8090000@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35876 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2AWFG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 00:06:26 -0500
In-Reply-To: <4F1AE4E6.8090000@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Jan 21, 2012 at 21:46:38, Gary Thomas wrote:
> I'm running the public 3.0 kernel on my boards.  I have some boards
> which can have either OMAP3530 or DM3730 (newer boards have the
> newer part, but everything else is the same).
> 
> On the OMAP3530, I can enable the graphics overlay on the TV (S-Video)
> output via the attached script.  On the DM3730 boards, this crashes
> the kernel hard :-(
> 
Can you share the kernel crash log here?

Thanks,
Vaibhav

> This same operation seems to be fixed on the 3.2 (public) kernel, but
> it's difficult for me to upgrade to that kernel for some other reasons.
> 
> Does anyone have an idea why this might happen?  where to look to
> isolate the bug(s)?
> 
> I tried to back-port the 3.2 DSS code into my 3.0 kernel, but my
> simple attempt was pretty much a failure...  If I can, I'd like to
> figure out how to just fix the 3.0 code, rather than the full-scale
> import of the 3.2 code.
> 
> Thanks for any ideas/pointers
> 
> -- 
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> 

