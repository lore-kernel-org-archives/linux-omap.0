From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Linux-fbdev-devel] Getting DSS2 to mainline
Date: Mon, 17 Aug 2009 14:17:17 +0200
Message-ID: <4A894A4D.4000501@gmx.de>
References: <4A893DF4.3050705@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47749 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750842AbZHQMRN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 08:17:13 -0400
In-Reply-To: <4A893DF4.3050705@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

Hi,

Tomi Valkeinen schrieb:
> Hi,
> 
> As I'm new to sending patches upstream, I'm not sure how to go forward 
> with DSS2 now. Should I send it to linux-arm-kernel mailing list, or 
> directly to main linux kernel mailing list? Or is there a route through 
> fbdev-devel list for DSS2 to go forward?

I am also new to this process but from what I've heard I decided to 
always cc Andrew Morton <akpm@linux-foundation.org> when I think that 
something is mature enough for inclusion. That works very well, thanks 
Andrew.
Sending them only to linux-fbdev-devel looks rather like a dead end at 
least if I look on the fate of some patches in the archive.
I always cc the LKML but until now I didn't hear anything from there 
either so I doubt that would be the right way.

I'm sorry if anything of the above is incorrect, it's just my experience.


Regards,

Florian Tobias Schandinat
