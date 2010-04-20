From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: Upstream linux-omap kernel on Nokia N900?
Date: Tue, 20 Apr 2010 12:20:01 +0300
Message-ID: <20100420092001.GD2594@zero.research.nokia.com>
References: <87iq7nslvo.fsf@small.ssi.corp>
 <20100419115855.GG3544@nokia.com>
 <4BCC4801.5010005@nokia.com>
 <20100419195156.GT5514@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62825 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab0DTJUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 05:20:41 -0400
Content-Disposition: inline
In-Reply-To: <20100419195156.GT5514@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Arnaud Ebalard <arno@natisbad.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 19/04/10 21:51 +0200, ext Tony Lindgren wrote:
> * Roger Quadros <roger.quadros@nokia.com> [100419 05:06]:
> > Balbi Felipe (Nokia-D/Helsinki) wrote:
> > >Hi,
> > >
> > >On Mon, Apr 19, 2010 at 01:49:15PM +0200, ext Arnaud Ebalard wrote:
> > >>Nokia N900 is shipped to users with a 2.6.28 omap kernel. Many patches
> > >>for the hardware and various features have been pushed upstream by Nokia
> > >>developers and possibly others. Those are now available in current l-o
> > >>tree.
> > >>
> > >>Nonetheless, many drivers and various features are still missing
> > >>upstream. Simply put, one cannot expect to run a current l-o kernel on
> > >>the device (and expect to get a GUI and/or make call with the device).
> > >
> > >tell me about it :-p
> > >
> > >Thing is that it doesn't really depend only on Nokia to get those
> > >parts done. Well, we can get the kernel part done by just cleaning
> > >up and porting the 2.6.28 drivers to current mainline, but in case
> > >of e.g. SGX we still miss the xorg driver and I don't think
> > >that'll be released any time soon.
> > >
> > >Another problem is that the bootloader believes it can pass all
> > >the obsoleted OMAP TAGs to kernel and the 2.6.28 kernel depends on
> > >those, maybe that can be worked around. I don't know whether
> > >kernel simply drops invalid TAGs or not...
> > 
> > Yes kernel simply drops unrecognized TAGs and just prints a warning message.
> 
> All the the custom tags should be replaced with platform_data.
> 
> If something is needed for revision detection of the board,
> there is arm-linux common ATAG_REVISION.
> 
> However, also Maemo userspace depends on some things set by the
> custom tags. As this is non-standard, we should not spend much
> effort on that. Instead we should concentrate on making N900
> work with any distro the standard Linux way.
> 
> So I recommend using kexec patched Maemo kernel, then boot the
> new mainline kernel from Maemo kernel and mount root directly
> on the eMMC.
> 
> As Maemo user space has some dependencies to the partition
> layout, you need to keep the existing partition layout too.
> In any case, I ended up resizing the eMMC partitions and using
> /dev/mmcblk0p2 (mounted as /home in Maemo) as the new root
> partition.

Yup, I agree with Tony. I would much prefer to see real debian running on the
device over a somewhat patched-up Maemo with a newer kernel. The X.org server
can work without the SGX driver just fine, only the OMAP DSS needs to
function in order to get stuff on screen. What you might miss is the task
switcher, but as one prolific person has said, having to have a task
manager indicates failure ;P

/lauri

