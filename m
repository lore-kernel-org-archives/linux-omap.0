From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Tue, 1 May 2012 12:14:00 +0100
Message-ID: <20120501111400.GF25053@n2100.arm.linux.org.uk>
References: <20120427160445.GC28062@n2100.arm.linux.org.uk> <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com> <20120427165032.GD28062@n2100.arm.linux.org.uk> <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com> <20120427171933.GE28062@n2100.arm.linux.org.uk> <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com> <20120427183116.GF28062@n2100.arm.linux.org.uk> <20120427193129.GA3951@n2100.arm.linux.org.uk> <20120429203525.GA4618@n2100.arm.linux.org.uk> <4F9E3EB5.8030104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41468 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab2EALON (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 07:14:13 -0400
Content-Disposition: inline
In-Reply-To: <4F9E3EB5.8030104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Mon, Apr 30, 2012 at 10:26:45AM +0300, Peter Ujfalusi wrote:
> On 04/29/2012 11:35 PM, Russell King - ARM Linux wrote:
> > Please can someone at TI take a current mainline kernel, build it, and
> > test out audio support on the 4430SDP - specifically output through the
> > headset jack into a line input, and report when it works.  Thanks.
> 
> Try to use my attached aconf for SDP4430 to configure the HS playback.
> Note that the HS is not a line out, so on your line-in device it will
> cause distortion. If you have a headset/headphone you will have better
> quality.
> alsactl -f blaze.aconf restore

This had no effect on its own.

> To play samples with aplay:
> aplay -Dplughw:0,0 <wav file>
> The sample format fot Legacy McPDM is S32_LE, 96KHz, 24bit (32 bit
> sample with 24 LSB).
> 
> The slow pace audio playback is because at this point we do not have the
> full audio stack up. The AESS IP does not have driver. You need to
> disable CONFIG_OMAP_RESET_CLOCKS. This will fic the audio playback speed.

But with that configuration file and that option disabled, I now get
audio output via the HS jack.  Bellowhead sounds a lot better now.
