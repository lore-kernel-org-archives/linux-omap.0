From: David Brownell <david-b@pacbell.net>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 18:16:17 -0800
Message-ID: <200812111816.17860.david-b@pacbell.net>
References: <1228870250.32014.148.camel@localhost.localdomain> <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com> <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:41040 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756429AbYLLCQU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2008 21:16:20 -0500
In-Reply-To: <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@booyaka.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

On Thursday 11 December 2008, Grazvydas Ignotas wrote:
> Curiously at this point I can plug/unplug to my ext hub any additional
> devices as much as I want, as long as I keep the first device plugged.
> If I unplug all devices from ext hub, I get suspend and kernel no
> longer reacts to any replugs.

Sounds like one issue might be that EHCI isn't waking up the
way it should, when it gets "remote wakeup" signaling from USB.

The USB host drivers go to some effort to put themselves in as
low a runtime power state as practical, and rely on the hardware
to wake up given events like insertion/removal of an external
device, or the downstream device issuing wakeup signaling (e.g.
press a key on a keyboard that went to sleep).

OMAP has been known to need special attention to kick in such
wakeup mechanisms.  Maybe this is another such case.

- Dave

