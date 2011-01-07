From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Fri, 7 Jan 2011 14:24:32 +0000
Message-ID: <20110107142432.GO1198@n2100.arm.linux.org.uk>
References: <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk> <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33577 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1AGOYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 09:24:41 -0500
Content-Disposition: inline
In-Reply-To: <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Jan 07, 2011 at 06:39:06PM +0530, Santosh Shilimkar wrote:
> Have sent you latest bootloaders and full bootlog on my ES1.0
> OMAP4430SDP. 2.6.37 just boots fine for me.
> 
> Low level debug as you reported seems to be broken though.

Many thanks, the new mlo and uboot gets dhcp/tftp working nicely on
the board - which should ease the debugging problem as it no longer
requires anything but the reset button pressed to test a new kernel.
