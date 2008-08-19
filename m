From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 09:24:23 +0300
Message-ID: <20080819062422.GD17276@atomide.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com> <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com> <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com> <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com> <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com> <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57422 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYHSGY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 02:24:28 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

* Felipe Contreras <felipe.contreras@gmail.com> [080818 23:09]:
> On Mon, Aug 18, 2008 at 10:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> >> If you mean there is separate clock infrastructure for DSPBridge other
> >> than clock framework we have for OMAP, then DSPBridge should convert
> >> to the one we have for OMAP. As recent work by Paul for clock
> >> framework on OMAP3 and Power domains we need centralized code for clk
> >> and power domains not separate clock infrastructure for DSPBridge.
> >>
> > --- Bridge is not implementing separate clock infrastructure. It is just centralizing the calls to clk_enable in one location as this is called from multiple files in Bridge code. This helps because one can then turn on the traces only for clock module to check if the clocks that were expected to be enabled are enabled or not. As I mentioned before, this helps in debugging.
> 
> That only makes the code harder to understand.
> 
> #define clk_enable(...) my_debug_function(__VA_ARGS__)
> 
> Achieves the same thing.

We must use clk_enable() and clk_disable() in the drivers. That's the
Linux clock interface. Anything else won't get merged upstream.

If you need to combine multiple clocks into a single virtual dsp
clock, please register a new custom clock using clk_register().

That allows you to do debugging in the custom clock functions too
if necessary.

Regards,

Tony
