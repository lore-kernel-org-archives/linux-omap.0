From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/18] ARM: OMAP3: PM: remove access to PRM_VOLTCTRL
 register
Date: Wed, 26 Mar 2014 11:40:00 -0700
Message-ID: <20140326183959.GA30631@atomide.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
 <1393949958-816-13-git-send-email-t-kristo@ti.com>
 <20140325223612.GA26395@atomide.com>
 <5332891F.9070002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35679 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753897AbaCZSkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2014 14:40:08 -0400
Content-Disposition: inline
In-Reply-To: <5332891F.9070002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

* Tero Kristo <t-kristo@ti.com> [140326 01:04]:
> On 03/26/2014 12:36 AM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140304 08:23]:
> >>There is a solitary write to this register every wakeup from off-mode,
> >>which isn't doing anything, so remove it.
> >
> >Argh, this chunk of code is for sure the the thing that's blocking all
> >the voltage scaling for idle modes that twl4030 is supposed to do!
> >
> >AFAIK we must have AUTO_SLEEP, AUTO_RET and AUTO_OFF bits set in
> >PRM_VOLTCTRL for twl4030 to scale anything. They must be set if we're
> >scaling over I2C4 or using the pins as triggers. Unless these bits
> >are set, VC won't send any SLEEP, RET or OFF commands.
> >
> >Looks like we're not even set these bits anywhere like we should?
> >
> >I think we should enabled these bits in vc.c init, and never clear?
> 
> The bits should be set according to the target sleep mode I believe,
> e.g. for retention we should set only AUTO_RET, and for off-mode
> AUTO_OFF. You can't have AUTO_OFF enabled if you are going to
> retention only as far as I recall, this potentially caused some
> problems.

OK. So it seems that the idle code needs to constantly modify this
register based on the idle mode. Any ideas how the idle code is going
to update this register? Register a callback using platform_data?

Regards,

Tony
