From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap3/4 stall when idling
Date: Fri, 14 Sep 2012 08:08:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209140808170.14465@utopia.booyaka.com>
References: <1347608227.2559.21.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45664 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab2INIIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 04:08:42 -0400
In-Reply-To: <1347608227.2559.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

Hi Tomi

On Fri, 14 Sep 2012, Tomi Valkeinen wrote:

> I've noticed the following stack dump on omap3 and omap4 when the device
> idles. It takes some time to happen, but it does happen reliably. I just
> boot up the device to my minimal filesystem, and wait. Attached is my
> kernel config, and I'm using Linus' master branch from today.
> 
> I haven't noticed these affect anything, but they sure are somewhat
> annoying =).
> 
> Trace on omap3:
> 
> [  602.007629] INFO: rcu_sched self-detected stall on CPU { 0}  (t=29678 jiffies)

Good timing, check out this thread:

http://marc.info/?l=linux-omap&m=134756235228309&w=2


- Paul
