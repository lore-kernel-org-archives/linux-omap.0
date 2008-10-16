From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Thu, 16 Oct 2008 14:42:19 -0700
Message-ID: <e5e6ade50810161442r103a298di669f44b594de2d72@mail.gmail.com>
References: <20081010120427.GZ3044@atomide.com>
	 <200810161243.41079.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:20445 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYJPVmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 17:42:20 -0400
Received: by qw-out-2122.google.com with SMTP id 3so85315qwe.37
        for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 14:42:19 -0700 (PDT)
In-Reply-To: <200810161243.41079.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Oct 16, 2008 at 12:43 PM, David Brownell <david-b@pacbell.net> wrote:
> The MUSB transceiver-level issues I was aware of (mostly
> on Overo, but minor glitches on Beagle) now seem to be
> fixed by the combination of the IRQ patches I sent last
> week, plus the twl4030-usb patch I just sent.

This is working great for me now.  Whether I boot plugged in, or later
plug in the A side or B side, USB host mode is working again.  Thank
you!

Of course, I still apply a stack of Ajay's patches to get MUSB host
mode stable, but there's a different issue.

- Nathan
