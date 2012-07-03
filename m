From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
Date: Tue, 3 Jul 2012 08:05:03 +0000
Message-ID: <201207030805.04160.arnd@arndb.de>
References: <20120702063545.26782.98908.stgit@build.warmcat.com> <201207021612.57028.arnd@arndb.de> <4FF27751.9050004@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53307 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab2GCIFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 04:05:24 -0400
In-Reply-To: <4FF27751.9050004@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: s-jan@ti.com, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 03 July 2012, Andy Green wrote:
> > I think it would be simpler to register the notifier from an
> > initcall and drop the mac_la_ap_started variable.
> 
> That was my first approach, to structure it as a real driver.  I had 
> tried a few likely-looking initcall levels but the init of the helper 
> was coming after the init of the network code.
> 
> I found this time that core_initcall works, so I used that, dropped the 
> flag.  But isn't it a bit tricky with these to know if the prerequisite 
> you're trying to ensure is already initialized might not actually be at 
> the same initcall level and you're working by accident?

Well, you would only need to ensure that it's called before any of the
network devices are added, which should all happen very late in the
boot cycle compared to the platform init code.

I think core_initcall is fine here.

	Arnd
