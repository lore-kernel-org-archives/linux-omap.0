From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP1: mcbsp clocks
Date: Fri, 23 Jan 2009 17:31:21 +0000
Message-ID: <20090123173121.GL26184@n2100.arm.linux.org.uk>
References: <20090122235543.GC8137@n2100.arm.linux.org.uk> <7B4574D56E4ADF438756313E9A172A872CABB6EA@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35747 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbZAWRbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 12:31:33 -0500
Content-Disposition: inline
In-Reply-To: <7B4574D56E4ADF438756313E9A172A872CABB6EA@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jan 23, 2009 at 11:18:37AM -0600, Hunter, Jon wrote:
>...
> So for McBSP1/3 you definitely need to have the MPUI clock enabled.

Thanks - that certainly explains why some of these things are happening
which is most useful.  However, the approach I've taken is to keep things
in a similar method to how they were before - which in this case means
that the code still enables the MPUI and DSP clocks for McBSP1,3, but
does it differently.

While I can test out my changes on the LDP, I'm using qemu to test in an
OMAP1510 environment - not that I attach _too_ much worth to that test.
I'm well aware that qemu is no subsitute for the real hardware, and so
will shortly be asking for people to boot test these changes.

However, I suspect mainline might not be advanced enough to even test
out the audio on an OSK board... we'll cross that bridge when we come to
it.
