From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Fri, 11 Apr 2014 17:31:21 +0530
Message-ID: <5347D991.1030004@ti.com>
References: <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <20140409162327.GH27282@n2100.arm.linux.org.uk> <534686DF.7070207@ti.com> <20140410120348.GK27282@n2100.arm.linux.org.uk> <53468B8E.9040604@ti.com> <53469C29.8050906@ti.com> <20140410134028.GL27282@n2100.arm.linux.org.uk> <53477EC5.5080400@ti.com> <20140411112500.GM27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45145 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbaDKMB7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2014 08:01:59 -0400
In-Reply-To: <20140411112500.GM27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Friday 11 April 2014 04:55 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 11, 2014 at 11:03:57AM +0530, Sekhar Nori wrote:
>> Here is a revised patch which is just an extension of your patch 
>> with L2C-220 case handled. I dont really have L2C-220 hardware so even 
>> if you want to handle that at a later time, it would be perfectly okay 
>> with me.
> 
> This is what I came up with, which of course is very similar to yours.
> I think the only difference is that I'm allowing the state of the NS
> access bits to be preserved by the OMAP code, getting OMAP closer to
> the target of a ~0 mask.  The only bits which are clear in the mask
> passed into the L2 code by OMAP now are:

Thanks for sending the patch. I will use it to rebase the $subject
series against.

> 
> - L310_AUX_CTRL_INSTR_PREFETCH
> - L310_AUX_CTRL_DATA_PREFETCH
> - L310_AUX_CTRL_CACHE_REPLACE_RR
> - L2C_AUX_CTRL_SHARED_OVERRIDE
> - L2C_AUX_CTRL_PARITY_ENABLE
> 
> It sounds like we can kill L310_AUX_CTRL_CACHE_REPLACE_RR as well since
> that's already set for us (and fwir is the power-on-reset default too.)

Thanks right.

Thanks,
Sekhar
