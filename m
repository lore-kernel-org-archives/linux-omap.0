From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
Date: Mon, 29 Oct 2012 05:19:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210290518120.30274@utopia.booyaka.com>
References: <20121017181354.GA2412@netboy.at.omicron.at> <50806B18.1010502@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44178 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab2J2FTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 01:19:55 -0400
In-Reply-To: <50806B18.1010502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Richard Cochran <richardcochran@gmail.com>, tony@atomide.com, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Vaibhav

On Fri, 19 Oct 2012, Vaibhav Hiremath wrote:

> Couple of reasons,
> 
> 1. These flags were added for validation, so I expect cpsw driver
> should work without these flags set. I tested it mounting NFS as rootFS
> and it works for me.
> 
> 2. There is HW bug as far as idle (in turn ocp reset) is concerned, and
> needs special handling for this. I already have patch for this, which I
> will submit it to the list.
> 
> http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;h=a28da2ac98f173f97dbbb46be1ce0a3879f21a11
> 
> 
> Note: Sorry for long commit description, it was screwed up by someone
> while git push.
> 
> 
> I have pushed the tested branch to (linux-omap/master + CPSW patches) -
> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging

Just checking on this one.  I don't mean to rush you, but if you have 
some patches you'd like to see integrated for 3.8 here, it would be good 
to get them posted before the end of the week.


- Paul
