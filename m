From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Tue, 8 Sep 2009 21:23:02 +0100
Message-ID: <20090908202302.GE23361@n2100.arm.linux.org.uk>
References: <20090815153357.GF29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com> <20090815181711.GG29616@n2100.arm.linux.org.uk> <20090817173343.GA17323@debian> <20090817174718.GU10764@n2100.arm.linux.org.uk> <20090817180145.GA17378@debian> <20090817180455.GW10764@n2100.arm.linux.org.uk> <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com> <20090818030148.GA2283@debian> <20090907142210.GB23361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59088 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZIHUYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 16:24:05 -0400
Content-Disposition: inline
In-Reply-To: <20090907142210.GB23361@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 07, 2009 at 03:22:10PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 18, 2009 at 08:31:49AM +0530, Rabin Vincent wrote:
> > Here's a fixed version:
> 
> And here's my revised version with these fixes in.  I changed the
> while loop to a do..while loop instead (since we will always have
> at least one memory bank, it's pointless doing that test for the
> first iteration.)
> 
> Acks and tested-bys would be useful please.

Haven't heard anything, so I've committed it as is.  It is my intention
to push it to Linus as is in the next couple of days.
