From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: reset handling in am335x hwmod data
Date: Thu, 10 Jan 2013 08:50:01 +0100
Message-ID: <87d2xda34m.fsf@dell.be.48ers.dk>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:60499 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab3AJHuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 02:50:06 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so96928wge.34
        for <linux-omap@vger.kernel.org>; Wed, 09 Jan 2013 23:50:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com> (Paul
	Walmsley's message of "Sun, 23 Dec 2012 20:58:13 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

>>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:

Hi Paul,

Thanks for the detailed explanaition, and sorry for the slow response -
I've been away on holidays.

 >> Now the question is why is this configured like this?

 Paul> This behavior is intended to decouple the kernel from the
 Paul> bootloader, or previously-booted operating system (e.g., the
 Paul> kexec case).  The original goal was to place the system in an
 Paul> known safe state as soon as possible after the kernel starts.
 Paul> This is to prevent misconfigured or previously-configured devices
 Paul> from trashing memory or chip power management in the
 Paul> currently-booted kernel.  It also avoids adding inadvertent
 Paul> bootloader dependencies in driver code.

 Paul> N.B., the plan is to change this behavior over the next few
 Paul> releases.  Devices that have drivers associated with them will be
 Paul> reset when the driver loads.  Driverless devices will be reset
 Paul> after drivers load, late in boot.

 >> Should E.G. the gpio controllers be changed to not reset or should it be 
 >> configurable in the dts?

 Paul> Probably the DTS is the right place, since this is a board- and
 Paul> bootloader-specific quirk.  The original intention was to allow
 Paul> board files to set this HWMOD_INIT_NO_RESET flag themselves - see
 Paul> mach-omap2/ omap_hwmod.c:omap_hwmod_no_setup_reset().  But since
 Paul> we've deprecated the board files, the DT data seems like the
 Paul> right place.

 Paul> It probably shouldn't be a GPIO-specific property.  Other devices
 Paul> like DSS will also need some kind of 'no-init-reset' property,
 Paul> since on many commercial devices, it's expected that some kind of
 Paul> splash screen will be presented by the bootloader and stay on
 Paul> during the boot process.

I tried changing omap_device_build_from_dt() to call
omap_hwmod_no_setup_reset() on the corresponding hwmod if a
ti,no-init-reset was present, but that doesn't work as the hwmod reset
happens quite a bit earlier (in omap_hwmod_setup_all()). Do you have
idea how I could work around this or is that the future reset change you
referred to above?


 Paul> However, it is probably safest in the long run if you can change
 Paul> the board design to require the SoC to actively reset the FPGA,
 Paul> rather than making reset the default state.  That way, if there's
 Paul> some hardware bug that requires the GPIO block to be reset, or if
 Paul> there's some GPIO glitch during power management, the FPGA won't
 Paul> be inadvertently reset.

Yes, I'll try to get that done for the next board spin.

Thanks!

-- 
Bye, Peter Korsgaard
