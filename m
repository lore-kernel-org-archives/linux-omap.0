From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
Date: Fri, 27 Jan 2012 17:30:29 +0000
Message-ID: <20120127173029.GA3281@arm.com>
References: <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk>
 <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49745 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395Ab2A0Rau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 12:30:50 -0500
Content-Disposition: inline
In-Reply-To: <WC20120120085711.330803@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Aneesh V <aneesh@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 20, 2012 at 08:57:11AM +0000, Joe Woodward wrote:
> > So I re-iterate that we need to have solution to this problem.
> 
> ... I don't want to be a pain, but it seems to me that this dicussion
> didn't reach a full conclussion?

Probably not, because it depends on many variables. See below my take on
this.

> I think it was left with the open options being:
> 1) Leave the L2/outer cache enabled in the bootloader (not ideal and
> may cause problems with future devices)

This depends on whether the L2 is inner or outer:

L2 inner - leave it enabled in the boot loader
L2 outer - leave it disabled in the boot loader

> 2) Turn the L2/outer cache on for OMAP3 later in the kernel boot when
> the device is known

Same as above:

L2 inner - don't do anything, it gets used when SCTLR.M is enabled
L2 outer - enabled at boot time via the platform code (later, after MMU
	was enabled).

-- 
Catalin
