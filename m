From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Wed, 20 Feb 2013 20:37:46 +0000
Message-ID: <20130220203746.GZ17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <20130215064429.GA30038@arwen.pp.htv.fi> <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com> <20130220191638.GA25609@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47240 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934126Ab3BTUiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 15:38:00 -0500
Content-Disposition: inline
In-Reply-To: <20130220191638.GA25609@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Wed, Feb 20, 2013 at 09:16:38PM +0200, Felipe Balbi wrote:
> Also, IMHO reset should always be done during probe() so driver can be
> dead sure that we're starting from a known state. This is even more
> important for the complex IPs which are licensed from RTL vendors and
> are used in different SoCs. While arch/arm/mach-abc/ resets every IP
> pior to probe() being called, we can't be sure that arch/arm/mach-xyz/
> will do the same thing and imposing such requirement is too difficult.

And that's where you're wrong.  Virtually nothing in arch/arm/mach-*
does any manipulation of hardware resets for individual IP blocks.
This just doesn't feature.  Mainly because many SoCs generally do not
have a way to reset individual IP blocks - normally you find that you
get the option of resetting the entire platform including the CPU or
nothing at all.

And what that means is that we expect to take over hardware in a
not-well-defined state and start using it.

This is even more complicated by kexec() where we can end up booting
a kernel from a previously crashed kernel where the devices are still
running from the crashed kernel - and we _hope_ that it works.  (It
doesn't always - think about devices which DMA into the kernel's
memory.)

So really... get over the fact that you have reset bits that you can
twiddle on your SoC - that's a cool additional feature.  Many SoCs
that Linux runs on doesn't have that, and you have to start using the
hardware from whatever state you find it in.  And that means a probe
function has to do things like:

1. Mask all interrupts on the device and clean out any pending
   interrupts.
2. Initialize the settings that it needs on the device to the values
   it requires.
etc.

I'm not saying to you to forego the reset - I'm saying that your assertion
that everything in Linux starts from a known state is definitely false.
