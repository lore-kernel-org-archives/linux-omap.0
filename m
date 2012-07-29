From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Sun, 29 Jul 2012 22:31:25 +0100
Message-ID: <20120729213125.GD7405@n2100.arm.linux.org.uk>
References: <20120625005134.GA2342@S2101-09.ap.freescale.net> <20120625084905.GD19226@n2100.arm.linux.org.uk> <CAAwP0s2jTPM_ErDOFKXoe95_Xd=xjkuTAsDbLctQ08_QVNkakQ@mail.gmail.com> <5012CC98.60206@ti.com> <20120727204447.GA10024@mudshark.cambridge.arm.com> <20120727210637.GA16377@n2100.arm.linux.org.uk> <20120727214024.GA10249@mudshark.cambridge.arm.com> <20120728100831.GC7405@n2100.arm.linux.org.uk> <20120728121103.GA11370@mudshark.cambridge.arm.com> <CABxcv=mVKt8+gYK6kHydmG3SnDZgjMbJuEcUBx_z5sumNY_SQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51299 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2G2Vbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jul 2012 17:31:39 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=mVKt8+gYK6kHydmG3SnDZgjMbJuEcUBx_z5sumNY_SQw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Will Deacon <will.deacon@arm.com>, Jon Hunter <jon-hunter@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Jul 28, 2012 at 04:26:28PM +0200, Javier Martinez Canillas wrote:
> On Sat, Jul 28, 2012 at 2:11 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > The next question is: who's putting this into the patch system?
> >
> > Will
> 
> Hi,
> 
> I just put the patch with Will's Acked-by on the patch system. It  was
> accepted as patch 7480/1 [1].
> 
> The patch is on top of today's linux-next (next-20120727).
> 
> Thanks a lot and best regards,
> Javier
> 
> [1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7480/1

Isn't this a candidate for stable kernels?
