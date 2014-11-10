From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: dts: AM43x: Fix DCDC3 regulator voltage
Date: Mon, 10 Nov 2014 09:05:51 -0800
Message-ID: <20141110170550.GL31454@atomide.com>
References: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
 <20141106182526.GC31454@atomide.com>
 <CAOCHtYiT9VgXD73gLRszSquJsN0Ew1KSNk_tXpA5OcDkT7KnqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59955 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752014AbaKJRGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 12:06:38 -0500
Content-Disposition: inline
In-Reply-To: <CAOCHtYiT9VgXD73gLRszSquJsN0Ew1KSNk_tXpA5OcDkT7KnqQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, galak@codeaurora.org, mark.rutland@arm.com, pawel.moll@arm.com

* Robert Nelson <robertcnelson@gmail.com> [141106 11:31]:
> On Thu, Nov 6, 2014 at 12:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Keerthy <j-keerthy@ti.com> [141106 02:55]:
> >> Fix DCDC3 volatge to 1.5V which is the right value to be supplied by
> >> DCDC3 for all the boards.
> >
> > Hmm so what about the comments for similar beaglebone changes
> > in thread "[PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator
> > for 1.35v ddr3"?
> 
> Based on Keerthy's patchset, i think we should just ignore my "1.35v"
> ddr3 patch for the beaglebone black. As by default it will be at
> 1.50v. (so we can either define it for clarity at 1.50v or just ignore
> it.)

OK thanks. I'll apply these into omap-for-v3.18/fixes and ignore
your beaglebone black patch.

Regards,

Tony
