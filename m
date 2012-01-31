From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Tue, 31 Jan 2012 10:10:00 +0000
Message-ID: <20120131101000.GA1275@n2100.arm.linux.org.uk>
References: <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com> <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com> <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com> <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com> <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com> <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com> <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41377 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab2AaKKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 05:10:42 -0500
Content-Disposition: inline
In-Reply-To: <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 31, 2012 at 09:53:25AM +0000, Catalin Marinas wrote:
> Maybe we could factor out the CPU-specific settings from proc-v*.S
> into a separate arch/arm/boot/preload directory. We keep proc-v*.S
> entirely generic and the implementation-defined bits setting in the
> preload code. You could have an option to link the preload with the
> kernel but we could recommend that people run this code from
> boot-loader before invoking the kernel.

You've seen the resistance from uboot to stuff we do with the kernel,
this will be no different.  There's also quite a number of boot loaders
out there which aren't capable of running a binary, returning and then
loading and running the kernel.

Plus, of course, it's far from friendly towards TFTP setups.
