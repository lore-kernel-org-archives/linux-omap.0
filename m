From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: reset handling in am335x hwmod data
Date: Fri, 18 Jan 2013 15:18:30 +0100
Message-ID: <877gnaingp.fsf@dell.be.48ers.dk>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
	<alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
	<87d2xda34m.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:38498 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab3AROX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 09:23:59 -0500
Received: by mail-ea0-f171.google.com with SMTP id c13so836440eaa.30
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 06:23:57 -0800 (PST)
In-Reply-To: <87d2xda34m.fsf@dell.be.48ers.dk> (Peter Korsgaard's message of
	"Thu, 10 Jan 2013 08:50:01 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

Hi,

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

 Peter> I tried changing omap_device_build_from_dt() to call
 Peter> omap_hwmod_no_setup_reset() on the corresponding hwmod if a
 Peter> ti,no-init-reset was present, but that doesn't work as the hwmod
 Peter> reset happens quite a bit earlier (in
 Peter> omap_hwmod_setup_all()). Do you have idea how I could work
 Peter> around this or is that the future reset change you referred to
 Peter> above?

Paul, any ideas?

-- 
Bye, Peter Korsgaard
