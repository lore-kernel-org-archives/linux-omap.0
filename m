From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: Upstream linux-omap kernel on Nokia N900?
Date: Tue, 20 Apr 2010 11:53:11 +0300
Message-ID: <1271753591.2528.4.camel@chotu.research.nokia.com>
References: <87iq7nslvo.fsf@small.ssi.corp>
	 <20100419115855.GG3544@nokia.com> <4BCC4801.5010005@nokia.com>
	 <20100419195156.GT5514@atomide.com>  <4BCD678C.6020407@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19397 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0DTIxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 04:53:41 -0400
In-Reply-To: <4BCD678C.6020407@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Arnaud Ebalard <arno@natisbad.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Leukkunen Lauri (Nokia-D/Helsinki)" <lauri.leukkunen@nokia.com>

On Tue, 2010-04-20 at 10:36 +0200, Quadros Roger (Nokia-D/Helsinki)
wrote:
> ext Tony Lindgren wrote:
> > * Roger Quadros <roger.quadros@nokia.com> [100419 05:06]:
> >> Balbi Felipe (Nokia-D/Helsinki) wrote:
> >>> Hi,
> >>>
> >>> On Mon, Apr 19, 2010 at 01:49:15PM +0200, ext Arnaud Ebalard wrote:
> >>>> Nokia N900 is shipped to users with a 2.6.28 omap kernel. Many patches
> >>>> for the hardware and various features have been pushed upstream by Nokia
> >>>> developers and possibly others. Those are now available in current l-o
> >>>> tree.
> >>>>
> >>>> Nonetheless, many drivers and various features are still missing
> >>>> upstream. Simply put, one cannot expect to run a current l-o kernel on
> >>>> the device (and expect to get a GUI and/or make call with the device).
> >>> tell me about it :-p
> >>>
> >>> Thing is that it doesn't really depend only on Nokia to get those
> >>> parts done. Well, we can get the kernel part done by just cleaning
> >>> up and porting the 2.6.28 drivers to current mainline, but in case
> >>> of e.g. SGX we still miss the xorg driver and I don't think
> >>> that'll be released any time soon.
> >>>
> >>> Another problem is that the bootloader believes it can pass all
> >>> the obsoleted OMAP TAGs to kernel and the 2.6.28 kernel depends on
> >>> those, maybe that can be worked around. I don't know whether
> >>> kernel simply drops invalid TAGs or not...
> >> Yes kernel simply drops unrecognized TAGs and just prints a warning message.
> > 
> > All the the custom tags should be replaced with platform_data.
> > 
> > If something is needed for revision detection of the board,
> > there is arm-linux common ATAG_REVISION.
> > 
> > However, also Maemo userspace depends on some things set by the
> > custom tags. As this is non-standard, we should not spend much
> > effort on that. Instead we should concentrate on making N900
> > work with any distro the standard Linux way.
> > 
> > So I recommend using kexec patched Maemo kernel, then boot the
> > new mainline kernel from Maemo kernel and mount root directly
> > on the eMMC.
> 
> FYI. kexec-tools will be available in maemo.org repo soon and you can also 
> expect kexec patched kernel to be available.

Everything related to kexec (kernel patches and user-space) on n900 is
documented here:
http://wiki.meego.com/ARM/Meego_kexec_install_on_N900

kexec-tools is already available from maemo-extras (testing) repository.

Cheers,
Ameya.

