From: Tony Lindgren <tony@atomide.com>
Subject: Re: Change in mmap driver performance from 2..6.38 to 2.6.39
Date: Mon, 11 Jul 2011 07:42:03 -0700
Message-ID: <20110711144202.GE5783@atomide.com>
References: <4E1B06FD.5090107@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28002 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754002Ab1GKOmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 10:42:07 -0400
Content-Disposition: inline
In-Reply-To: <4E1B06FD.5090107@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Philip Balister <philip@balister.org> [110711 07:23]:
> I have a device drier that uses a mmap'd section of memory to expose
> dma buffers to user space. (https://github.com/balister/linux-omap-philip/blob/e100-2.6.38/drivers/misc/usrp_e.c).
> 
> I have it running on the 2.6.38 and 2.6.39 kernel, but it looks like
> read performance is much slower in the .39 version than the .28
> version.
> 
> Does anyone know what changed between these two kernel versions and
> how it might fix it?

Maybe try git bisect it to some commit? You can use quilt to keep
applying the temporary patches needed in between test builds for
your driver.. Or maybe git allows that somehow too.

Tony
