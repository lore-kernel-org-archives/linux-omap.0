From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Tue, 17 Jan 2012 19:47:24 +0000
Message-ID: <20120117194724.GI16726@n2100.arm.linux.org.uk>
References: <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com> <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com> <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com> <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com> <20120117162720.GG11475@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47474 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2AQTrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 14:47:42 -0500
Content-Disposition: inline
In-Reply-To: <20120117162720.GG11475@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 17, 2012 at 04:27:21PM +0000, Catalin Marinas wrote:
> Anyway, the first step is this API provided by the secure firmware.
> Since such API may need to be called before the MMU is initialised,
> Linux would need to have knowledge of the platform type early on. Having
> some platform hook (asm macro) to call early on wouldn't work with the
> single zImage configuration. Stack space is not an issue as we already
> have one for ARMv7 for D-cache flushing (XIP kernels would work but they
> aren't that many).

It _is_ a problem.  How much stack space would these undefined platform
specific functions require?  16 words?  32 words?  A page?  Where does
this memory come from?  The .data section, or are we going to stuff it
into what is supposed to be the read-only text section?
