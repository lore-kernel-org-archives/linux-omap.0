From: Tony Lindgren <tony@atomide.com>
Subject: Re: Zoom3 not booting with omap3_defconfig
Date: Tue, 10 Aug 2010 10:00:43 +0300
Message-ID: <20100810070042.GG32480@atomide.com>
References: <A24693684029E5489D1D202277BE894456EA2F3F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62336 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab0HJHAr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 03:00:47 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894456EA2F3F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre, Sergio <saaguirre@ti.com> [100809 21:54]:
> Hi,
> 
> I'm trying to boot from NFS with my Zoom3 board with current master branch
> (commit ID: 842849896627701e4c07441f2c7519aeec771058)
> 
> But, I'm not successful so far. :(
> 
> Seems that it can't detect the eth0 device. (See attached log: bad.txt)
> 
> Now, If I take omap_zoom3_defconfig from just before commit:
> 
> commit 80690ccc41f01df6edfb6684006824d8edff189e
> Author: Vincent Sanders <vince@simtec.co.uk>
> Date:   Tue Aug 3 21:19:21 2010 +0100
> 
>     Remove ARM default configurations which duplicate omap3_defconfig
> 
> I'm able to boot fine (see attached log: good.txt)
> 
> So, somehow, current omap3_defconfig doesn't seem to be as functional as
> omap_zoom3_defconfig used to be...

Hmm looks like the smc91x does not get detected for some reason.
 
> Is there something that everybody knows, and I'm missing on how to make a
> usable Zoom3 .config?

Maybe try to diff your good and bad config?

> net eth0: SMSC911x/921x identified at 0xe080c000, IRQ: 318

This line seems to be missing in your bad config. Maybe check
if there's some difference in mux settings between these two
configs?

Also, can you please try using your working config, then enable
support for omap2 and omap4 and see if that breaks it somehow?

Regards,

Tony
