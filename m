From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Wed, 9 Feb 2011 11:45:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102091143020.14920@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <0557426516de482c1769a50fa0b5f17a@mail.gmail.com> <20110208164747.GD6188@n2100.arm.linux.org.uk> <78d0134576ace6be5874871076cf0c10@mail.gmail.com> <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
 <20110209003537.GQ20795@atomide.com> <54f225541194205f01fe9f03b5110d16@mail.gmail.com> <AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com> <80a27c86473cf29a9fa5e68aa29eef46@mail.gmail.com> <20110209162421.GU20795@atomide.com>
 <20110209163204.GB11460@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45566 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab1BIQpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 11:45:33 -0500
Received: by qyj19 with SMTP id 19so1530217qyj.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 08:45:32 -0800 (PST)
In-Reply-To: <20110209163204.GB11460@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 9 Feb 2011, Russell King - ARM Linux wrote:

> On Wed, Feb 09, 2011 at 08:24:21AM -0800, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110209 01:59]:
> > > > From: Dave Martin [mailto:dave.martin@linaro.org]
> > > >
> > > > You could also have a "v7+" unified kernel -- i.e., supporting
> > > > OMAP3+4+SMP.
> > > > This is what we currently do in Linaro, since we're focusing on v7
> > > > and above.
> > > >
> > > This sounds good way forward considering future OMAP architectures
> > > as well.
> > > 
> > > But I let Tony comment on this idea.
> > 
> > AFAIK these issues will be hopefully sorted out by the time the
> > next merge window opens. For the -rc cycle, disabling SMP in
> > config if ARMv6 is selected should do the trick.
> 
> That's not soo easy - as we don't know in the Kconfig whether we include
> ARMv6 rather than ARMv6K.  It's exactly the same problem I ran into which
> inflated the v6v7 patchset.
> 
> Maybe the best thing to do is:
> 
> config CPU_32v6K
>         bool "Support ARM V6K processor extensions" if !SMP
>         depends on CPU_V6 || CPU_V7
>         default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
> 
> drop the ' && !(ARCH_MX3 || ARCH_OMAP2)' and just let people run into the
> resulting undefined instruction traps if they try to run the kernel on
> V6 non-K hardware.  Not ideal, but I don't see any other 'simple' solution
> to this.

This should be good enough.  We're looking for a temporary stopgate 
solution to prevent people from corrupting their data, and the real fix 
will be available in the next kernel.


Nicolas
