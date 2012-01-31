From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 00:15:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com> <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39615 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2AaHP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 02:15:26 -0500
In-Reply-To: <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi

just a few thoughts.

On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

> In this code the need is to clear only CPU and MPUPD, and hence they are
> explicitly cleared since the pre/post transition calls can be moved to PM_DEBUG
> in production kernels.
> 
> But as you stated in current mainline kernel they are superfluous since the
> pre/post calls are not under PM debug. So I am ok either way

We're using the PM counters for the context restore skip optimization now 
in pwrdm_get_context_loss_count(), so they've suddenly become needed even 
when PM_DEBUG=n.  But those counters are only needed when there are 
devices in the CPU* powerdomains to track that can lose logic context.  I 
don't think that's the case on OMAP4, but you would probably know better 
than I.

Another aspect is that previous powerstate accesses for the CPU* 
powerdomains would theoretically go to the MPU local PRM rather than the 
system PRCM.  So they may actually return quickly.  Haven't tested this.

The MPUSS powerdomain might be another case, though.  There are a bunch of 
devices in there: the local timers, APB debug devices, etc.  We probably 
have to worry about restoring context for some of those at some point.


- Paul
