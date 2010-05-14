From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC] Initial attempt to make ARM use LMB
Date: Fri, 14 May 2010 12:54:03 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
 <20100505150209.GC2606@n2100.arm.linux.org.uk>
 <20100513174023.GB13001@n2100.arm.linux.org.uk>
 <20100513211951.GH3428@atomide.com>
 <20100513215825.GC13001@n2100.arm.linux.org.uk>
 <20100513220139.GO3428@atomide.com>
 <20100513221229.GD13001@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42524 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0ENHYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 03:24:23 -0400
In-Reply-To: <20100513221229.GD13001@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Russell
> King - ARM Linux
> Sent: Friday, May 14, 2010 3:42 AM
> To: Tony Lindgren
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org; Tomi Valkeinen
> Subject: Re: [RFC] Initial attempt to make ARM use LMB
> 
> On Thu, May 13, 2010 at 03:01:39PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 14:53]:
> > > On Thu, May 13, 2010 at 02:19:51PM -0700, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10:35]:
> > > > > And here's a patch which converts the OMAP FB code to use lmb_reserve
> > > > > instead of poking about with bootmem stuff.  Untested, so I'd like to
> > > > > hear back whether it works.
> > > >
> > > > Did a quick test with the following patches picked from your lmb
> > > > branch on top of omap for-next branch:
> > > >
> > > > ARM: Remove useless linux/bootmem.h includes
> > > > ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
> > > > ARM: initial LMB trial
> > > > ARM: Move platform LMB memory reservations out of generic code
> > > >
> > > > and then this patch.
> > > >
> > > > It does not boot.. It seems to be related to the patch
> > > > "ARM: initial LMB trial". If I only apply the first two patches
> > > > above the system boots.
> > >
> > > Hmm, I'm sure it worked for me when I tested it out.  Could you try
> > > booting with lmb=debug please?
> >
> > No other output with that it seems.
> 
> Hang on, you didn't pick up ARM: Move memory mapping into mmu.c ?

I just gave a try on OMAP3430 and it does boot for me. But fb doesn't
seems to be working. I have tried this on Tony's "omap-testing" 
branch where the LMB support is pulled in

*********************************************************
omapfb omapfb: failed to allocate framebuffer
omapfb omapfb: failed to allocate fbmem
omapfb omapfb: failed to setup omapfb
omapfb: probe of omapfb failed with error -12
twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:
***********************************************************
Regards,
Santosh

