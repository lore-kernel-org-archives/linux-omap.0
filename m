From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: lowmemory android driver not needed?
Date: Thu, 29 Jan 2009 13:43:51 +0900 (JST)
Message-ID: <20090129134233.A95C.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20090129124555.b83ea0ae.kamezawa.hiroyu@jp.fujitsu.com> <20090129042748.GA24108@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52731 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbZA2EoA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 23:44:00 -0500
In-Reply-To: <20090129042748.GA24108@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: kosaki.motohiro@jp.fujitsu.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Arve =?SHIFT_JIS?B?SGr4bm5lduVn?= <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha =?SHIFT_JIS?B?WXJq9myBRQ==?= <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com, Trilok Soni <soni.trilok@gmail.com>

> > > I never expected it to be merged. I wrote it to allow us to ship a product.
> > > 
> > Then, please write "DON'T MERGE ME" on the top of patch description.
> > we can adjust our viewpoints.
> 
> The code will live in the drivers/staging/ directory for now and not get
> merged into the "main" portion of the kernel tree until everyone can
> agree on it.
> 
> But for now, it is useful and seems to work for a few million devices
> out there, so we can't just ignore it :)

No. 
if author don't hope review and merge, we don't have any reason to reviewing.



