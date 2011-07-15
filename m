From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 03:55:58 -0700
Message-ID: <20110715105558.GT5783@atomide.com>
References: <1310554738.18446.12.camel@lws-weitzel>
 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
 <4E1D8BCD.5060901@ru.mvista.com>
 <1310561772.18446.14.camel@lws-weitzel>
 <20110714073445.GL5783@atomide.com>
 <1310632792.4008.3.camel@lws-weitzel>
 <20110715075024.GO5783@atomide.com>
 <1310723274.26087.38.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19089 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965320Ab1GOK4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 06:56:03 -0400
Content-Disposition: inline
In-Reply-To: <1310723274.26087.38.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <J.Weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sshtylyov@mvista.com>

* Jan Weitzel <J.Weitzel@phytec.de> [110715 02:42]:
> Am Freitag, den 15.07.2011, 00:50 -0700 schrieb Tony Lindgren:
> > Well we can add it even before device tree support if it makes
> > sense from code coalescing point of view. In this case it would
> > mean creating board-panda-common.c or similar so the code can
> > be shared amongst the panda variants.
> > 
> > It seems that some GPIO pins are different and there are some
> > difference in devices connected, but big parts of the code can be
> > shared.
> > 
> > Adding the pending boards without combining code would be adding code
> > that will be going away for most part with the device tree support.
> > 
> > And most likely the beagle and panda based boards will be the first
> > ones to work with device tree. So anything we can do to have common
> > board init code will also help with this effort.
> > 
> > Regards,
> > 
> > Tony
> pcm049 and panda board have some more different devices.
> I am working on patches to add NAND support and using tlv320aic3x audio
> codec which need regulators in platformcode. I need a hack to controll
> usb otg by gpio (controlling a external power circuit). The patches are
> not mainline ready by now. 

OK, let's figure out how we can add the basic support first then.

> If using machine_is_xxxx() in board-omap4panda.c then also is good way,
> I could provide our board as patches on top of board-omap4panda.c.
> When will pandaboard use device tree to boot?

Yes, but it would better just to use separate .init_machine entries to
initialize thing. Gpio entries can be initialized along the lines of the
recent beagle commit 5fe8b4c19dc24e3bb873daf9e96a2439a83bbd79 that adds
support for beagl xm board. Except you already have a separate machine_id,
so no runtime detection is needed.

That avoids adding the machine_is entries all over the place that tend
to cause problems when some other panda variant is added as it requires
patching in multiple places.

Regards,

Tony
