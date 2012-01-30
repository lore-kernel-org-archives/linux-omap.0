From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/7] ARM: OMAP2+: hwmod/timer: first set of cleanups for
 3.4
Date: Mon, 30 Jan 2012 16:36:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201301635010.17726@utopia.booyaka.com>
References: <20120130101251.10450.58423.stgit@dusk> <87ty3cpyuk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53042 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab2A3XgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 18:36:09 -0500
In-Reply-To: <87ty3cpyuk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 30 Jan 2012, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > This series does some cleanup and documentation on the OMAP hwmod code
> > (and a bit of the OMAP4 data) and timer code. It is the first
> > prerequisite series to removing a big chunk of hwmod data -- that will
> > be done in a later series.
> >
> > Boot-tested on an OMAP35xx BeagleBoard and OMAP44xx ES2 Pandaboard.
> >
> > This series is also available via git from git://git.pwsan.com/linux-2.6 in
> > the branch "hwmod_code_cleanup_3.4".
> 
> FYI... I tested this branch on my 4430ES2.1/Panda and got an infinite
> loop of L3 errors.
> 
> I haven't debugged which patch causes the problem, but thought you'd
> like to know.   I did notice that that booting v3.3-rc1, I see
> 
> [    0.309478] omap_hwmod: ipu: failed to hardreset
> 
> but booting your branch I see a few more reset failures:
> 
> [    0.308532] omap_hwmod: dsp: failed to hardreset
> [    0.328979] omap_hwmod: dsp: failed to hardreset
> [    0.358001] omap_hwmod: ipu: failed to hardreset
> [    0.378448] omap_hwmod: ipu: failed to hardreset
> [    0.398895] omap_hwmod: ipu: failed to hardreset
> [    0.427520] omap_hwmod: iva: failed to hardreset
> [    0.447967] omap_hwmod: iva: failed to hardreset
> 
> There's a full boot log below.
> 
> I noticed you tested on Panda too, but one difference between our setups
> is probably that I'm not using u-boot.  Instead, I'm booting over USB
> using the usbboot tool written by Brian Swetland:
> git://github.com/swetland/omap4boot.git.   It could be that the
> different bootloaders are leaving the other IPs in different states.

Thanks for the test and the report.  I'll take a look at the situation.  
Your assumption about bootloaders is correct.  I wonder if Brian's 
bootloader leaves things enabled.


- Paul
