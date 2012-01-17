From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Tue, 17 Jan 2012 19:43:27 +0000
Message-ID: <20120117194327.GH16726@n2100.arm.linux.org.uk>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk> <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com> <20120116131329.GA928@n2100.arm.linux.org.uk> <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com> <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com> <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54502 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2AQTng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 14:43:36 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 02:58:18PM +0100, Shilimkar, Santosh wrote:
> Patching in boot-loaders isn't an option either since every customers
> prefers to use there own boot-loader and then controlling
> this vital bits is impossible.
> 
> So I re-iterate that we need to have solution to this problem.

And I'll re-iterate that it'll create an absolute abonimation of code
to do this in the kernel - not only will it be extremely fragile, it
will be hell to maintain in the longer term.  It will also be highly
platform specific.

Essentially, what you're asking is for us to find some way to call a
platform specific function depending on the platform (which we haven't
parsed yet), which uses a set of undefined registers, which may corrupt
an undefined set of registers.  And call that function from a place in
the kernel which requires a set of registers to be preserved, with no
stack available to save registers, and call the function via a PC
relative branch (as its virtual address is useless to us at this point.)

If anything goes wrong, there's no way to report that as your only
option is to stop dead (if you're lucky) or maybe end up with the
processor trying to execute instructions from a non-existent or
uninitialized vectors page, etc.

This is far too much.  This is far too fragile.  This is asking for
undebuggable problems.  This is asking for lots of people with unbootable
kernels.

No.  Thanks.
