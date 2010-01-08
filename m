From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Fix cmdline muxing (Re: New pinmux)
Date: Fri, 8 Jan 2010 11:35:08 -0800
Message-ID: <20100108193508.GA2879@atomide.com>
References: <4B474F9B.9020409@balister.org>
 <20100108180031.GB6831@atomide.com>
 <4B478081.4060809@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50356 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0AHTfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 14:35:07 -0500
Content-Disposition: inline
In-Reply-To: <4B478081.4060809@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Philip Balister <philip@balister.org> [100108 10:57]:
> On 01/08/2010 01:00 PM, Tony Lindgren wrote:
> >* Philip Balister<philip@balister.org>  [100108 07:35]:
> >>I am trying to work out how to use the new pinmux code on my
> >>Overo+Summit system. I have a recent git running with the new pinmux
> >>code built. I am trying to configure the mcspi1_clk pin on the
> >>expansion connector as gpio_171 with the following:
> >>
> >>root@overo:~# dmesg |grep mux
> >>
> >>Kernel command line: console=ttyS2,115200n8 vram=12M
> >>omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y
> >>omapdss.def_display=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3
> >>rootwait omap_mux=mcspi1_clk.gpio_171=0x0
> >>
> >>And this is what happens :(
> >>
> >>mux: Could not set signal mcspi1_clk
> >>
> >>mux: Setting signal i2c3_scl.i2c3_scl 0x0118 ->  0x0100
> >>
> >>Any suggestions?
> >
> >Sounds like the cmdline options got broken by some changes
> >I did to limit everything to happen as __init..
> >
> >Can you please try the following patch?
> 
> The patch solved the problem, thanks! Great work guys, this will
> really help people working with boards with expansion connectors
> like the Beagle and Overo.

Good to hear :)
 
> Tony, do you need a signoff from me for this? Not to sure what the
> procedure is.

Maybe reply with your Tested-by? See Documentation/SubmittingPatches
for Reported-by/Tested-by etc.

Regards,

Tony
