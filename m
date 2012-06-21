From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Thu, 21 Jun 2012 14:22:49 +0100
Message-ID: <20120621132249.GA27635@n2100.arm.linux.org.uk>
References: <20120427165032.GD28062@n2100.arm.linux.org.uk> <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com> <20120427171933.GE28062@n2100.arm.linux.org.uk> <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com> <20120427183116.GF28062@n2100.arm.linux.org.uk> <20120427193129.GA3951@n2100.arm.linux.org.uk> <20120429203525.GA4618@n2100.arm.linux.org.uk> <4F9E3EB5.8030104@ti.com> <20120621125903.GA17984@n2100.arm.linux.org.uk> <20120621131642.GA27383@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59941 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759598Ab2FUNW5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 09:22:57 -0400
Content-Disposition: inline
In-Reply-To: <20120621131642.GA27383@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Thu, Jun 21, 2012 at 02:16:42PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 21, 2012 at 01:59:03PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 30, 2012 at 10:26:45AM +0300, Peter Ujfalusi wrote:
> > > On 04/29/2012 11:35 PM, Russell King - ARM Linux wrote:
> > > > Please can someone at TI take a current mainline kernel, build it, and
> > > > test out audio support on the 4430SDP - specifically output through the
> > > > headset jack into a line input, and report when it works.  Thanks.
> > > 
> > > Try to use my attached aconf for SDP4430 to configure the HS playback.
> > > Note that the HS is not a line out, so on your line-in device it will
> > > cause distortion. If you have a headset/headphone you will have better
> > > quality.
> > > alsactl -f blaze.aconf restore
> > > 
> > > To play samples with aplay:
> > > aplay -Dplughw:0,0 <wav file>
> > > The sample format fot Legacy McPDM is S32_LE, 96KHz, 24bit (32 bit
> > > sample with 24 LSB).
> > 
> > I'm just having another go with OMAP4430 audio... and again I find that
> > I can't get anything out of the board.
> > 
> > I've followed what you've said above, and it doesn't work.  I've undone
> > my DMA engine changes.  Still doesn't work.  I've checked
> > /sys/kernel/debug/asoc for the codecs and DAIs, and they're there, and
> > the SDP4430 audio is shown in /proc/asound/cards too, and yes, you
> > guessed it, it still doesn't work.
> > 
> > It's just a really expensive /dev/null from what I can tell at the moment.
> > 
> > Frustrated.
> 
> Okay, reverting back to v3.4-rc4 works.

As does reverting to v3.4, of course.  So, it was broken during the last
merge window.
