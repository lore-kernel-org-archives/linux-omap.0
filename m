From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Sun, 29 Apr 2012 21:35:25 +0100
Message-ID: <20120429203525.GA4618@n2100.arm.linux.org.uk>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAPo=G1ze3Yfr5FyQG_nByT3b5k=+Ux+6aupg=dD1Qe-Zx1RiqQ@mail.gmail.com> <20120427160445.GC28062@n2100.arm.linux.org.uk> <CAPo=G1xJj_mJAETqtxWdugYhP0LV=0XrMLeFGtkOBJZAi3Jy1A@mail.gmail.com> <20120427165032.GD28062@n2100.arm.linux.org.uk> <CAPo=G1yiX1644Cwkdnt7Ff7+yYbJQw5mnEbwd0txw-Wj_YdV7Q@mail.gmail.com> <20120427171933.GE28062@n2100.arm.linux.org.uk> <CAPo=G1wDANyQ5ARyerizp6oA=Wyc7s_to7zfz-n4GdZ20tfX4g@mail.gmail.com> <20120427183116.GF28062@n2100.arm.linux.org.uk> <20120427193129.GA3951@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46550 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2D2Uff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Apr 2012 16:35:35 -0400
Content-Disposition: inline
In-Reply-To: <20120427193129.GA3951@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>

On Fri, Apr 27, 2012 at 08:31:29PM +0100, Russell King - ARM Linux wrote:
> and the 'noise' from the small loudspeakers is just about recognizable -
> but is not what I was expecting (it's slow, plus it sounds on those small
> speakers that it's horribly distorted.)  I can't get the headset jack
> working to be able to play it through a decent sound system, through which
> I'll be able to actually _hear_ what the corruption is.

I've just tried pluging a 3.5mm stereo jack plug into the headset jack,
and tried loading up the rip and ring to sleave with various different
loads.  I see no reaction on the detection IRQ line:

389:          0          0   twl6040  twl6040_irq_plug

which seems to suggest that the jack detection is non-functional.

With all the documentation for the 4430SDP board hidden away under NDAs
within TI, I am unable to do any investigation myself to work out what's
wrong.

Please can someone at TI take a current mainline kernel, build it, and
test out audio support on the 4430SDP - specifically output through the
headset jack into a line input, and report when it works.  Thanks.
