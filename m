From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 20:31:29 +0100
Message-ID: <20120427193129.GA3951@n2100.arm.linux.org.uk>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com> <20120427160445.GC28062@n2100.arm.linux.org.uk> <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com> <20120427165032.GD28062@n2100.arm.linux.org.uk> <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com> <20120427171933.GE28062@n2100.arm.linux.org.uk> <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com> <20120427183116.GF28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36042 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760475Ab2D0Tbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 15:31:39 -0400
Content-Disposition: inline
In-Reply-To: <20120427183116.GF28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 07:31:16PM +0100, Russell King - ARM Linux wrote:
> I don't have that in the branch I'm building because I started the
> DMA engine work against v3.4-rc3.
> 
> > This is the second patch to separate the twl6040 from twl-core.
> > If you are missing this patch twl6040 will not probe (twl core will
> > not register the audio if we have twl6030).
> 
> So it sounds like if I rebase stuff forward to -rc4, it should start
> working?

Right, so that was the problem.  Why not say in the first place that
it required -rc4 instead of just saying that it was in v3.4-rc ?  It's
taken severeal frustrating hours to get to this point...

But.. if I repeatedly aplay /dev/zero, I get randomly spat out on the
console:

omap_hwmod: mcpdm: _wait_target_disable failed

If I play a raw PCM audio file with aplay (44.1kHz s16le 2ch), I get
several of these from time to time:

DMA synchronization event drop occurred with device 66                          

and the 'noise' from the small loudspeakers is just about recognizable -
but is not what I was expecting (it's slow, plus it sounds on those small
speakers that it's horribly distorted.)  I can't get the headset jack
working to be able to play it through a decent sound system, through which
I'll be able to actually _hear_ what the corruption is.  I've tried fiddling
with everything in alsamixer, including turning on the vibras in the hope
of some kind of output (at least that does spin the motors.)

Timing the playback shows that something is very definitely not right:

On the laptop:
rmk@rmk-PC:[linux-rmk]:<2154> time aplay -f s16_le -c 2 -r 44100 NYG.s16.2.le 
Playing raw data 'NYG.s16.2.le' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
real	4m56.911s
user	0m0.287s
sys	0m0.571s
rmk@rmk-PC:[linux-rmk]:<2155> md5sum NYG.s16.2.le
291d33b87e8d60556fd461216291889f  NYG.s16.2.le

On the SDP4430:
root@omap-4430sdp:~# time aplay -f s16_le -c 2 -r 44100 NYG.s16.2.le 
Playing raw data 'NYG.s16.2.le' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
real	5m 53.67s
user	0m 3.17s
sys	0m 0.29s
root@omap-4430sdp:~# md5sum NYG.s16.2.le
291d33b87e8d60556fd461216291889f  NYG.s16.2.le

I notice that aplay is having to upconvert the audio to 96kHz 32 bit, so
that could be an ALSA library problem.

Any ideas?
