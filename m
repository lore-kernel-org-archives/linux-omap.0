From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 11 May 2012 16:02:23 +0100
Message-ID: <20120511150223.GD2626@mudshark.cambridge.arm.com>
References: <4FAA4DB9.8060504@ti.com>
 <4FAAB1A3.9040806@ti.com>
 <4FAAC549.6010206@ti.com>
 <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com>
 <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com>
 <4FAD1865.70003@ti.com>
 <20120511134920.GC2626@mudshark.cambridge.arm.com>
 <4FAD27CB.5060102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42403 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760183Ab2EKPDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 11:03:06 -0400
Content-Disposition: inline
In-Reply-To: <4FAD27CB.5060102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 11, 2012 at 03:52:59PM +0100, Jon Hunter wrote:
> Hi Will,

Hello,

> On 05/11/2012 08:49 AM, Will Deacon wrote:
> > I enabled OMAP3 debug peripherals, so I selected CPU_HAS_PMU that way.
> 
> I tried the same (make omap2plus_defconfig and enabled the above
> option), and I do see the interrupts firing on both 4430 and 4460...
> 
> / # cat /proc/interrupts
>            CPU0       CPU1
>  29:       1023        404       GIC  twd
>  33:        401          0       GIC  arm-pmu
>  34:          0        441       GIC  arm-pmu

Well, at least it's working for somebody!

> What is your kernel commit ID that you applied the patches on top of?

7cf543bc ("Linux-omap rebuilt: Updated to -rc6, merged in pending branches,
please test"). Is there something else I need too?

> What board are you using? Blaze, panda, etc, and is it 4430 or 4460?

Ye olde Panda 4430. It does work with my perf/omap4 branch though using the
same .config (I can mail it to you separately if you want).

Cheers,

Will
