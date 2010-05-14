From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Date: Fri, 14 May 2010 16:01:40 +0300
Message-ID: <1273842100.2814.85.camel@tubuntu.research.nokia.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
	 <1273821814.2814.63.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703042887DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42567 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab0ENNCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 09:02:00 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703042887DB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Fri, 2010-05-14 at 12:03 +0200, ext Guruswamy, Senthilvadivu wrote:
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> > Sent: Friday, May 14, 2010 12:54 PM
> > To: Guruswamy, Senthilvadivu
> > Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org; 
> > tony@atomide.com; Hiremath, Vaibhav
> > Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB

<snip>

> > The patch set makes VRFB optional. What happens if VRFB is turned off,
> > and the user uses VRFB for a framebuffer?
> [Senthil] This patch keeps VRFB=y for ARCH_OMAP2 and ARCH_OMAP3.
> User would have got an option to turn it OFF if it had appeared in 
> the menuconfig selections.  I did not give that option in menuconfig 
> explicitly. 
> ie  config OMAP2_VRFB
> 	bool <No name given here>
> 
> Suppose on a build the user deliberately gives "CONFIG_OMAP2_VRFB not set",
> then VRFB functions are made as empty functions by the compiler.
> 
> This is fine as long as the user does not say omapfb.vrfb=1.
> 
> But if the user sets omapfb.vrfb=1, then it is a wrong usage of the bootargs
> as he has already deliberately changed the defconfig to say "VRFB not set".
> 
> The result of his experiment: No bootup on the board as the vaddr of VRFB 
> is populated nor of the normal RAM buffer.

The kernel should be able to cope with that. While giving wrong boot
arguments to the kernel causing it to not boot is bad, it could be
somewhat acceptable. But if the user changes the rotation type via sysfs
file, and the kernel crashes (which is what I fear will happen), it's
totally unacceptable.

If it's possible to turn VRFB off, then the code should handle the case
where VRFB is not there. Meaning, returning error values or somehow else
failing gracefully, and informing the user of wrong arguments.

 Tomi


