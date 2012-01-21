From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sat, 21 Jan 2012 00:35:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201210031521.28153@utopia.booyaka.com>
References: <1327055619.1921.57.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46374 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2AUHfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 02:35:05 -0500
In-Reply-To: <1327055619.1921.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, Joe Woodward <jw@terrafix.co.uk>

On Fri, 20 Jan 2012, Tomi Valkeinen wrote:

> I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
> related to PM.
> 
> First, when I boot up, the console (via USB serial) is very laggy, it
> often takes many seconds until the key pressed appears so it's more or
> less unusable.

Have noticed that serial is pretty broken also.  Maybe try this series:

http://marc.info/?l=linux-omap&m=132713119729167&w=2
http://marc.info/?l=linux-omap&m=132713119229165&w=2
http://marc.info/?l=linux-omap&m=132713119829168&w=2

which is also available via git from

git://git.pwsan.com/linux-2.6

in the branch "omap_serial_fixes_3.3rc"


- Paul
