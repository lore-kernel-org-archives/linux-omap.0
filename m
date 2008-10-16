From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: omapfb: help from userspace
Date: Thu, 16 Oct 2008 15:15:22 -0700
Message-ID: <e5e6ade50810161515h6c050ab2k1657e1e3a12edd6c@mail.gmail.com>
References: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE89671620365B58844@dlee02.ent.ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301B0108CAB@dbde02.ent.ti.com>
	 <20081009124357.GF26230@atomide.com>
	 <e5e6ade50810091055se7af4aasc404eb92f176dfeb@mail.gmail.com>
	 <alpine.DEB.2.00.0810150556140.14740@utopia.booyaka.com>
	 <e5e6ade50810152349x38b6f5e2oe59780cc2008c837@mail.gmail.com>
	 <20081016205743.GS15820@atomide.com>
	 <e5e6ade50810161507y4a5ac9d6m9754169575dfbdda@mail.gmail.com>
	 <20081016221053.GZ15820@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:26512 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250AbYJPWPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 18:15:23 -0400
Received: by qw-out-2122.google.com with SMTP id 3so90652qwe.37
        for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 15:15:22 -0700 (PDT)
In-Reply-To: <20081016221053.GZ15820@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Rick Bronson <rick@efn.org>

On Thu, Oct 16, 2008 at 3:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> No.. And I also got some -33 errors here too :( So back to the drawing
> board.
>
> Could you post step by step instructions on how you can reproduce your
> problem?

I'm running the DSP Bridge patches in my kernel.  I got them set up
using this guide:
http://elinux.org/BeagleBoard/DSP_Howto

That guide also points to some sample binaries, including 'ping.out',
which is a simple round-trip test between the DSP and ARM.

To reproduce, I do this:
1) Boot kernel with mem=122m
2) modprobe bridgedriver phys_mempool_base=0x87a00000
phys_mempool_size=0x600000
base_img=/home/root/dsp/ddspbase_tiomap3430.dof64P
3) while true; do ./ping.out; done

This ALWAYS reproduces within seconds.

If the DSP patches are too much work to get set up, I've also heard
that people can reproduce this issue by playing movie files with
mplayer on Angstrom.

- Nathan
