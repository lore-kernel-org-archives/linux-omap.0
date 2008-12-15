From: Tony Lindgren <tony@atomide.com>
Subject: Re: N810 suspend
Date: Mon, 15 Dec 2008 13:14:32 -0800
Message-ID: <20081215211430.GJ10664@atomide.com>
References: <20081215210823.GD5334@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54335 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbYLOVOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 16:14:35 -0500
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LCKlt-000MUl-4d
	for linux-omap@vger.kernel.org; Mon, 15 Dec 2008 21:14:33 +0000
Content-Disposition: inline
In-Reply-To: <20081215210823.GD5334@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>

* green <greenfreedom10@gmail.com> [081215 13:08]:
> What are the chances of getting suspend (resume from) working on the N810?  Are 
> there any patches or branches around that I can test (I'm slowly learning how 
> to use git)?
> 
> I'm running Debian on an N810.  With the current state of power management in 
> linux-omap, the N810 will only run (with LCD off) for about 12 hours on a 
> charge.

Well you need to make sure the serial clocks are not enabled. Kevin
has some patches for that in his pm branch. So you'll most likely want
to use his whole pm branch.

Also, you need to make sure you have sleep while idle enabled:

# echo 1 > /sys/power/sleep_while_idle

It used to work, but I have not tried for six months or so.

Regards,

Tony
