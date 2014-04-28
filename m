From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] mfd: twl4030-power: Add recommended idle
 configuration
Date: Mon, 28 Apr 2014 08:33:47 -0700
Message-ID: <20140428153346.GI20807@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-2-git-send-email-tony@atomide.com>
 <20140428114133.GV21279@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756434AbaD1Pdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 11:33:55 -0400
Content-Disposition: inline
In-Reply-To: <20140428114133.GV21279@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

* Lee Jones <lee.jones@linaro.org> [140428 04:42]:
> > These settings are based on the "Recommended Sleep Sequences for
> > the Zoom Platform" pdf at:
> > 
> > http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
> > 
> > These settings assume most of the regulators are under control of
> > Linux, and cuts off VDD1 and VDD2 during off-idle as Linux cannot
> > do it.
> 
> Linux does it becuase Linux can't do it. Eh?

Heh yeah that's confusing, will update to:

These settings assume most of the regulators are under control of
Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
Linux cannot do it.

Regards,

Tony
