From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.13-rc1
Date: Tue, 26 Nov 2013 19:52:17 -0800
Message-ID: <20131127035216.GW26766@atomide.com>
References: <52954b58.8659420a.7af3.ffffeeabSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAOesGMh8hq5UbL5ion=fgAecfkMLw3E5+2m8T2LbdqgYafFK8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63470 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810Ab3K0DwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 22:52:22 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMh8hq5UbL5ion=fgAecfkMLw3E5+2m8T2LbdqgYafFK8Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

* Olof Johansson <olof@lixom.net> [131126 19:34]:
> On Tue, Nov 26, 2013 at 5:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > As we're moving omap2+ to be device tree only for v3.14, I'd like to
> > have v3.13 work equally well for legacy based booting and device tree
> > based booting. So there will be likely few more device tree related
> > booting patches trickling in.
> 
> Pulled, thanks. Do you have a feel for how much more of DT-vs-legacy
> patches you expect for 3.13? I'm not saying no to them at this point
> but it'd be good to know roughly what to expect.

Thanks, I currently only have four more coming but these still need
testing and acks:

net: smc91x: Fix device tree based configuration so it's usable
of/platform: Fix no irq domain found errors when populating interrupts
ARM: dts: Fix omap serial wake-up when booted with device tree
ARM: OMAP2+: Fix overwriting hwmod data with data from device tree

Then there will probably be few patches from other people but the
four above are currently the only ones that I'm aware of that can be
show stoppers for booting omaps (and also other SoCs) with device tree.

Regards,

Tony
